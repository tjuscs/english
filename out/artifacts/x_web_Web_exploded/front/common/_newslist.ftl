<#macro list newsList width>
<#if newsList??>
    <#local news = newsList>
<div class="mainNewsContent">
    <#list news as newsitem>
        <div class="mainNewsLi">
            <a href="/news/${newsitem.id}" target="_blank" style="width: ${width}rem;" title="${newsitem.title}">
                <#if newsitem.top == 1><span style="color: red">${newsitem.title}</span><#else >${newsitem.title}</#if>
            </a>
        ${newsitem.createtime?keep_before(" ")}
        </div>
    </#list>
</div>
</#if>

</#macro>