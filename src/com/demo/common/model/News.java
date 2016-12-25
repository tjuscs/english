package com.demo.common.model;

import com.demo.common.model.base.BaseNews;
import com.jfinal.plugin.activerecord.Page;

/**
 * Created by tjliqy on 2016/10/11.
 */
public class News extends BaseNews<News> {
    public static final News dao = new News();

    public Page<News> paginate(int pageNumber, int pageSize) {
        return paginate(pageNumber, pageSize, "select *", "from news order by id asc");
    }
}
