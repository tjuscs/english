package com.demo.biz.admin;

import com.demo.biz.builders.DataTable;
import com.demo.biz.interceptors.AuthInterceptor;
import com.demo.common.model.Blog;
import com.demo.common.model.Category;
import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.ext.interceptor.SessionInViewInterceptor;
import com.jfinal.kit.HttpKit;
import com.jfinal.kit.JsonKit;
import com.jfinal.kit.StrKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;

import java.util.ArrayList;
import java.util.List;

import static com.demo.biz.admin.AdminController.USER_PRIVILEGES_KEY;

/**
 * Created by YanZ on 16/10/3.
 */
@Before({AuthInterceptor.class, SessionInViewInterceptor.class})
public class BlogController extends Controller {

    public void index() {
        render("blog.ftl");
    }

    //此方法已经只在verify中需要
    public void list() {
        //解析页面传递参数，构建dataTables参数
        DataTable params = DataTable.build(this);

        //模糊查询
        StringBuilder sb = new StringBuilder("from blog where 1=1 ");
        List<String> selectParams = new ArrayList<>();
        if (StrKit.notBlank(params.getSearchValue())) {
            sb.append("and title like ?");
            String value = "%" + params.getSearchValue() + "%";
            selectParams.add(value);
        }
        if (StrKit.notBlank(getPara("columns[3][search][value]"))) {
            sb.append("and type = ?");
            selectParams.add(getPara("columns[3][search][value]"));
        }
        sb.append("order by " + params.getOrderColumn() + " " + params.getOrderDirection());
        Page<Blog> blogList = Blog.dao.paginate(params.getPageNumber(), params.getPageSize(), "select *", sb.toString(), selectParams.toArray());
        renderJson(blogList);
    }

    public void save() {
        Blog model = JsonKit.parse(HttpKit.readData(getRequest()), Blog.class);
        if (model.getId() != null) {
            model.remove("createtime", "updatetime");
            model.update();
            model = model.findById(model.getId());
        } else {
            model.save();
        }
        renderJson(model);
    }

    public void delete() {
        try {
            Blog.dao.deleteById(getParaToInt("id"));
        } catch (Exception e) {
            getResponse().setStatus(500);
        }
        renderJson();
    }

    public void detail() {
        Integer id = getParaToInt("id");
        if (id == null) {
            getResponse().setStatus(500);
            return;
        }
        Blog blog = Blog.dao.findFirst("select * from blog where type = ?", id);
        if (blog == null) {
            blog = new Blog();
            blog.setTitle("");
            blog.setType(id);
            blog.setContent("");
        }
        renderJson(blog);
    }

    public void content() {
        setAttr("id", getPara("id"));
        render("ueeditor.ftl");
    }

    //审核新闻
    public void verified() {
        Integer id = getParaToInt("id");
        Db.update("update blog set verified = 1 where id = ?", id);
        renderJson();
    }

    public void categories() {
        List<Category> categories = Category.dao.find("select id, parent_id, name from category where type = 1");
        String[] privileges = getSessionAttr(USER_PRIVILEGES_KEY);
        categories = NewsController.filteredCategories(categories, privileges);

        renderJson(categories);
    }
}
