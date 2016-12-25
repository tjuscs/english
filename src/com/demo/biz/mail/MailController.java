package com.demo.biz.mail;

import com.demo.biz.interceptors.MenuInterceptors;
import com.demo.common.model.Email;
import com.jfinal.aop.Before;
import com.jfinal.core.Controller;

/**
 * Created by yanz on 2016/8/22.
 */

@Before(MenuInterceptors.class)
public class MailController extends Controller {

    public void index() {
        render("mail.ftl");
    }

    @Before(MailValidator.class)
    public void add() {
        getModel(Email.class).save();
        setAttr("msg", "您的意见已提交,相关人员正在火速处理中...");
        index();
    }
}
