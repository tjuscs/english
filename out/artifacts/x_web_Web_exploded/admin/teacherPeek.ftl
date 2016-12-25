<#include "/front/common/_layout.ftl"/>
<#import "/front/common/_menu.ftl" as m/>
<@layout>
<link href="/assets/css/2015_default2.css" rel="stylesheet" type="text/css" media="all">

<div class="am-g">
    <div class="am-u-sm-6 am-u-lg-centered">
        <h1 style="text-align: center;margin-top: 80px">教师信息预览</h1>
        <hr>
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
</div>

</@layout>