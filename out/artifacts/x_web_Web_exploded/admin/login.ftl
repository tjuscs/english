<#include "/front/common/_adminlayout.ftl"/>
<@layout>
<style>
    .header {
        text-align: center;
    }

    .header h1 {
        font-size: 200%;
        color: #333;
        margin-top: 30px;
    }

    .header p {
        font-size: 14px;
    }
</style>
<div class="header">
    <div class="am-g">
        <h1>天津大学材料学院</h1>
    <#--<p>后台管理系统<br/>代码编辑，代码生成，界面设计，调试，编译</p>-->
    </div>
    <hr/>
</div>
<div class="am-g">
    <div class="am-u-lg-6 am-u-md-8 am-u-sm-centered">
    <#--<h3>登录</h3>-->
    <#--<hr>-->
    <#--<div class="am-btn-group">-->
    <#--<a href="#" class="am-btn am-btn-secondary am-btn-sm"><i class="am-icon-github am-icon-sm"></i> Github</a>-->
    <#--<a href="#" class="am-btn am-btn-success am-btn-sm"><i class="am-icon-google-plus-square am-icon-sm"></i>-->
    <#--Google+</a>-->
    <#--<a href="#" class="am-btn am-btn-primary am-btn-sm"><i class="am-icon-stack-overflow am-icon-sm"></i>-->
    <#--stackOverflow</a>-->
    <#--</div>-->
    <#--<br>-->
        <form id="login-form" method="post" class="am-form">
            <label for="email">邮箱:</label>
            <input type="email" name="user.account" id="email" value="">
            <br>
            <label for="password">密码:</label>
            <input type="password" name="user.password" id="password" value="">
            <br/>
            <label for="">验证码:</label>
            <br>
            <input id="captcha" type="text" name="captcha" value=""
                   style="display: inline;margin-right: 10px;width: 65%;float: left">
            <img src="/captcha" style="cursor: pointer;float: left" onclick="this.src='/captcha?rnd=' + Math.random();">
            <br>
            <hr>
            <div class="am-cf">
                <input id="btn-login" type="button" name="" value="登 录" class="am-btn am-btn-primary am-btn-sm am-fl">
            </div>
        </form>
        <hr>
        <p>© 2016 Tianjin University, Material, Inc. Licensed under MIT license.</p>
    </div>
</div>

<script type="text/javascript">
    $("#btn-login").on('click', function () {
        $.ajax({
            type: 'POST',
            url: '/admin/login',
            data: $("#login-form").serialize(),
            success: function (data) {
                if (data['verify']) {
                    location.reload();
                } else {
                    alert("登陆失败,请检查账号、密码以及验证码是否正确!")
                    location.reload();
                }
            }
        })
    })
</script>
</@layout>