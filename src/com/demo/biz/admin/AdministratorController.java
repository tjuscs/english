package com.demo.biz.admin;

import com.demo.biz.builders.DataTable;
import com.demo.biz.interceptors.AuthInterceptor;
import com.demo.common.model.Admin;
import com.demo.common.model.AdminPrivileges;
import com.demo.common.model.Category;
import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.ext.interceptor.SessionInViewInterceptor;
import com.jfinal.kit.HttpKit;
import com.jfinal.kit.JsonKit;
import com.jfinal.kit.StrKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import org.apache.commons.codec.digest.DigestUtils;

import java.sql.PreparedStatement;
import java.util.List;
import java.util.Optional;

/**
 * Created by YanZ on 16/9/30.
 */
@Before({AuthInterceptor.class, SessionInViewInterceptor.class})
public class AdministratorController extends Controller {

    public void index() {
        render("administrator.ftl");
    }

    public void privileges() {
        render("privileges.ftl");
    }

    public void list() {
        //解析页面传递参数，构建dataTables参数
        DataTable params = DataTable.build(this);

        //模糊查询
        StringBuilder sb = new StringBuilder("from admin ");
        Object[] selectParams = new Object[0];
        if (StrKit.notBlank(params.getSearchValue())) {
            sb.append("where id like ? or account like ? or name like ? ");
            String value = "%" + params.getSearchValue() + "%";
            selectParams = new Object[]{value, value, value};
        }
        sb.append("order by " + params.getOrderColumn() + " " + params.getOrderDirection());
        Page<Admin> adminList = Admin.dao.paginate(params.getPageNumber(), params.getPageSize(), "select *", sb.toString(), selectParams);
        renderJson(adminList);
    }

    public void save() {
        Admin model = JsonKit.parse(HttpKit.readData(getRequest()), Admin.class);
        model.setPassword(DigestUtils.md5Hex(model.getPassword()));
        if (model.getId() != null) {
            model.update();
        } else {
            model.save();
        }
        renderJson(model);
    }

    public void delete() {
        //超级管理员不能删除
        if (getParaToInt("id") == 1) {
            getResponse().setStatus(500);
            renderJson();
            return;
        }

        try {
            Admin.dao.deleteById(getParaToInt("id"));
        } catch (Exception e) {
            getResponse().setStatus(500);
        }
        renderJson();
    }

    public void adminPrivileges() {
        //查询权限
        if (getParaToInt("id") != null && getRequest().getMethod().toUpperCase().equals("GET")) {
            Optional<AdminPrivileges> p = Optional.ofNullable(AdminPrivileges.dao.findFirst("select privileges from admin_privileges where user_id = ?", getParaToInt("id")));
            renderJson(p.isPresent() ? p.get().getPrivileges() : "[]");
        } else if (getRequest().getMethod().toUpperCase().equals("POST")) { //更新用户权限
            AdminPrivileges data = JsonKit.parse(HttpKit.readData(getRequest()), AdminPrivileges.class);
            Db.execute(conn -> {
                PreparedStatement preparedStatement = conn.prepareStatement("replace into admin_privileges values (?, ?)");
                preparedStatement.setInt(1, data.getUserId());
                preparedStatement.setString(2, data.getPrivileges());
                preparedStatement.execute();
                preparedStatement.close();
                return true;
            });
            renderJson();
        }

    }

    public void categories() {
        List<Category> categories = Category.dao.find("select id, name from category where parent_id is null");
        renderJson(categories);
    }

}
