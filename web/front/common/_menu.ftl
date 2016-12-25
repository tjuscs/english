<#macro menu menuItems>

<div class="navstyle">
    <div class="container">
        <span class="menu"></span>
        <div class="top-menu">
            <ul class="nav">
                <#list menuItems as item>
                    <li>
                        <a href="/english/<#if item.id != 1>content/${item.id}</#if>">
                            ${item.name}
                        </a>
                    </li>
                </#list>
            </ul>
        </div>
    </div>
</div>
</#macro>