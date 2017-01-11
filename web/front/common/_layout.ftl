<#macro layout>
<!doctype html>
<html>
<head>
    <!DOCTYPE html>
    <!-- saved from url=(0067)http://docs.bootcss.com/bootstrap-2.3.2/docs/examples/carousel.html -->
    <html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>School of Materials Science and Engineering,Tianjin University</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="">

        <!-- Nav Action -->
        <script type="applijewelleryion/x-javascript">
             addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); }

        </script>
        <script src="js/jquery.js"></script>

        <!-- styles -->
        <link href="/english/assets/css/bootstrap.css" rel="stylesheet">
        <link href="/english/assets/css/bootstrap-responsive.css" rel="stylesheet">
        <link href="/english/assets/css/style.css" rel="stylesheet">
        <link href="/english/assets/css/flexslider.css" rel="stylesheet"/>

        <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
        <!--[if lt IE 9]>
        <script src="../english/assets/js/html5shiv.js"></script>
        <![endif]-->

    </head>
<body><!-- Contact -->
    <#import "/front/common/_menu.ftl" as m/>
<div class="t">
    <div class="container">
        <div class="t_n">
            <div class="t_nl">
                <p class="tel">+86-022-85356663</p>
                <p class="mail">dean_smse@tju.edu.cn</p>
                <p class="teacher"><a href="http://mse.tju.edu.cn/english/teacher/profile" target="_blank">Teacher</a></p>
            </div>
            <div class="r_nr"><a href="http://mse.tju.edu.cn" target="_blank">Chinese Verson</a></div>
            <div style="clear:both;"></div>
        </div>
    </div>
</div>

<!-- Banner -->
<div class="container">
    <div class="bannerme" style="position: relative;">
        <div style="z-index:999;position:absolute;right:0;width:190px;top:36px;" class="searchhide">
            <form action="/english/news/search" method="get">
                <input class="searchstyle" name="searchvalue" type="text" placeholder="Search here...">
                <input class="searchbutton" type="image" src="/english/assets/i/boutt.jpg">
            </form>
        </div>
        <div style="z-index:1;"><img src="/english/assets/i/banner.jpg"></div>
    </div>
</div>

<!-- Navigation -->
    <#if types??>
        <@m.menu menuItems=types/>
    </#if>
    <#nested>

<#--<script src="/english/assets/js/amazeui.min.js"></script>-->

</body>
</html>
</#macro>