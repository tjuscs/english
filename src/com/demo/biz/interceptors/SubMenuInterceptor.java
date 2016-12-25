package com.demo.biz.interceptors;

import com.demo.common.model.Category;
import com.jfinal.aop.Interceptor;
import com.jfinal.aop.Invocation;

import java.util.Optional;

/**
 * should be used in content (http://domain.com/content/??) request
 */
public class SubMenuInterceptor implements Interceptor {
    @Override
    public void intercept(Invocation inv) {
        Optional<Integer> cid = Optional.ofNullable(inv.getController().getParaToInt());
        //检查是否传递参数
        if (!cid.isPresent()) {
            inv.getController().renderError(404);
        }
        //查询逻辑
        Category hT = Category.dao.findById(cid.get());//最外层的板块

        Category cT = hT;
        while (cT.getType() == 0 && cT.subContentTypes().size() != 0){
            cT = cT.subContentTypes().get(0);
        }
        inv.getController().setAttr("contentType", cT);

        while (hT.getParentId() != null) {
            hT = Category.dao.findById(hT.getParentId());
        }
        inv.getController().setAttr("headType", hT);

        inv.invoke();
    }
}
