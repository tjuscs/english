<#include "/front/common/_layout.ftl"/>
<#import "/front/common/_menu.ftl" as m/>
<#import "/front/common/_treemenu.ftl" as tm/>
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
                $('ul', this).stop().slideDown(200);
            },
            function () {
                $('ul', this).stop().slideUp(200);
            }
    );
</script>
<div class="middles" style="margin-top:18px;">
    <div id="sub_left">
        <@tm.type headType = headType/>
    </div>
    <div id="sub_right">
        <div id="news_position">现在位置：<span class="news_index"><a href="/">首页</a></span> &gt;&gt; ${contentType.name}
            &gt;&gt; 正文
        </div>

    <#--<link rel="stylesheet" type="text/css" href="/assets/css/default.css" />-->

        <link rel="stylesheet" type="text/css" href="/assets/css/component.css"/>
        <script src="/assets/js/modernizr.custom.js"></script>
        <div class="container">
            <div class="main" style="width: 500px;position: relative;margin: 0 auto;">
                <ul class="cbp_tmtimeline">

                    <li>
                        <time class="cbp_tmtime" datetime="2013-04-10 18:30"><span>1952</span></time>
                        <div class="cbp_tmicon cbp_tmicon-phone"></div>
                        <div class="cbp_tmlabel">
                            <p>天津大学硅酸盐工学专业建立，隶属化工系，先改为技术陶瓷专业又改为无机非金属材料专业；天津大学焊接专业建立，隶属机械系。</p>
                        </div>
                    </li>

                    <li>
                        <time class="cbp_tmtime" datetime="2013-04-11T12:04"><span>1956</span></time>
                        <div class="cbp_tmicon cbp_tmicon-screen"></div>
                        <div class="cbp_tmlabel">
                            <p>天津大学金属学热处理设备及车间专业成立，隶属于机械系</p>
                        </div>
                    </li>

                    <li>
                        <time class="cbp_tmtime" datetime="2013-04-13 05:36"><span>1958</span></time>
                        <div class="cbp_tmicon cbp_tmicon-mail"></div>
                        <div class="cbp_tmlabel">
                            <p>天津大学塑料工学专业成立，隶属化工系，后改为高分子材料专业</p>
                        </div>
                    </li>

                    <li>
                        <time class="cbp_tmtime" datetime="2013-04-13 05:36"><span>1962</span></time>
                        <div class="cbp_tmicon cbp_tmicon-mail"></div>
                        <div class="cbp_tmlabel">
                            <p>天津大学腐蚀与防护专业成立</p>
                        </div>
                    </li>

                    <li>
                        <time class="cbp_tmtime" datetime="2013-04-13 05:36"><span>1985</span></time>
                        <div class="cbp_tmicon cbp_tmicon-mail"></div>
                        <div class="cbp_tmlabel">
                            <p>天津大学材料科学与工程系成立，成为当时在国内首批建立材料系的高校之一</p>
                        </div>
                    </li>

                    <li>
                        <time class="cbp_tmtime" datetime="2013-04-13 05:36"><span>1993</span></time>
                        <div class="cbp_tmicon cbp_tmicon-mail"></div>
                        <div class="cbp_tmlabel">
                            <p>经教育部批准成立教育部重点实验室高温结构陶瓷研究所，1994年成为首批教育部重点实验室</p>
                        </div>
                    </li>

                    <li>
                        <time class="cbp_tmtime" datetime="2013-04-13 05:36"><span>1994</span></time>
                        <div class="cbp_tmicon cbp_tmicon-mail"></div>
                        <div class="cbp_tmlabel">
                            <p>经教育部批准成立形状记忆材料教育部工程研究中心</p>
                        </div>
                    </li>

                    <li>
                        <time class="cbp_tmtime" datetime="2013-04-13 05:36"><span>1997</span></time>
                        <div class="cbp_tmicon cbp_tmicon-mail"></div>
                        <div class="cbp_tmlabel">
                            <p>天津大学材料科学与工程学院成立，下设金属材料系、无机非金属材料系和高分子材料系；测试机构有分析中心</p>
                        </div>
                    </li>

                    <li>
                        <time class="cbp_tmtime" datetime="2013-04-13 05:36"><span>1998</span></time>
                        <div class="cbp_tmicon cbp_tmicon-mail"></div>
                        <div class="cbp_tmlabel">
                            <p>机械学院机械工程二系材料加工及自动化专业划入材料科学与工程学院，同时更名为材料加工及自动化系</p>
                        </div>
                    </li>

                    <li>
                        <time class="cbp_tmtime" datetime="2013-04-13 05:36"><span>2001</span></time>
                        <div class="cbp_tmicon cbp_tmicon-mail"></div>
                        <div class="cbp_tmlabel">
                            <p>经批准材料科学与工程学院增设材料化学专业，并设立材料化学系，同年，材料加工工程学科被遴选为国家重点学科</p>
                        </div>
                    </li>

                    <li>
                        <time class="cbp_tmtime" datetime="2013-04-13 05:36"><span>2002</span></time>
                        <div class="cbp_tmicon cbp_tmicon-mail"></div>
                        <div class="cbp_tmlabel">
                            <p>
                                全面推行“大学科”背景的材料科学与工程专业人才培养体系，将金属材料工程专业、无机非金属材料工程专业、高分子材料工程专业合并，成立材料科学与工程专业，同年开始按材料科学与工程专业招生</p>
                        </div>
                    </li>

                    <li>
                        <time class="cbp_tmtime" datetime="2013-04-13 05:36"><span>2007</span></time>
                        <div class="cbp_tmicon cbp_tmicon-mail"></div>
                        <div class="cbp_tmlabel">
                            <p>材料学被遴选为国家重点学科，材料科学与工程一级学科被认定为国家一级学科重点学科</p>
                        </div>
                    </li>

                    <li>
                        <time class="cbp_tmtime" datetime="2013-04-13 05:36"><span>2008</span></time>
                        <div class="cbp_tmicon cbp_tmicon-mail"></div>
                        <div class="cbp_tmlabel">
                            <p>经教育部批准形状记忆材料教育部工程研究中心更名为材料复合与功能化教育部工程研究中心； 经天津市批准成立天津市材料复合与功能化重点实验室、天津市现代连接技术重点实验室</p>
                        </div>
                    </li>

                    <li>
                        <time class="cbp_tmtime" datetime="2013-04-13 05:36"><span>2010</span></time>
                        <div class="cbp_tmicon cbp_tmicon-mail"></div>
                        <div class="cbp_tmlabel">
                            <p>国家启动实施“卓越工程师”教育培养计划。“材料科学与工程”、“材料成型及控制工程”于2011年入选国家首批卓越工程师教育培养计划专业</p>
                        </div>
                    </li>

                    <li>
                        <time class="cbp_tmtime" datetime="2013-04-13 05:36"><span>2011</span></time>
                        <div class="cbp_tmicon cbp_tmicon-mail"></div>
                        <div class="cbp_tmlabel">
                            <p>天津大学材料科学与工程学院开办战略性新兴产业专业—功能材料专业，该专业于2011年正式招生，材料化学专业于2011年停止本科生招生</p>
                        </div>
                    </li>

                    <li>
                        <time class="cbp_tmtime" datetime="2013-04-13 05:36"><span>2011</span></time>
                        <div class="cbp_tmicon cbp_tmicon-mail"></div>
                        <div class="cbp_tmlabel">
                            <p>天津大学与日本国立物质材料研究所（NIMS）成立天津大学-NIMS联合研究中心</p>
                        </div>
                    </li>

                    <li>
                        <time class="cbp_tmtime" datetime="2013-04-13 05:36"><span>2014</span></time>
                        <div class="cbp_tmicon cbp_tmicon-mail"></div>
                        <div class="cbp_tmlabel">
                            <p>天津大学材料科学与工程学院成立先进金属材料研究所，先进高分子材料研究所、先进陶瓷研究所、焊接与先进制造技术研究所及新能源材料研究所</p>
                        </div>
                    </li>
                </ul>

            </div>

        </div>
    </div>
    <div style="clear:both;"></div>
</div>
<div class="middles">
    <div id="copyRight">版权所有 © 天津大学材料科学与工程学院 2016新版上线<span></span></div>
    <div id="footer">联系地址：天津市海河教育园区雅观道135号31号教学楼 [<a href="http://l.map.qq.com/11222015482?m"
                                                     target="_blank">查看学院地图标注</a>]，邮政编码：300350<br>联系电话：022-27403405
        传真：022-XXXXXXXX 电子邮件：mseic@tju.edu.cn
    </div>
</div>

</@layout>