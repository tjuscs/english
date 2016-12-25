<#macro type headType contentType>


<div class="widget-container">
    <h6 class="widget-title">${headType.name}</h6>
    <#local subMenuItems = headType.subContentTypes()>
    <#if 0 < subMenuItems.size()>
    <ul>
        <#list subMenuItems as subItem>
            <#local subMenuItems2 = subItem.subContentTypes()>
            <li class="cat-item cat-item-3<#if subItem.id = contentType.id> hover </#if>"><a <#if 0 gte subMenuItems2.size()>href="/english<#if subItem.href??>/${subItem.href}/<#else >/content/</#if>${subItem.id}"</#if>><b>${subItem.name}</b></a></li>
            <#if 0 lt subMenuItems2.size()>
                <#list subMenuItems2 as subItem2>
                    <li class="cat-item cat-item-3<#if subItem2.id = contentType.id> hover </#if>"><a href="/english<#if subItem2.href??>/${subItem2.href}/<#else >/content/</#if>${subItem2.id}">${subItem2.name}</a></li>
                </#list>
            </#if>
        </#list>
    </ul>
    </#if>
    <div class="clear"></div>
</div>
</#macro>