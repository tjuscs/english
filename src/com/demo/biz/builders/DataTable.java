package com.demo.biz.builders;

import com.jfinal.core.Controller;

/**
 * Created by YanZ on 16/10/3.
 */
public class DataTable {

    private Integer pageSize;
    private Integer pageNumber;
    private String orderColumn;
    private String orderDirection;
    private String searchValue;

    private DataTable(Integer pageSize, Integer pageNumber, String orderColumn, String orderDirection, String searchValue) {
        this.pageSize = pageSize;
        this.pageNumber = pageNumber;
        this.orderColumn = orderColumn;
        this.orderDirection = orderDirection;
        this.searchValue = searchValue;
    }

    public static final DataTable build(Controller c) {
        Integer pageSize = c.getParaToInt("length", 10);
        int pageNumber = c.getParaToInt("start", 0) / pageSize + 1;
        String orderColumn = c.getPara("columns[" + c.getParaToInt("order[0][column]", 0) + "][data]", "id");
        String orderDirection = c.getPara("order[0][dir]", "desc");
        String searchValue = c.getPara("search[value]", "");
        return new DataTable(pageSize, pageNumber, orderColumn, orderDirection, searchValue);
    }

    public Integer getPageSize() {
        return pageSize;
    }

    public Integer getPageNumber() {
        return pageNumber;
    }

    public String getOrderColumn() {
        return orderColumn;
    }

    public String getOrderDirection() {
        return orderDirection;
    }

    public String getSearchValue() {
        return searchValue;
    }
}
