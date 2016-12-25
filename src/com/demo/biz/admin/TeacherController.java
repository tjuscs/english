package com.demo.biz.admin;

import com.demo.biz.builders.DataTable;
import com.demo.biz.interceptors.AuthInterceptor;
import com.demo.common.model.User;
import com.demo.common.util.StringUtil;
import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.ext.interceptor.SessionInViewInterceptor;
import com.jfinal.kit.HttpKit;
import com.jfinal.kit.JsonKit;
import com.jfinal.kit.StrKit;
import com.jfinal.plugin.activerecord.Page;
import org.apache.commons.codec.digest.DigestUtils;

/**
 * Created by YanZ on 16/9/30.
 */
@Before({AuthInterceptor.class, SessionInViewInterceptor.class})
public class TeacherController extends Controller {

    public void index() {
        render("teacher.ftl");
    }

    public void list() {
        //解析页面传递参数，构建dataTables参数
        DataTable params = DataTable.build(this);

        //模糊查询
        StringBuilder sb = new StringBuilder("from user ");
        Object[] selectParams = new Object[0];
        if (StrKit.notBlank(params.getSearchValue())) {
            sb.append("where id like ? or account like ? or name like ? ");
            String value = "%" + params.getSearchValue() + "%";
            selectParams = new Object[]{value, value, value};
        }
        sb.append("order by " + StringUtil.camel2Underscore(params.getOrderColumn()) + " " + params.getOrderDirection());
        Page<User> userList = User.dao.paginate(params.getPageNumber(), params.getPageSize(), "select id, account, name, job_title, laboratory, order_index, verified", sb.toString(), selectParams);
        renderJson(userList);
    }

    public void save() {
        User model = JsonKit.parse(HttpKit.readData(getRequest()), User.class);
        if (StrKit.notBlank(model.getPassword())) {
            model.setPassword(DigestUtils.md5Hex(model.getPassword()));
        } else {
            model.remove("password");
        }
        if (model.getId() != null) {
            model.update();
        } else {
            model.save();
        }
        renderJson(model);
    }

    public void delete() {
        try {
            User.dao.deleteById(getParaToInt("id"));
        } catch (Exception e) {
            getResponse().setStatus(500);
        }
        renderJson();
    }

    public void peek() {
        try {
            User model = User.dao.findById(getParaToInt());
            model.setPassword("");
            model.setAccount("");
            setAttr("teacher", model);
            String imgBase64 = JsonKit.toJson(model.getImg());
            String imgSrc = "data:image/jpeg;base64," + imgBase64.substring(1, imgBase64.length() - 1);
            setAttr("photo", imgSrc);
            render("teacherPeek.ftl");
        } catch (Exception ex) {
            renderError(404);
        }
    }

}
