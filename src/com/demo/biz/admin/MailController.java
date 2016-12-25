package com.demo.biz.admin;

import com.demo.biz.builders.DataTable;
import com.demo.biz.interceptors.AuthInterceptor;
import com.demo.common.model.Email;
import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.ext.interceptor.SessionInViewInterceptor;
import com.jfinal.kit.StrKit;
import com.jfinal.plugin.activerecord.Page;

/**
 * Created by YanZ on 16/9/30.
 */
@Before({AuthInterceptor.class, SessionInViewInterceptor.class})
public class MailController extends Controller {

    public void index() {
        render("index.ftl");
    }

    public void list() {
        //解析页面传递参数，构建dataTables参数
        DataTable params = DataTable.build(this);

        //模糊查询
        StringBuilder sb = new StringBuilder("from email ");
        Object[] selectParams = new Object[0];
        if (StrKit.notBlank(params.getSearchValue())) {
            sb.append("where title like ? or content like ? or email like ? ");
            String value = "%" + params.getSearchValue() + "%";
            selectParams = new Object[]{value, value, value};
        }
        sb.append("order by " + params.getOrderColumn() + " " + params.getOrderDirection());
        Page<Email> emailList = Email.dao.paginate(params.getPageNumber(), params.getPageSize(), "select *", sb.toString(), selectParams);
        renderJson(emailList);
    }

    public void delete() {

        try {
            Email.dao.deleteById(getParaToInt("id"));
        } catch (Exception e) {
            getResponse().setStatus(500);
        }
        renderJson();
    }
}
