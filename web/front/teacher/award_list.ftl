<#include "/front/common/_layout.ftl"/>
<#import "/front/common/_treemenu.ftl" as tm/>
<@layout>
<link href="/english/assets/css/2015_default2.css" rel="stylesheet" type="text/css" media="all">
<link href="/english/assets/css/pages.css" rel="stylesheet">

<style>
    .t-l > div {
        margin-bottom: 2rem;
    }

    div.t-l h1 {
        font-size: 0.8rem;
        margin: 0;
        font-weight: 100;
        background-color: rgb(40, 145, 152);
        border-bottom: 1px solid;
        color: white;
        padding: 0.3rem 0.8rem;
    }

    div.t-l li {
        float: left;
        color: #999999;
        <#if strategy == "jobTitle">
            margin: 0 1rem;
        <#else >
            margin-left: 0px;
        </#if>
        padding-left: 10px;
        height: 30px;
        line-height: 30px;
        padding-top: 2px;
        width: 150px;
        text-align: center;
    }

</style>

<div style="background:#f6f5f2;padding:15px 0px 10px 0px;">
    <div class="container">
        <div class="container-fluid">
            <div class="row-fluid">
                <div class="span2">
                    <@tm.type headType = headType  contentType = contentType/>
                </div>
                <div class="span10" style="padding-top: 10px;">
                    <div class="col-2-3" id="post-container">
                        <div class="post">
                            <div class="post-margin">

                                <div class="t-l" style="margin-top:15px;">
                                    <#list teachers.entrySet() as k>
                                        <h1>${k.key}</h1>
                                        <ul style="list-style-type:none;">
                                            <#list k.value as t>
                                                <li <#if strategy == "award">style="text-align: left;width: auto;" </#if>><a
                                                        href="/english/teacher/detail/${t.id}">
                                                    <#if strategy == "award">
                                                        <#if t.awardName?has_content>
                                                        ${t.awardName} :
                                                        </#if>
                                                    </#if>${t.name}</a></li>
                                            </#list>
                                            <div style="clear:both"></div>

                                        </ul>
                                        <br>
                                    </#list>
                                </div>

                        </div>
                            <div style="clear:both;"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="../../footer-page.js"></script>
</@layout>