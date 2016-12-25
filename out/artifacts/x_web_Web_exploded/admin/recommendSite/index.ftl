<#include "../core/_layout.ftl"/>
<@layout>

<div class="am-cf admin-main">

<#--渲染左侧菜单-->
    <#include "/admin/core/_sidebar.ftl"/>

    <!-- content start -->
<div class="admin-content">
<div class="admin-content-body">
    <div class="am-cf am-padding am-padding-bottom-0">
        <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">链接管理</strong> /
            <small>总览</small>
        </div>
    </div>

    <hr/>

    <div class="am-g">
        <div class="am-u-sm-2" style="border-right: 1px solid #eeeeee;">
            <h5 style="text-align: center">链接类型</h5>
            <hr>
        <#--树形菜单的渲染-->
            <ul class="am-tree am-tree-folder-select" role="tree" id="categoryTree">
                <li class="am-tree-branch am-hide" data-template="treebranch" role="treeitem"
                    aria-expanded="false">
                    <div class="am-tree-branch-header">
                        <button class="am-tree-branch-name">
                            <span class="am-tree-icon am-tree-icon-folder"></span>
                            <span class="am-tree-label"></span>
                        </button>
                    </div>
                    <ul class="am-tree-branch-children" role="group"></ul>
                    <div class="am-tree-loader" role="alert">加载中...</div>
                </li>
                <li class="am-tree-item am-hide" data-template="treeitem" role="treeitem">
                    <button class="am-tree-item-name">
                        <span class="am-tree-label"></span>
                    </button>
                </li>
            </ul>
        </div>
    <#--table内容-->
        <div class="am-u-sm-8">
            <table id="dt" class="am-table am-table-striped am-table-bordered am-table-compact am-text-nowrap display">
                <thead>
                <tr>
                    <th class="table-check">编号</th>
                    <th class="table-id">名称</th>
                    <th class="table-title">类别</th>
                    <th class="table-title">连接地址</th>
                </tr>
                </thead>
            </table>
        </div>

        <div class="am-u-sm-2">

            <form class="am-form am-form-inline" id="site-form">
                <fieldset>
                    <legend>链接详情</legend>
                    <div class="am-form-group" style="display: none">
                        <input type="text" v-model="currentItem.id">
                    </div>

                    <div class="am-form-group am-form-icon am-form-feedback">
                        <label>名称</label>
                        <input class="am-form-field am-input-sm" type="text"
                               v-model="currentItem.name"
                               placeholder="输入名称">
                        <span :class="{'am-icon-check':!!currentItem.name, 'am-icon-times':!currentItem.name}"></span>
                    </div>

                    <div class="am-form-group am-form-icon am-form-feedback">
                        <label>地址</label>
                        <input class="am-form-field am-input-sm" type="text" v-model="currentItem.url"
                               placeholder="输入地址">
                        <span :class="{'am-icon-check':!!currentItem.url, 'am-icon-times':!currentItem.url}"></span>
                    </div>

                    <p>
                        <button type="button" class="am-btn am-btn-primary" @click="saveItem">保存</button>
                        <button type="button" class="am-btn am-btn-danger" @click="deleteItem"
                                :disabled="!currentItem.id">删除
                        </button>
                    </p>
                </fieldset>
            </form>
        </div>
    </div>

    <link rel="stylesheet" type="text/css" href="/assets/dataTables/amazeui.datatables.min.css">
    <link rel="stylesheet" href="/assets/amazeui-tree/amazeui.tree.min.css">
    <script type="text/javascript" charset="utf8" src="/assets/dataTables/amazeui.datatables.min.js"></script>
    <script src="/assets/amazeui-tree/amazeui.tree.min.js"></script>
    <script src="/assets/js/vue2.0.js"></script>
    <script type="text/javascript" charset="utf-8" src="/assets/js/vue-resource.min.js"></script>

    <script type="text/javascript">
        $(function () {
            //渲染左侧树
            $('#categoryTree').tree({
                dataSource: function (option, callback) {
                    callback({
                        data: [
                            {title: '实验研究', type: 'item', id: 1},
                            {title: '精品课程', type: 'item', id: 2},
                            {title: '常用下载', type: 'item', id: 3},
                            {title: '校内链接', type: 'item', id: 4},
                            {title: '校外链接', type: 'item', id: 5}]
                    })
                },
                cacheItems: true,
                folderSelect: false
            });

            var vData = {
                currentItem: {
                    name: "",
                    url: ""
                },
                type: 1
            };

            $('#categoryTree').on('selected.tree.amui', function (event, d) {
                vData.type = d.target.id
                vData.currentItem = {}
                table.columns(3).search(d.target.id).draw()
            });

            $('#categoryTree').on('deselected.tree.amui', function (event, data) {
                table.columns(3).search("").draw()
            });

            var table = $('#dt').DataTable({
                "ajax": {
                    "url": "/admin/recommendSite/list",
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
                    {"data": "name"},
                    {
                        "data": "type",
                        "visible": false
                    },
                    {"data": "url"},
                ]
            });

            //单击一行数据,刷新右侧详细信息
            $('#dt tbody').on('click', 'tr', function () {
                vData.currentItem = table.row($(this)).data();
                if ($(this).hasClass('selected')) {
                    vData.currentItem = {};
                    $(this).removeClass('selected');
                }
                else {
                    table.$('tr.selected').removeClass('selected');
                    $(this).addClass('selected');
                }
            });

            //init vue component
            new Vue({
                http: {
                    root: '/admin/recommendSite',
                },
                el: "#site-form",
                data: vData,
                methods: {
                    "saveItem": function () {
                        this.currentItem.type = this.type
                        this.$http.post('save', this.currentItem).then(function (json) {
                            this.currentItem = {};
                            table.draw();
                            layer.alert('操作成功');
                        }, function (json) {
                            layer.alert('操作失败，请重试');
                        });

                    },
                    "deleteItem": function () {
                        var api = this.$http;
                        var params = {id: this.currentItem.id}
                        layer.confirm('确定删除？', {
                            btn: ['确定', '取消'] //按钮
                        }, function () {
                            api.get('delete', {
                                params: params
                            }).then(function (json) {
                                this.currentItem = {};
                                table.draw();
                                layer.alert('操作成功');
                            }, function (json) {
                                layer.alert('操作失败，请重试');
                            });
                        });
                    }
                }
            });

        });
    </script>
</@layout>
