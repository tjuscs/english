<#macro banner banneritems>
<ul class="ui-banner-slides">
    <#list banneritems as bannerItem>
        <li><a href="/english/news/${bannerItem.id}" target="_blank"><img src="/english/upload/${bannerItem.img}"
                                                                  alt="${bannerItem.title}" title="${bannerItem.title}"></a>
        </li>
    </#list>
</ul>
<ul class="ui-banner-slogans">
    <#list banneritems as bannerItem>
        <li class="ui-line" onclick="window.location.href='/english/news/${bannerItem.id}'">
            <div class="ullinehover">
                <div class="ui-bnnerimg floatLeft">
                    <img src="/english/upload/${bannerItem.img}" alt="" width="103"/>
                </div>
                <div class="ui-bnnerp floatRight">
                    <p>${bannerItem.overview}</p>
                </div>
            </div>
        </li>
    </#list>
</ul><!--ui-banner-slogans end-->

</#macro>