<#include "/front/common/_layout.ftl"/>
<#import "/front/common/_menu.ftl" as m/>
<@layout>
<link href="/assets/css/2015_default2.css" rel="stylesheet" type="text/css" media="all">
<!--推荐站点--需JQquery文件-->
<script type="text/javascript">
    $(document).ready(function () {
        var mod_menu = $(".mod-menu");//导航模块区
        var menu = function () {
            var menuItem = $(".menu-item li");//选择导航列表
            menuItem.each(function () {
                var _index = $(this).index();//获取当前选择菜单列表的索引
                $(this).mouseenter(function () {
                    var y = $(this).position().top + 1;//获取当前鼠标滑过的列表的顶部坐标
                    $(".menu-cont").show();
                    $(".menu-cont").css("top", y);//需要显示的对应索引内容
                    $(this).addClass("mouse-bg").siblings().removeClass("mouse-bg");
                    $(".menu-cont>div").eq(_index).show().siblings().hide();
                });
            });
            /*导航菜单菜单*/
            $(".mod-menu").mouseleave(function () {
                $(".menu-cont").hide();
                menuItem.removeClass("mouse-bg");
            })
        }//展开二级菜单
        menu();//执行展开二级菜单函
    });
</script>

<div class="wrap">
    <div class="middles">
        <div id="banner">
            <div class="language"><a href="http://211.81.54.98/english/" target="_blank">English</a></div>
        </div>
    <#--渲染菜单头部-->
        <@m.menu menuItems = types/>
    </div>

</div>

<script>
    $('nav li').hover(
            function () {
                3
                $('ul', this).stop().slideDown(200);
            },
            function () {
                $('ul', this).stop().slideUp(200);
            }
    );
</script>

<div class="middles" style="margin-top:18px;">
    <div>
        <form action="/mail/add" method="post">
            <fieldset class="solid" style="text-align: center">
                <legend>院长信箱</legend>
                <div>
                    <label>标题</label>
                    <input type="text" name="email.title" placeholder="请输入标题" value="${(email.title)!}"/>${titleMsg!}
                    <label for="email" style="padding-left: 2rem">您的邮箱</label>
                    <input name="email.email" type="email" id="email" placeholder="请输入邮箱"
                           value="${(email.email)!}">${mailMsg!}
                    <label>&nbsp;</label>
                    <input value="提交" type="submit">
                </div>
                <hr>
                <div>
                    <label>内容</label>
                    <textarea name="email.content" cols="80" rows="10"
                              placeholder="请输入内容">${(email.content)!}</textarea>${contentMsg!}
                </div>
                <h1 style="text-align: center;">${(msg)!}</h1>
                <hr>
            </fieldset>
        </form>
    </div>
</div>
<div class="middles">
    <div id="copyRight">版权所有 © 天津大学材料科学与工程学院 2015新版上线 总访问量：<span></span></div>
    <div id="footer">联系地址：天津市海河教育园区雅观道135号31号教学楼 [<a href="http://l.map.qq.com/11222015482?m"
                                                     target="_blank">查看学院地图标注</a>]，邮政编码：300350<br>联系电话：022-27403405
        传真：022-XXXXXXXX 电子邮件：mseic@tju.edu.cn
    </div>
</div>
<!-- 以上页面内容 开发时删除 -->
</@layout>