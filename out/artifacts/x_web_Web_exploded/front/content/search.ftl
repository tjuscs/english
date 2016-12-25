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
                    <div class="widget-container">
                        <h6 class="widget-title">Results</h6>
                        <ul>
                            <li class="cat-item cat-item-3">Search Results</li>
                        </ul>
                        <div class="clear"></div>
                    </div>
                </div>
                <div class="span10" style="padding-top: 10px;">

                    <#if !page?has_content>
                    <div class="col-2-3" id="post-container">
                        <div class="post">
                            <div class="post-margin">
                                <div class="wrapper_top blog_title"><a target="_blank">Nothing</a></div>
                            </div>
                        </div>
                    </div>
                    <#else >
                        <@d.detail detail=page action="news?searchvalue=${sv}&"/>
                    </#if>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="../../footer-page.js"></script>
</@layout>