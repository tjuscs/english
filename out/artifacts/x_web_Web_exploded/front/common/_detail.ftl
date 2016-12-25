<#macro detail detail action>

<div class="col-2-3" id="post-container">
    <div class="post">
        <div class="post-margin">
            <#list detail.list as item>
                <div class="wrapper_top blog_title"><a href="/news/${item.id}" target="_blank">${item.title}</a></div>
            </#list>
            <div class="pagination pagination__posts">
                <ul>
                    <li <#if detail.pageNumber lte 1>class="active"</#if>><a
                            href="<#if detail.pageNumber lte 1>#<#else >/${action}page=1</#if>">First</a></li>
                    <li <#if detail.pageNumber lte 1>class="active"</#if>><a
                            href="<#if detail.pageNumber lte 1>#<#else >/${action}page=${detail.pageNumber - 1}</#if>">Pre</a>
                    </li>
                    <li <#if detail.pageNumber gte detail.totalPage>class="active"</#if>><a
                            href="<#if detail.pageNumber gte detail.totalPage>#<#else >/${action}page=${detail.pageNumber + 1}</#if>">Next</a>
                    </li>
                    <li <#if detail.pageNumber gte detail.totalPage>class="active"</#if>><a
                            href="<#if detail.pageNumber gte detail.totalPage>#<#else >/${action}page=${detail.totalPage}</#if>">Last</a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>
</#macro>