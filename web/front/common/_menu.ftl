<#macro menu menuItems>

<div class="navstyle">
    <div class="container">
        <span class="menu"></span>
        <div class="top-menu">
            <ul class="nav">
                <#list menuItems as item>
                    <li>
                        <a href="/<#if item.id != 1>content/${item.id}</#if>">
                            ${item.name}
                        </a>
                    </li>
                </#list>
            </ul>
        </div>
        <script>
            $("span.menu").click(function(){
                $(".top-menu ul").slideToggle("slow" , function(){
                });
            });
        </script>
    </div>
</div>
</#macro>