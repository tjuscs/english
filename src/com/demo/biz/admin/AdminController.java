package com.demo.biz.admin;

import com.demo.biz.interceptors.AuthInterceptor;
import com.demo.common.model.Admin;
import com.demo.common.model.AdminPrivileges;
import com.jfinal.aop.Before;
import com.jfinal.aop.Clear;
import com.jfinal.core.Controller;
import com.jfinal.ext.interceptor.SessionInViewInterceptor;

import java.util.Arrays;
import java.util.LinkedList;
import java.util.List;
import java.util.Optional;

/**
 * Created by YanZ on 16/9/30.
 */
@Before({AuthInterceptor.class, SessionInViewInterceptor.class})
public class AdminController extends Controller {

    public static final String USER_KEY = "user";
    public static final String USER_PRIVILEGES_KEY = "userPrivileges";

    /**
     * 后台管理页面
     */
    @Clear(AuthInterceptor.class)
    public void index() {
        if (isLogin()) {
            render("index.ftl");
        } else {
            render("login.ftl");
        }
    }

    /**
     * ajax处理用户登陆验证逻辑
     */
    @Clear(AuthInterceptor.class)
    public void login() {
        //验证码
        if (!validateCaptcha("captcha")) {
            renderJson("verify", false);
            return;
        }
        //验证用户登陆是否成功
        Optional<Admin> admin = Optional.ofNullable(Admin.dao.findFirst("select * from admin where account = ? and password = md5(?)", getPara("user.account"), getPara("user.password")));
        if (admin.isPresent()) {
            setSessionAttr(USER_KEY, admin.get());
            //检查用户权限并存入session
            Optional<AdminPrivileges> privileges = Optional.ofNullable(AdminPrivileges.dao.findById(admin.get().getId()));
            if (privileges.isPresent()) {
                List<String> strings = new LinkedList<>(Arrays.asList(privileges.get().getPrivileges().substring(1, privileges.get().getPrivileges().length() - 1).split(",")));
                if (strings.contains("2")) {
                    strings.add("14");
                }
                if (strings.contains("4")) {
                    strings.add("30");
                }
                String[] res = new String[strings.size()];
                setSessionAttr(USER_PRIVILEGES_KEY, strings.toArray(res));
            } else {
                setSessionAttr(USER_PRIVILEGES_KEY, "");
            }

            renderJson("verify", true);
        } else {
            renderJson("verify", false);
        }
    }

    /**
     * ajax处理用户登出逻辑
     */
//	@ActionKey("/logout")
    @Clear(AuthInterceptor.class)
    public void logout() {
        removeSessionAttr(USER_KEY);
        redirect("/admin");
    }


    /**
     * 判断当前用户是否已经登陆
     *
     * @return true|false
     */
    private boolean isLogin() {
        return getSessionAttr(USER_KEY) != null;
    }

}
