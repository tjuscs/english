package com.demo.biz.admin;

import com.demo.biz.interceptors.AuthInterceptor;
import com.demo.common.model.User;
import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.ext.interceptor.SessionInViewInterceptor;
import com.jfinal.plugin.activerecord.Page;

/**
 * Created by YanZ on 16/9/30.
 */
@Before({AuthInterceptor.class, SessionInViewInterceptor.class})
public class UserController extends Controller {

    public void index() {
        Page<User> userList = User.dao.paginate(1, 10);
        renderJson(userList);
    }
}
