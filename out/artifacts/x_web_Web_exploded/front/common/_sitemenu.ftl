<#macro site siteList type>
    <#if siteList??>
        <#local site = siteList>
    <div class="menu-cont-list" style="display:none;">
        <ul>
        <#list site as siteitem>
            <#if siteitem.type == type>
            <li><a href="${siteitem.url}" target="_blank">${siteitem.name}</a></li>
            </#if>
        </#list>
        </ul>
    </div>
    </#if>

</#macro>