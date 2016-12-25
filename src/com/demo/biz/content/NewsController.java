package com.demo.biz.content;

import com.demo.biz.interceptors.MenuInterceptors;
import com.demo.common.model.Category;
import com.demo.common.model.News;
import com.jfinal.aop.Before;
import com.jfinal.core.Controller;

@Before(MenuInterceptors.class)
public class NewsController extends Controller {

    public void index() {
        News news = News.dao.findById(getParaToInt());
        if (news.getVerified() == 1) {
            setAttr("news", news);

            Category hT = Category.dao.findById(news.getType());//最外层的板块

            setAttr("contentType", hT);
            while (hT.getParentId() != null) {
                hT = Category.dao.findById(hT.getParentId());
            }
            setAttr("headType", hT);
            render("detail.ftl");
        } else {
            renderError(404);
        }

    }

    public void search() {
        setAttr("page", News.dao.paginate(getParaToInt("page", 1), 15, "select *", "from news where title like ? and verified = 1", '%' + getPara("searchvalue") + '%'));
        setAttr("sv",getPara("searchvalue"));
        render("search.ftl");
    }
}
