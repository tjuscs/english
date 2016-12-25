<#include "/front/common/_layout.ftl"/>
<#import "/front/common/_menu.ftl" as m/>
<@layout>

<link rel="stylesheet" href="/english/assets/css/amazeui.flat.min.css">
<link href="/english/assets/css/pages.css" rel="stylesheet">
<!--推荐站点--需JQquery文件-->

<div style="background:#f6f5f2;padding:15px 0px 10px 0px;">
    <div class="container">
        <div class="container-fluid">
            <div class="row-fluid">
                <div class="span2">
                    <div class="widget-container">
                        <h6 class="widget-title">Faculty&amp;Staff</h6>
                        <ul>
                            <li class="cat-item cat-item-3"><a href="/english/content/21"><b>Profile</b></a></li>
                            <li class="cat-item cat-item-3"><a href="/english/teacher/22"><b>Faculty</b></a></li>
                            <li class="cat-item cat-item-3"><a href="/english/teacher/25"><b>Distinguished Faculty</b></a></li>
                        </ul>
                        <div class="clear"></div>
                    </div>
                </div>
                <div class="span10" style="padding-top: 10px;">
                    <div class="col-2-3" id="post-container">
                        <div class="post">
                            <div class="post-margin">

                                <div class="am-g" style="border-bottom:1px #c7d2eb dotted;margin-top: 22px">
                                    <div class="am-u-sm-5" style="text-align: center">
                                        <img class="am-img-thumbnail" src="${photo}" style="max-width: 12rem;"/>
                                    </div>
                                    <div class="am-u-sm-7">
                                    <p>${teacher.name}
                                        <#if teacher.id == 175>
                                        </p><p>院党委副书记</p>
                                        <#elseif  teacher.id == 176>
                                            </p><p>院党委书记</p>
                                        <#else >
                                            <#switch teacher.job_title>
                                                <#case 1>讲师<#break>
                                                <#case 2>副教授<#break>
                                                <#case 3>教授<#break>
                                            </#switch>

                                        </#if>
                                        </p>
                                        <#if teacher.id != 175 && teacher.id != 176>
                                            <p>${teacher.department!'暂无'}</p>
                                        </#if>
                                        <p>电话： ${teacher.phone!'暂无'}</p>
                                        <p>Email：  ${teacher.email!'暂无'}</p>
                                        <#if teacher.id == 175>
                                            办公地点: 材料学院 31-345(北洋园)
                                        <#elseif  teacher.id == 176>
                                            办公地点: 材料学院 31-348(北洋园)
                                        <#else >
                                            <p>研究所： ${teacher.laboratory()!'暂无'}</p>
                                        </#if>
                                    </div>
                                </div>

                                <div style="border-bottom:1px #c7d2eb dotted">
                                    <h2>个人简历</h2>
                                    <div>${teacher.introduction!'暂无'}</div>
                                </div>
                                <#if teacher.id != 175 && teacher.id != 176>
                                    <div style="border-bottom:1px #c7d2eb dotted">
                                        <h2>研究方向</h2>
                                        <div>${teacher.direction!'暂无'}</div>
                                    </div>

                                    <div style="border-bottom:1px #c7d2eb dotted">
                                        <h2>承担项目</h2>
                                        <div>${teacher.project!'暂无'}</div>
                                    </div>

                                    <div style="border-bottom:1px #c7d2eb dotted">
                                        <h2>标志性成果</h2>
                                        <div>${teacher.achievement!'暂无'}</div>
                                    </div>
                                </#if>

                            </div>
                            <div style="clear:both;"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</@layout>