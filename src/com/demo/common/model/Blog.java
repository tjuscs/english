package com.demo.common.model;

import com.demo.common.model.base.BaseBlog;
import com.jfinal.plugin.activerecord.Page;

/**
 * Generated by JFinal.
 */
@SuppressWarnings("serial")
public class Blog extends BaseBlog<Blog> {
    public static final Blog dao = new Blog();

    public Page<Blog> paginate(int pageNumber, int pageSize) {
        return paginate(pageNumber, pageSize, "select *", "from blog order by id asc");
    }

}
