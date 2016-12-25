<!doctype html>
<html class="no-js">
<head>
<#--css-->
    <link rel="stylesheet" href="/assets/css/amazeui.min.css"/>
<#--script-->
    <script src="/assets/js/jquery.min.js"></script>
    <script src="/assets/js/amazeui.min.js"></script>
    <script src="/assets/js/app.js"></script>
</head>
<body>

<div class="admin-content">
    <div class="admin-content-body">
        <div class="am-cf am-padding am-padding-bottom-0">
            <div class="am-fl am-cf">
                <strong class="am-text-primary am-text-lg">请填写内容</strong>
            </div>
        </div>
        <hr>
        <div class="am-tab-panel">
            <form class="am-form">
                <div class="am-g am-margin-top">
                    <div class="am-u-sm-4 am-u-md-2 am-text-right">
                        文章标题
                    </div>
                    <div class="am-u-sm-8 am-u-md-4 am-u-end col-end">
                        <input type="text" class="am-input-sm">
                    </div>
                    <div class="am-hide-sm-only am-u-md-6">*必填，不可重复</div>
                </div>

                <div class="am-g am-margin-top">
                    <div class="am-u-sm-4 am-u-md-2 am-text-right">
                        文章作者
                    </div>
                    <div class="am-u-sm-8 am-u-md-4 am-u-end col-end">
                        <input type="text" class="am-input-sm">
                    </div>
                </div>

                <div class="am-g am-margin-top">
                    <div class="am-u-sm-4 am-u-md-2 am-text-right">
                        信息来源
                    </div>
                    <div class="am-u-sm-8 am-u-md-4">
                        <input type="text" class="am-input-sm">
                    </div>
                    <div class="am-hide-sm-only am-u-md-6">选填</div>
                </div>

                <div class="am-g am-margin-top">
                    <div class="am-u-sm-4 am-u-md-2 am-text-right">
                        内容摘要
                    </div>
                    <div class="am-u-sm-8 am-u-md-4">
                        <input type="text" class="am-input-sm">
                    </div>
                    <div class="am-u-sm-12 am-u-md-6">不填写则自动截取内容前255字符</div>
                </div>

            <#--<div class="am-g am-margin-top-sm">-->
            <#--<div class="am-u-sm-12 am-u-md-2 am-text-right admin-form-text">-->
            <#--内容描述-->
            <#--</div>-->
            <#--<div class="am-u-sm-12 am-u-md-10">-->
            <#--<textarea rows="10" placeholder="请使用富文本编辑插件"></textarea>-->
            <#--</div>-->
            <#--</div>-->
            </form>
        </div>
    </div>
    <hr>

    <div class="am-margin am-center am-text-center">
        <button type="button" class="am-btn am-btn-primary am-btn-xs">提交保存</button>
        <button type="button" class="am-btn am-btn-primary am-btn-xs">放弃保存</button>
    </div>
</div>

</div>
</body>
</html>