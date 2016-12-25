package com.demo.biz.interceptors;

import com.demo.biz.admin.AdminController;
import com.jfinal.aop.Interceptor;
import com.jfinal.aop.Invocation;
import com.jfinal.core.Controller;

/**
 * Created by YanZ on 16/10/4.
 */
public class AuthInterceptor implements Interceptor {

    @Override
    public void intercept(Invocation inv) {
        Controller controller = inv.getController();
        Object sessionAttr = controller.getSessionAttr(AdminController.USER_KEY);
        if (sessionAttr != null) {
            inv.invoke();
        } else {
            controller.redirect("/admin");
        }
    }
}
