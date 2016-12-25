package com.demo.biz.admin;

import com.demo.biz.builders.DataTable;
import com.demo.biz.interceptors.AuthInterceptor;
import com.demo.common.model.Category;
import com.demo.common.model.News;
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
import java.util.stream.Collectors;

import static com.demo.biz.admin.AdminController.USER_PRIVILEGES_KEY;

/**
 * Created by tjliqy on 2016/10/10.
 */
@Before({AuthInterceptor.class, SessionInViewInterceptor.class})
public class NewsController extends Controller {
    public static final List<Category> filteredCategories(List<Category> categories, String[] privileges) {
        return categories.stream().filter(category -> {
            for (String s : privileges) {
                if (category.getParentId() == Integer.valueOf(s) || category.getId().intValue() == Integer.valueOf(s))
                    return true;
            }
            return false;
        }).collect(Collectors.toList());
    }

    public void index() {
        render("news.ftl");
    }

    public void list() {

        //解析页面传递参数，构建dataTables参数
        DataTable params = DataTable.build(this);

        if (StrKit.isBlank(getPara("columns[3][search][value]"))) {
            renderJson(new Page<>(new ArrayList<News>(), params.getPageNumber(), params.getPageSize(), 0, 0));
            return;
        }

        //模糊查询
        StringBuilder sb = new StringBuilder("from news where 1=1 ");
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
        Page<News> newsList = News.dao.paginate(params.getPageNumber(), params.getPageSize(), "select *", sb.toString(), selectParams.toArray());
        renderJson(newsList);
    }

    public void save() {
        News model = JsonKit.parse(HttpKit.readData(getRequest()), News.class);
        if (model.getId() != null) {
            model.remove("updatetime", "type");
            model.update();
            model = model.findById(model.getId());
        } else {
            model.save();
        }
        renderJson(model);
    }

    public void delete() {
        try {
            News.dao.deleteById(getParaToInt("id"));
        } catch (Exception e) {
            getResponse().setStatus(500);
        }
        renderJson();
    }

    //查看新闻详细内容
    public void detail() {
        Integer id = getParaToInt("id");
        if (id == null) {
            getResponse().setStatus(500);
            return;
        }
        News news = News.dao.findById(id);
        if (news == null) {
            getResponse().setStatus(500);
            renderJson();
            return;
        }
        renderJson(news);
    }
    //打开查看新闻详情页面
    public void content() {
        setAttr("id", getPara("id"));
        setAttr("type", getParaToInt());
        render("ueeditor.ftl");
    }

    //审核新闻
    public void verified() {
        Integer id = getParaToInt("id");
        Boolean verified = getParaToBoolean("show", false);
        Db.update("update news set verified = ? where id = ?", verified, id);
        renderJson();
    }

    //置顶新闻
    public void top() {
        Integer id = getParaToInt("id");
        Boolean top = getParaToBoolean("top", false);
        Db.update("update news set top = ? where id = ?", top, id);
        renderJson();
    }

    public void categories() {
        List<Category> categories = Category.dao.find("select id, parent_id, name from category where type = 3");
        String[] privileges = getSessionAttr(USER_PRIVILEGES_KEY);
        categories = filteredCategories(categories, privileges);
        renderJson(categories);
    }
}
