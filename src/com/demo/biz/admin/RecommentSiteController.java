package com.demo.biz.admin;


import com.demo.biz.builders.DataTable;
import com.demo.biz.interceptors.AuthInterceptor;
import com.demo.common.model.RecommendedSite;
import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.ext.interceptor.SessionInViewInterceptor;
import com.jfinal.kit.HttpKit;
import com.jfinal.kit.JsonKit;
import com.jfinal.kit.StrKit;
import com.jfinal.plugin.activerecord.Page;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by yanz on 2016/10/12.
 */
@Before({AuthInterceptor.class, SessionInViewInterceptor.class})
public class RecommentSiteController extends Controller {

    public void index() {
        render("index.ftl");
    }

    public void list() {
        //解析页面传递参数，构建dataTables参数
        DataTable params = DataTable.build(this);

        //模糊查询
        StringBuilder sb = new StringBuilder("from recommended_site where 1=1 ");
        List<String> selectParams = new ArrayList<>();
        if (StrKit.notBlank(params.getSearchValue())) {
            sb.append("and name like ?");
            String value = "%" + params.getSearchValue() + "%";
            selectParams.add(value);
        }
        if (StrKit.notBlank(getPara("columns[3][search][value]"))) {
            sb.append("and type = ?");
            selectParams.add(getPara("columns[3][search][value]"));
        }
        sb.append("order by " + params.getOrderColumn() + " " + params.getOrderDirection());
        Page<RecommendedSite> siteList = RecommendedSite.dao.paginate(params.getPageNumber(), params.getPageSize(), "select *", sb.toString(), selectParams.toArray());
        renderJson(siteList);
    }

    public void save() {
        RecommendedSite site = JsonKit.parse(HttpKit.readData(getRequest()), RecommendedSite.class);
        if (site.getId() != null) {

            site.update();
            site = site.findById(site.getId());
        } else {
            site.save();
        }
        renderJson(site);
    }

    public void delete() {
        try {
            RecommendedSite.dao.deleteById(getParaToInt("id"));
        } catch (Exception e) {
            getResponse().setStatus(500);
        }
        renderJson();
    }
}
