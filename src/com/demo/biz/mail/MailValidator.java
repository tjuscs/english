package com.demo.biz.mail;

import com.demo.common.model.Email;
import com.jfinal.core.Controller;
import com.jfinal.validate.Validator;

/**
 * Created by yanz on 2016/8/22.
 */
public class MailValidator extends Validator {
    @Override
    protected void validate(Controller controller) {
        validateRequiredString("email.title", "titleMsg", "请输入标题!");
        validateRequiredString("email.content", "contentMsg", "请输入内容!");
        validateRequiredString("email.email", "mailMsg", "请输入邮箱!");
    }

    @Override
    protected void handleError(Controller controller) {
        controller.keepModel(Email.class);
//        String actionKey = getActionKey();
//        if (actionKey.equals("/blog/save"))
        controller.render("mail.ftl");
    }
}
