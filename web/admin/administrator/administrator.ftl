<#include "../core/_layout.ftl"/>
<@layout>

<div class="am-cf admin-main">

<#--渲染左侧菜单-->
    <#include "/admin/core/_sidebar.ftl"/>

    <!-- content start -->
<div class="admin-content">
<div class="admin-content-body">
    <div class="am-cf am-padding am-padding-bottom-0">
        <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">老师管理</strong> /
            <small>总览</small>
        </div>
    </div>

    <hr/>

    <div class="am-g" id="administrator-form" style="display: none" :style="{display:show}">
        <div class="am-u-sm-12 am-u-md-12">
            <form class="am-form am-form-inline">
                <fieldset>
                    <legend>管理员详情</legend>
                    <div class="am-form-group" style="display: none">
                        <input type="text" v-model="currentItem.id">
                    </div>

                    <div class="am-form-group am-form-icon am-form-feedback"
                         :class="{'am-form-error':!currentItem.account, 'am-form-success':!!currentItem.account}">
                        <label>账号</label>
                        <input class="am-form-field am-input-sm" type="text" v-model="currentItem.account"
                               placeholder="输入账号" :disabled="currentItem.id">
                        <span :class="{'am-icon-check':!!currentItem.account, 'am-icon-times':!currentItem.account}"></span>
                    </div>

                    <div class="am-form-group am-form-icon am-form-feedback"
                         :class="{'am-form-error':!currentItem.name, 'am-form-success':!!currentItem.name}">
                        <label>描述</label>
                        <input class="am-form-field am-input-sm" type="text" v-model="currentItem.name"
                               placeholder="描述">
                        <span :class="{'am-icon-check':!!currentItem.name, 'am-icon-times':!currentItem.name}"></span>
                    </div>

                    <div class="am-form-group am-form-icon am-form-feedback">
                        <label>密码</label>
                        <input class="am-form-field am-input-sm" type="password" v-model="currentItem.password"
                               placeholder="密码">
                    </div>

                    <p>
                        <button type="button" class="am-btn am-btn-primary" @click="saveItem">保存</button>
                        <button type="button" class="am-btn am-btn-danger" @click="deleteItem">删除</button>
                        <button type="button" class="am-btn am-btn-default" @click="clearItem">取消</button>
                    </p>
                </fieldset>
            </form>
        </div>
    </div>

    <div class="am-g">
    <#--table内容-->
        <div class="am-u-sm-12">
            <table id="dt" class="am-table am-table-striped am-table-bordered am-table-compact am-text-nowrap display">
                <thead>
                <tr>
                    <th class="table-check">编号</th>
                    <th class="table-id">帐号</th>
                    <th class="table-title">描述</th>
                    <th class="table-title">密码</th>
                    <th class="table-type">操作</th>
                </tr>
                </thead>
            </table>
        </div>
    </div>

    <link rel="stylesheet" type="text/css" href="/assets/dataTables/amazeui.datatables.min.css">
    <script type="text/javascript" charset="utf8" src="/assets/dataTables/amazeui.datatables.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="/assets/js/vue.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="/assets/js/vue-resource.min.js"></script>

    <script type="text/javascript">
        $(function () {
            var administratorData = {
                currentItem: null
            };
            var table = $('#dt').DataTable({
                "ajax": {
                    "url": "/admin/administrator/list",
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
                    {"data": "account"},
                    {"data": "name"},
                    {"data": "password"},
                    {"data": ""}
                ],
                "columnDefs": [{
                    "targets": -1,
                    "data": null,
                    "defaultContent": '<div class="am-btn-toolbar"> <div class="am-btn-group am-btn-group-xs"> <button class="am-btn am-btn-default am-btn-xs am-text-secondary"><span class="am-icon-pencil-square-o"></span> 编辑 </button></div>'
                }]
            });
            $('#dt tbody').on('click', 'tr', function () {
//                administratorData.currentItem = table.row($(this).parents('tr')).data();
                if ($(this).hasClass('selected')) {
//                    administratorData.currentItem =null;
                    $(this).removeClass('selected');
                }
                else {
                    table.$('tr.selected').removeClass('selected');
                    $(this).addClass('selected');
                }
            });

            $('#dt tbody').on('click', 'button', function (event) {
                event.stopPropagation();
                event.preventDefault();
                var data = table.row($(this).parents('tr')).data();
                administratorData.currentItem = data;
                console.log(data)
            });

            $("div.am-btn-toolbar").html('<div class="am-btn-group am-btn-group-xs"><button id="btn-add" type="button" class="am-btn am-btn-default"><span class="am-icon-plus"></span>新增 </button></div>');

            $("#btn-add").on('click', function () {
                administratorData.currentItem = {};
            })

            new Vue({
                http: {
                    root: '/admin/administrator',
                },
                el: "#administrator-form",
                data: administratorData,
                methods: {
                    "saveItem": function () {
                        this.$http.post('save', this.currentItem).then(function (json) {
                            this.currentItem = null;
                            table.draw();
                            layer.alert('操作成功');
                        }, function (json) {
                            layer.alert('操作失败，请重试');
                        });

                    },
                    "deleteItem": function () {
                        this.$http.get('delete', {
                            params: {id: this.currentItem.id}
                        }).then(function (json) {
                            this.currentItem = null;
                            table.draw();
                            layer.alert('操作成功');
                        }, function (json) {
                            layer.alert('操作失败，请重试');
                        });

                    },
                    "clearItem": function () {
                        this.currentItem = null;
                    }
                },
                computed: {
                    show: function () {
                        return !this.currentItem ? 'none' : 'block';
                    }
                }
            });
        });
    </script>
</@layout>
