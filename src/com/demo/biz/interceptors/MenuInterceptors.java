package com.demo.biz.interceptors;

import com.demo.common.model.Category;
import com.jfinal.aop.Interceptor;
import com.jfinal.aop.Invocation;

import java.util.List;

/**
 * Created by YanZ on 16/9/7.
 */
public class MenuInterceptors implements Interceptor {

    @Override
    public void intercept(Invocation inv) {
        List<Category> types = Category.dao.findByCache("commons", "menus", "select * from category where parent_id is null limit 10");
//		List<Category> types = Category.dao.find("select * from category where parent_id is null limit 10");
        inv.getController().setAttr("types", types);
        inv.invoke();
    }
}
