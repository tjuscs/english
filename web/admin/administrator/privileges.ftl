<#include "../core/_layout.ftl"/>
<@layout>

<div class="am-cf admin-main">

<#--渲染左侧菜单-->
    <#include "/admin/core/_sidebar.ftl"/>

    <!-- content start -->
<div class="admin-content">
<div class="admin-content-body">
    <div class="am-cf am-padding am-padding-bottom-0">
        <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">权限管理</strong> /
            <small>总览</small>
        </div>
    </div>

    <hr/>

    <div class="am-g">
    <#--table内容-->
        <div class="am-u-sm-8">
            <table id="dt" class="am-table am-table-striped am-table-bordered am-table-compact am-text-nowrap display">
                <thead>
                <tr>
                    <th class="table-check">编号</th>
                    <th class="table-id">帐号</th>
                    <th class="table-title">描述</th>
                </tr>
                </thead>
            </table>
        </div>
        <div class="am-u-sm-4" id="administrator-form">
            <form class="am-form am-form-inline">
                <fieldset>
                    <legend>管理员详情</legend>
                    <span>请按住键盘 "Ctrl+左键" 进行多选:</span>

                    <select v-model="privileges" multiple style="height: 300px;">
                        <option v-for="o in categories" :value="o.id">{{o.name}}</option>
                    </select>
                    <br>

                    <p>
                        <button type="button" class="am-btn am-btn-primary" @click="saveItem">保存</button>
                        <button type="button" class="am-btn am-btn-default" @click="clearItem">取消</button>
                    </p>
                </fieldset>
            </form>
        </div>
    </div>

    <link rel="stylesheet" type="text/css" href="/assets/dataTables/amazeui.datatables.min.css">
    <script type="text/javascript" charset="utf8" src="/assets/dataTables/amazeui.datatables.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="/assets/js/vue.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="/assets/js/vue-resource.min.js"></script>

    <script type="text/javascript">
        $(function () {
            var administratorData = {
                currentItem: null,
                categories: null,
                privileges: []
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
                "dom": '<"am-g am-datatable-hd" <"am-u-sm-6"> <"am-u-sm-6"f>>lrt<"am-g am-datatable-footer" <"am-u-sm-5"i> <"am-u-sm-7"p>>',
                "autoWidth": true,
                "columns": [
                    {"data": "id"},
                    {"data": "account"},
                    {"data": "name"},
                ]
            });
            $('#dt tbody').on('click', 'tr', function () {
//                administratorData.currentItem = table.row($(this).parents('tr')).data();
                if ($(this).hasClass('selected')) {
                    administratorData.currentItem = null;
                    $(this).removeClass('selected');
                }
                else {
                    table.$('tr.selected').removeClass('selected');
                    var data = table.row($(this)).data();
                    administratorData.currentItem = data;
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
                        this.$http.post('adminPrivileges', {
                            userId: this.currentItem.id,
                            privileges: this.privileges
                        }).then(function (json) {
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
                    "addOrRemove": function (item) {
                        console.log(item)
                    },
                    "clearItem": function () {
                        this.currentItem = null;
                    }
                }, created: function () {
                    this.$http.get("/admin/administrator/categories").then(
                            function (json) {
                                this.categories = json.data
                            });
                },
                watch: {
                    currentItem: function (newItem) {
                        if (newItem != null) {
                            this.$http.get('adminPrivileges', {params: {id: this.currentItem.id}}).then(function (json) {
                                this.privileges = json.data
                            }, function (json) {
                                layer.alert('读取权限失败，请重试');
                            })
                        } else {
                            this.privileges = []
                        }
                    }
                },
                computed: {}
            });
        });
    </script>
</@layout>
