package com.demo.biz.page;

import com.demo.biz.interceptors.MenuInterceptors;
import com.demo.biz.interceptors.SubMenuInterceptor;
import com.demo.common.model.News;
import com.demo.common.model.RecommendedSite;
import com.jfinal.aop.Before;
import com.jfinal.core.ActionKey;
import com.jfinal.core.Controller;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by yanz on 2016/8/22.
 */
@Before(MenuInterceptors.class)
public class PageController extends Controller {

    private static final int TYPE_NOTICE_NEWS = 33;
    private static final int TYPE_NORMAL_NEWS = 32;

    /**
     * 主页渲染逻辑
     */
    @ActionKey("/")
    public void index() {
//        List<News> newsOnBanner = News.dao.find("select * from news where type = 82 and top = true and verified = 1 order by createtime desc");
//        setAttr("banner_news", newsOnBanner);
        List<News> noticeNews = getNews(TYPE_NOTICE_NEWS, 3, false);
        setAttr("notice_news", noticeNews);


        List<News> normalNews = getNews(TYPE_NORMAL_NEWS, 6, false);
        if(normalNews.size() > 3){
            setAttr("banner_news",normalNews.subList(0,3));
            setAttr("normal_news", normalNews.subList(3,normalNews.size()));
        }else {
            setAttr("banner_news",normalNews);
        }

//        setAttr("recommended_site", RecommendedSite.dao.find("select * from recommended_site"));
        render("index.ftl");
    }

    private List<News> getNews(int type, int size, boolean needImg) {
        List<News> newsList;
        if (!needImg) {
            newsList = News.dao.find("select id,title,overview,img from news where type = ? and top = ? and verified = 1 order by createtime desc", type, 1);
            if (newsList.size() < size) {
                newsList.addAll(News.dao.find("select id,title,overview,img from news where type = ? and top = ? and verified = 1 order by createtime desc", type, 0));
            }
        } else {
            newsList = News.dao.find("select id,title,overview,img from news where type = ? and top = ? and img is not null and verified = 1 order by createtime desc", type, 1);
            if (newsList.size() < size) {
                newsList.addAll(News.dao.find("select id,title,overview,img from news where type = ? and top = ? and img is not null and verified = 1 order by createtime desc", type, 0));
            }
        }
        if (newsList.size() > size) {
            newsList = newsList.subList(0, size);
        }
        return newsList;
    }

    /**
     * 渲染验证码
     */
    @ActionKey("/captcha")
    public void captcha() {
        renderCaptcha();
    }

    @ActionKey("/organization")
    @Before({MenuInterceptors.class, SubMenuInterceptor.class})
    public void organization() {
        render("/front/content/organization.ftl");
    }


    @ActionKey("/history")
    @Before({MenuInterceptors.class, SubMenuInterceptor.class})
    public void history() {
        render("/front/content/history.ftl");
    }
}
