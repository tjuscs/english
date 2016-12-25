<#include "/front/common/_layout.ftl"/>
<#import "/front/common/_treemenu.ftl" as tm/>
<#import "/front/common/_blogdetail.ftl" as bd/>
<#import "/front/common/_detail.ftl" as d/>



<@layout>

<link href="/english/assets/css/pages.css" rel="stylesheet">

<div style="background:#f6f5f2;padding:15px 0px 10px 0px;">
    <div class="container">
        <div class="container-fluid">
            <div class="row-fluid">
                <div class="span2">
                    <@tm.type headType = headType  contentType = contentType/>
                </div>
                <div class="span10" style="padding-top: 10px;">

                    <#if contentType.type == 1>
                        <#if !blog?has_content>
                            <p>暂无内容</p>
                        <#else >
                            <@bd.blog blog=blog/>
                        </#if>

                    <#elseif contentType.type == 3>
                        <#if !page?has_content>
                            <p>暂无内容</p>
                        <#else >
                            <@d.detail detail=page action="content/${contentType.id}?"/>
                        </#if>

                    </#if>

                </div>
            </div>
        </div>
    </div>
</div>

<script src="../../footer-page.js"></script>
</@layout>