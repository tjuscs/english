<!-- sidebar start -->
<div class="admin-sidebar am-offcanvas" id="admin-offcanvas">
    <div class="am-offcanvas-bar admin-offcanvas-bar">
        <ul class="am-list admin-sidebar-list">
            <li><a href="/" target="_blank"><span class="am-icon-home"></span> 首页</a></li>

        <#if session.userPrivileges?seq_contains("3")>
            <li><a href="/admin/teacher"><span class="am-icon-home"></span> 教师</a></li>
        </#if>
        <#--<#if session.userPrivileges?seq_contains("11")>-->
            <li><a href="/admin/news"><span class="am-icon-home"></span> 内容维护</a></li>
        <#--</#if>-->
            <li><a href="/admin/blog"><span class="am-icon-home"></span> 板块维护</a></li>

        <#--超级管理员才能管理后台-->
        <#if session.user.id == 1>
            <li class="admin-parent">
                <a class="am-cf" data-am-collapse="{target: '#admin-collapse'}"><span class="am-icon-file"></span>
                    后台管理 <span class="am-icon-angle-right am-fr am-margin-right"></span></a>
                <ul class="am-list am-collapse admin-sidebar-sub am-in" id="admin-collapse">
                    <li><a href="/admin/administrator"><span class="am-icon-table"></span> 管理员</a></li>
                    <li><a href="/admin/administrator/privileges"><span class="am-icon-pencil-square-o"></span> 权限管理</a>
                    </li>
                </ul>
            </li>
            <li><a href="/admin/mail"><span class="am-icon-sign-out"></span> 院长信箱</a></li>
            <li><a href="/admin/recommendSite"><span class="am-icon-sign-out"></span> 推荐站点</a></li>
        </#if>


            <li><a href="/admin/logout"><span class="am-icon-sign-out"></span> 注销</a></li>
        </ul>
    </div>
</div>
<!-- sidebar end -->