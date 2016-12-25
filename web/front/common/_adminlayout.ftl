<#macro layout>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="天津大学材料科学与工程学院主页">
    <meta name="keywords" content="天津大学材料科学与工程学院主页">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>天津大学材料科学与工程学院主页</title>

    <!-- Set render engine for 360 browser -->
    <meta name="renderer" content="webkit">

    <!-- No Baidu Siteapp-->
    <meta http-equiv="Cache-Control" content="no-siteapp"/>

    <link rel="icon" type="image/png" href="/assets/i/favicon.png">

    <!-- Add to homescreen for Chrome on Android -->
    <meta name="mobile-web-app-capable" content="yes">
    <link rel="icon" sizes="192x192" href="/assets/i/favicon.png">

    <!-- Add to homescreen for Safari on iOS -->
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-title" content="Amaze UI"/>
    <link rel="apple-touch-icon-precomposed" href="/assets/i/favicon.png">

    <!-- Tile icon for Win8 (144x144 + tile color) -->
    <meta name="msapplication-TileImage" content="/assets/i/favicon.png">
    <meta name="msapplication-TileColor" content="#0e90d2">

    <!-- SEO: If your mobile URL is different from the desktop URL, add a canonical link to the desktop page https://developers.google.com/webmasters/smartphone-sites/feature-phones -->
    <!--
    <link rel="canonical" href="http://www.example.com/">
    -->

    <!--[if lt IE 10]>
    <script>
        alert("您的浏览器版本太低，建议使用Chrome, Firefox, Safari, IE 10以上的浏览器，点击确定下载最新的浏览器");
        window.location = "http://www.google.cn/intl/zh-CN/chrome/browser/desktop/index.html"
    </script>
    <![endif]-->

    <link rel="stylesheet" href="/assets/css/amazeui.flat.min.css">
    <link rel="stylesheet" href="/assets/css/app.css">
    <script src="/assets/js/jquery-1.12.4.min.js"></script>
</head>
<body>
    <#nested>

<#--<script src="/assets/js/amazeui.min.js"></script>-->

</body>
</html>
</#macro>