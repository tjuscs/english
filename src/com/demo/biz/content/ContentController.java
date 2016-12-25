package com.demo.biz.content;

import com.demo.biz.interceptors.MenuInterceptors;
import com.demo.biz.interceptors.SubMenuInterceptor;
import com.demo.common.model.Blog;
import com.demo.common.model.Category;
import com.demo.common.model.News;
import com.jfinal.aop.Before;
import com.jfinal.core.Controller;

/**
 * Created by YanZ on 16/9/7.
 */
@Before(MenuInterceptors.class)
public class ContentController extends Controller {

    private static final int BLOG = 1;
    private static final int NEW = 3;


    @Before(SubMenuInterceptor.class)
    public void index() {
        Category category = getAttr("contentType");
        switch (category.getType().intValue()) {
            case BLOG:
                setAttr("blog", Blog.dao.findFirst("select * from blog where type = ?", category.getId()));
                break;
            case NEW:
                setAttr("page", News.dao.paginate(getParaToInt("page", 1), 15, "select *", "from news where type = ? and verified = 1 order by top desc, createtime desc", category.getId()));
                break;
        }
        render("content.ftl");
    }
//    @ActionKey("/detail/")
//    public void detail(){
//        Blog blog = Blog.dao.findById(getParaToInt());
//        setAttr("blog", blog);
//
//        Category hT = Category.dao.findById(blog.getType());//外层的板块
//        Category cT;//当前板块
//        if (hT.getParentId() == null){
//            cT = Category.dao.firstSubContentType(hT.getId());
//        }else {
//            cT = hT;
//        }
//        setAttr("contentType",cT);
//        while (hT.getParentId() != null){
//            hT = Category.dao.findById(hT.getParentId());
//        }
//        setAttr("headType",hT);
//        render("detail.ftl");
//    }

}
