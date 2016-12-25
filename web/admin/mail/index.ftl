<#include "../core/_layout.ftl"/>
<@layout>

<div class="am-cf admin-main">

<#--渲染左侧菜单-->
    <#include "/admin/core/_sidebar.ftl"/>

    <!-- content start -->
<div class="admin-content">
<div class="admin-content-body">
    <div class="am-cf am-padding am-padding-bottom-0">
        <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">院长信箱管理</strong> /
            <small>总览</small>
        </div>
    </div>

    <hr/>

<#--<div class="am-g" id="administrator-form" style="display: none" :style="{display:show}">-->
<#--<div class="am-u-sm-12 am-u-md-12">-->
<#--<form class="am-form am-form-inline">-->
<#--<fieldset>-->
<#--<legend>院长信箱详情</legend>-->
<#--<div class="am-form-group" style="display: none">-->
<#--<input type="text" v-model="currentItem.id">-->
<#--</div>-->

<#--<div class="am-form-group am-form-icon am-form-feedback"-->
<#--:class="{'am-form-error':!currentItem.account, 'am-form-success':!!currentItem.account}">-->
<#--<label>标题</label>-->
<#--<input class="am-form-field am-input-sm" type="text" v-model="currentItem.title"-->
<#--placeholder="输入标题" disabled>-->
<#--</div>-->

<#--<div class="am-form-group am-form-icon am-form-feedback">-->
<#--<label>联系邮箱</label>-->
<#--<input class="am-form-field am-input-sm" type="email" v-model="currentItem.email"-->
<#--placeholder="联系邮箱">-->
<#--</div>-->
<#--<div class="am-form-group am-form-icon am-form-feedback">-->
<#--<label>内容</label>-->
<#--<textarea class="am-form-field" type="text" v-model="currentItem.content"-->
<#--placeholder="内容" cols="40" rows="10"></textarea>-->
<#--</div>-->
<#--<p>-->
<#--<button type="button" class="am-btn am-btn-danger" @click="deleteItem">删除</button>-->
<#--<button type="button" class="am-btn am-btn-default" @click="clearItem">取消</button>-->
<#--</p>-->
<#--</fieldset>-->
<#--</form>-->
<#--</div>-->
<#--</div>-->

    <div class="am-g">
    <#--table内容-->
        <div class="am-u-sm-12">
            <table id="dt" class="am-table am-table-striped am-table-bordered am-table-compact am-text-nowrap display">
                <thead>
                <tr>
                    <th class="table-check">编号</th>
                    <th class="table-id">标题</th>
                <#--<th class="table-title">内容</th>-->
                    <th class="table-title">联系邮箱</th>
                    <th class="table-type">操作</th>
                </tr>
                </thead>
            </table>
        </div>
    </div>

    <link rel="stylesheet" type="text/css" href="/assets/dataTables/amazeui.datatables.min.css">
    <script type="text/javascript" charset="utf8" src="/assets/dataTables/amazeui.datatables.min.js"></script>
<#--<script type="text/javascript" charset="utf-8" src="/assets/js/vue.min.js"></script>-->
<#--<script type="text/javascript" charset="utf-8" src="/assets/js/vue-resource.min.js"></script>-->

    <script type="text/javascript">
        $(function () {
            var administratorData = {
                currentItem: null
            };
            var table = $('#dt').DataTable({
                "ajax": {
                    "url": "/admin/mail/list",
                    "dataSrc": function (json) {
                        json.data = json.list
                        json.recordsTotal = json.totalRow
                        json.recordsFiltered = json.totalRow
                        return json.data;
                    }
                },
                searchDelay: 350,
                processing: true,
                serverSide: true,
                "dom": '<"am-g am-datatable-hd" <"am-u-sm-6" <"am-btn-toolbar">> <"am-u-sm-6"f>>lrt<"am-g am-datatable-footer" <"am-u-sm-5"i> <"am-u-sm-7"p>>',
                "autoWidth": true,
                "columns": [
                    {"data": "id"},
                    {"data": "title"},
//                    {"data": "content"},
                    {"data": "email"},
                    {"data": ""}
                ],
                "columnDefs": [{
                    "targets": -1,
                    "data": null,
                    "defaultContent": '<div class="am-btn-toolbar"> <div class="am-btn-group am-btn-group-xs"> ' +
                    '<button class="am-btn am-btn-danger am-btn-xs"><span class="am-icon-pencil-square-o"></span> 删除 </button>' +
                    '<button class="am-btn am-btn-success am-btn-xs"><span class="am-icon-pencil-square-o"></span> 查看内容 </button>' +
                    '</div>'
                }]
            });
//            $('#dt tbody').on('click', 'tr', function () {
////                administratorData.currentItem = table.row($(this).parents('tr')).data();
//                if ($(this).hasClass('selected')) {
////                    administratorData.currentItem =null;
//                    $(this).removeClass('selected');
//                }
//                else {
//                    table.$('tr.selected').removeClass('selected');
//                    $(this).addClass('selected');
//                }
//            });

            $('#dt tbody').on('click', 'button', function (event) {
                event.stopPropagation();
                event.preventDefault();
                var data = table.row($(this).parents('tr')).data();
                if ($(this).hasClass("am-btn-danger")) {


                    layer.confirm('确定删除？', {
                        btn: ['确定', '取消'] //按钮
                    }, function () {
                        $.get("/admin/mail/delete?id=" + data.id, function (data) {
                            layer.msg('删除成功', {icon: 1});
                            table.draw();
                        })
                    });
                } else if ($(this).hasClass("am-btn-success")) {
                    layer.alert('<h1>标题: ' + data.title + '</h1><p>内容: ' + data.content + '</p>')

                }
            });

//            new Vue({
//                http: {
//                    root: '/admin/mail',
//                },
//                el: "#administrator-form",
//                data: administratorData,
//                methods: {
//                    "deleteItem": function () {
//                        this.$http.get('delete', {
//                            params: {id: this.currentItem.id}
//                        }).then(function (json) {
//                            this.currentItem = null;
//                            table.draw();
//                            layer.alert('操作成功');
//                        }, function (json) {
//                            layer.alert('操作失败，请重试');
//                        });
//
//                    },
//                    "clearItem": function () {
//                        this.currentItem = null;
//                    }
//                },
//                computed: {
//                    show: function () {
//                        return !this.currentItem ? 'none' : 'block';
//                    }
//                }
//            });
        });
    </script>
</@layout>
