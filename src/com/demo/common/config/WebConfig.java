package com.demo.common.config;

import com.demo.biz.admin.*;
import com.demo.biz.content.ContentController;
import com.demo.biz.mail.MailController;
import com.demo.biz.page.PageController;
import com.demo.common.model._MappingKit;
import com.jfinal.config.*;
import com.jfinal.json.FastJsonFactory;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.ActiveRecordPlugin;
import com.jfinal.plugin.druid.DruidPlugin;
import com.jfinal.plugin.ehcache.EhCachePlugin;
import com.jfinal.render.ViewType;

/**
 * Created by yanz on 2016/8/20.
 */
public class WebConfig extends JFinalConfig {

    @Override
    public void configConstant(Constants me) {
        PropKit.use("db_config.properties");
        me.setViewType(ViewType.FREE_MARKER);
        me.setFreeMarkerViewExtension("ftl");
        me.setDevMode(PropKit.getBoolean("devMode", false));
        me.setJsonFactory(new FastJsonFactory());

        me.setI18nDefaultBaseName("i18n");
    }

    @Override
    public void configRoute(Routes me) {
        //页面渲染逻辑
        me.add("/", PageController.class, "/page");
        me.add("/blog", BlogController.class, "/front.blog");
        me.add("/content", ContentController.class, "/front/content");
        me.add("/mail", MailController.class, "/front/mail");
        me.add("/news", com.demo.biz.content.NewsController.class, "/front/content");
        me.add("/teacher", com.demo.biz.teacher.TeacherController.class, "/front/teacher");

        me.add("/admin", AdminController.class, "/admin");
        me.add("/admin/file", FileController.class, "/admin/file");
        me.add("/admin/user", UserController.class, "/admin");
        me.add("/admin/teacher", TeacherController.class, "/admin");
        me.add("/admin/administrator", AdministratorController.class, "/admin/administrator");
        me.add("/admin/blog", com.demo.biz.admin.BlogController.class, "/admin/blog");
        me.add("/admin/mail", com.demo.biz.admin.MailController.class, "/admin/mail");
        me.add("/admin/news", NewsController.class, "/admin/blog");
        me.add("/admin/recommendSite", RecommentSiteController.class, "/admin/recommendSite");
    }

    @Override
    public void configPlugin(Plugins me) {
        // 配置druid数据库连接池插件
        DruidPlugin druidPlugin = new DruidPlugin(PropKit.get("jdbcUrl"), PropKit.get("user"), PropKit.get("password").trim());
        me.add(druidPlugin);

        // 配置ActiveRecord插件
        ActiveRecordPlugin arp = new ActiveRecordPlugin(druidPlugin);
        me.add(arp);

        //配置Ehcache插件
        me.add(new EhCachePlugin());

        // 所有配置在 MappingKit 中搞定
        _MappingKit.mapping(arp);
    }

    @Override
    public void configInterceptor(Interceptors me) {
    }

    @Override
    public void configHandler(Handlers me) {

    }
}
