<#include "/front/common/_layout.ftl"/>


<@layout>

<!-- Carousel-->
<div id="slidercontainer">
    <div class="container">
        <section id="slider">
            <div id="slideritems" class="flexslider">
                <ul class="slides">
                    <#list banner_news as b_news>
                        <li>
                            <div class="container">
                                <div class="twelve columns">
                                    <img src="<#if b_news.img??>/english/upload/${b_news.img}</#if>"
                                         alt="${b_news.title}"/>
                                    <div class="flex-caption">
                                        <h1>${b_news.title}</h1>
                                        <p class="slidetext2">${b_news.overview}</p>
                                        <a href="/english/news/${b_news.id}" class="button orange rounded large2" target="_blank">View
                                            more</a>
                                    </div>
                                </div>
                            </div>
                        </li>
                    </#list>
                </ul>
            </div>
        </section>
    </div>
</div>


<div class="container marketing">
    <div class="container">
        <!-- Example row of columns -->
        <div class="row">
            <div class="col-md-1">
                <fieldset>
                    <legend><h2><a href="/english/content/33">NOTICES</a></h2></legend>
                    <#global i = 0>
                    <#list notice_news as news>
                        <#global i = i + 1>
                        <div class="media marginLeft5">
                            <div class="blueblock pull-left"><h1>${i}</h1></div>
                            <div class="media-body">
                                <li class="list-notice-item"><a href="/english/news/${news.id}"
                                                                title="${news.title}"
                                                                target="_blank">${news.title}</a>
                                </li>
                            </div>
                        </div>
                    </#list>

                </fieldset>
            </div>

            <div class="col-md-2">
                <fieldset>
                    <legend><h2><a href="/english/content/32">NEWS</a></h2></legend>
                    <ul class="list-group">
                        <#list normal_news as news>
                            <li><h4 class="text-normal upcase"><a href="/english/news/${news.id}"
                                                                  title="${news.title}"
                                                                  target="_blank">${news.title}</a></h4></li>
                        </#list>
                    </ul>
                </fieldset>
            </div>

            <div class="col-md-3" style="float:right;margin-right:0;">
                <fieldset>
                    <legend><h2>LINKS</h2></legend>
                    <ul class="list-group-links">
                        <li><a href="http://www.tju.edu.cn/english" target="_blank">Tianjin University</a></li>
                        <li><a href="http://www.lib.tju.edu.cn" target="_blank">TJU Library</a></li>
                        <li><a href="http://www.tju.edu.cn/english" target="_blank">Schools of TJU</a></li>
                        <li><a href="http://www.tju.edu.cn/gsen/" target="_blank">Graduate School of TJU</a></li>
                        <li><a href="http://e.tju.edu.cn" target="_blank">Office System of TJU</a></li>
                        <li><a href="http://219.243.39.24/wctju2015" target="_blank">Information Center of TJU</a></li>
                    </ul>
                </fieldset>
            </div>

        </div>
    </div>
</div>

<!-- footfile -->
<script src="/english/assets/js/footer.js"></script>

<!-- Le javascript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<script src="/english/assets/js/jquery.js"></script>
<script src="/english/assets/js/bootstrap-transition.js"></script>
<script src="/english/assets/js/bootstrap-alert.js"></script>
<script src="/english/assets/js/bootstrap-modal.js"></script>
<script src="/english/assets/js/bootstrap-dropdown.js"></script>
<script src="/english/assets/js/bootstrap-scrollspy.js"></script>
<script src="/english/assets/js/bootstrap-tab.js"></script>
<script src="/english/assets/js/bootstrap-tooltip.js"></script>
<script src="/english/assets/js/bootstrap-popover.js"></script>
<script src="/english/assets/js/bootstrap-button.js"></script>
<script src="/english/assets/js/bootstrap-collapse.js"></script>
<script src="/english/assets/js/bootstrap-carousel.js"></script>
<script src="/english/assets/js/bootstrap-typeahead.js"></script>
<script src="/english/assets/js/holder.js"></script>

<!-- jQuery Flexslider -->
<script type="text/javascript" src="/english/assets/js/jquery.flexslider-min.js"></script>
<script type="text/javascript">
    jQuery(window).load(function () {
        jQuery('.flexslider').flexslider({
            animation: "fade",              //String: Select your animation type, "fade" or "slide"
            directionNav: true, //Boolean: Create navigation for previous/next navigation? (true/false)
            controlNav: false  //Boolean: Create navigation for paging control of each clide? Note: Leave true for manualControls usage
        });
    });
</script>

<!-- jQuery Dropdown Mobile -->
<script type="text/javascript" src="/english/assets/js/tinynav.min.js"></script>

</@layout>