<!doctype html>
<html class="no-js">
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
    <link rel="icon" sizes="192x192" href="/assets/i/app-icon72x72@2x.png">

    <!-- Add to homescreen for Safari on iOS -->
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-title" content="Amaze UI"/>
    <link rel="apple-touch-icon-precomposed" href="/assets/i/app-icon72x72@2x.png">

    <!-- Tile icon for Win8 (144x144 + tile color) -->
    <meta name="msapplication-TileImage" content="/assets/i/app-icon72x72@2x.png">
    <meta name="msapplication-TileColor" content="#0e90d2">

    <link rel="stylesheet" href="/assets/css/amazeui.flat.min.css">
    <link rel="stylesheet" href="/assets/css/app.css">
    <script src="/assets/js/jquery-1.12.4.min.js"></script>

    <script type="text/javascript" charset="utf-8" src="/assets/ueeditor/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="/assets/ueeditor/ueditor.all.min.js"></script>
    <!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
    <!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
    <script type="text/javascript" charset="utf-8" src="/assets/ueeditor/lang/zh-cn/zh-cn.js"></script>
    <script src="/assets/js/vue2.0.js"></script>
    <script type="text/javascript" charset="utf-8" src="/assets/js/vue-resource.min.js"></script>
    <style>

        li.todo:hover {
            color: green;
            cursor: pointer;
        }

        li.todo:hover a {
            display: inline !important;
        }
    </style>
</head>
<body>

<div class="wrap">
    <div class="middles">
        <div id="banner"></div>
        <nav>
            <ul>
                <li>
                    <a href="profile">个人基本信息</a>
                </li>
                <li>
                    <a href="/teacher/logout">退出</a>
                </li>
            </ul>
        </nav>
    </div>
    <div class="newsarea">
        <div id="data-form">
            <form class="am-form am-form-inline">
                <fieldset>
                    <legend>教师详情</legend>
                    <div class="am-form-group" style="display: none">
                        <input type="text" v-model="teacher.id">
                    </div>

                    <div class="am-form-group am-form-icon am-form-feedback"
                         :class="{'am-form-error':!teacher.account, 'am-form-success':!!teacher.account}">
                        <label>账号</label>
                        <input class="am-form-field" type="text" v-model="teacher.account"
                               placeholder="输入账号" :disabled="teacher.id">
                        <span :class="{'am-icon-check':!!teacher.account, 'am-icon-times':!teacher.account}"></span>
                    </div>

                    <div class="am-form-group am-form-icon am-form-feedback">
                        <label>密码</label>
                        <input class="am-form-field" type="password" v-model="teacher.password"
                               placeholder="输入密码">
                    </div>

                    <div class="am-form-group am-form-icon am-form-feedback"
                         :class="{'am-form-error':!teacher.name, 'am-form-success':!!teacher.name}">
                        <label>教师姓名</label>
                        <input class="am-form-field" type="text" v-model="teacher.name"
                               placeholder="教师姓名">
                        <span :class="{'am-icon-check':!!teacher.name, 'am-icon-times':!teacher.name}"></span>
                    </div>
                    <div class="am-form-group am-form-icon am-form-feedback"
                         :class="{'am-form-error':!teacher.department, 'am-form-success':!!teacher.department}">
                        <label>系所</label>
                        <input class="am-form-field" type="text" v-model="teacher.department"
                               placeholder="系所">
                        <span :class="{'am-icon-check':!!teacher.department, 'am-icon-times':!teacher.department}"></span>
                    </div>
                    <br>
                    <div class="am-form-group am-form-icon am-form-feedback"
                         :class="{'am-form-error':!teacher.phone, 'am-form-success':!!teacher.phone}">
                        <label>电话</label>
                        <input class="am-form-field" type="text" v-model="teacher.phone"
                               placeholder="电话">
                        <span :class="{'am-icon-check':!!teacher.phone, 'am-icon-times':!teacher.phone}"></span>
                    </div>
                    <div class="am-form-group am-form-icon am-form-feedback"
                         :class="{'am-form-error':!teacher.email, 'am-form-success':!!teacher.email}">
                        <label>Email</label>
                        <input class="am-form-field" type="email" v-model="teacher.email"
                               placeholder="Email">
                        <span :class="{'am-icon-check':!!teacher.email, 'am-icon-times':!teacher.email}"></span>
                    </div>
                    <div class="am-form-group am-form-icon am-form-feedback"
                         :class="{'am-form-error':!teacher.account, 'am-form-success':!!teacher.account}">

                        <label>头像</label>
                        <div v-if="teacher.img">
                            <img :src="imageSrc" style="width: 15rem;height: 20rem;"/>
                        </div>
                        <div>
                            <input type="file" @change="onFileChange">
                        </div>

                    </div>

                    <div>
                        <label for="">职称</label>
                        <select v-model="teacher.jobTitle">
                            <option :value="0">无</option>
                            <option :value="1">讲师</option>
                            <option :value="2">副教授</option>
                            <option :value="3">教授</option>
                            <option :value="4">讲座教授</option>
                            <option :value="5">工程师</option>
                            <option :value="6">高级工程师</option>
                            <option :value="7">副研究员</option>
                            <option :value="8">研究员</option>
                            <option :value="9">特聘研究员</option>
                        </select>
                    </div>


                    <div style="margin-top: 0.8rem">
                        <label for="">实验室</label>
                        <select v-model="teacher.laboratory">
                            <option :value="1">先进高分子材料研究所</option>
                            <option :value="2">先进金属材料研究所</option>
                            <option :value="3">先进陶瓷研究所</option>
                            <option :value="4">焊接与先进制造技术研究所</option>
                            <option :value="5">新能源材料研究所</option>
                            <option :value="6">天津大学-日本国立物质材料研究所（NIMS）联合研究中心</option>
                            <option :value="7">教学与大型仪器实验中心</option>
                            <option :value="8">其他</option>
                        </select>
                    </div>

                    <div style="margin-top: 0.8rem">
                        <div class="am-form-group am-form-icon am-form-feedback">
                            <label>杰出人才类型</label>
                            <select v-model="newAward.awardId">
                                <option :value="0">无</option>
                                <option :value="1">国家千人计划</option>
                                <option :value="2">国家杰出青年基金获得者</option>
                                <option :value="3">国家级教学名师</option>
                                <option :value="4">国家优秀青年基金获得者</option>
                                <option :value="5">教育部“新世纪人才”</option>
                                <option :value="6">天津市千人计划</option>
                                <option :value="7">天津市中青年科技创新领军人才</option>
                                <option :value="8">天津市青年科技优秀人才</option>
                                <option :value="9">天津市重点领域创新团队</option>
                                <option :value="10">天津市青年拔尖人才</option>
                                <option :value="11">万人计划</option>
                                <option :value="12">天津市教学名师</option>
                                <option :value="13">天津市131创新团队</option>
                                <option :value="14">天津市131创新型人才工程第一层次</option>
                            </select>
                        </div>
                        <div class="am-form-group am-form-icon am-form-feedback">
                            <label>描述</label>
                            <input class="am-form-field" type="text" v-model="newAward.awardName" placeholder="获奖描述">
                        </div>
                        <div class="am-form-group am-form-icon am-form-feedback">
                            <button type="button" class="am-btn am-btn-primary" @click.prevent="saveAward"
                                    style="margin-top:25px">保存获奖荣誉
                            </button>
                        </div>
                        <hr>

                        <label>我的荣誉:</label>

                        <ul class="todo-list">
                            <li v-for="awd in teacher.awards" class="todo" :key="awd.awardId">
                                <div>
                                    <span @click.prevent="editAward(awd)">
                                        {{ awd.awardId | awardName}}
                                        <strong v-if="awd.awardName">: {{awd.awardName}}</strong>
                                    </span>
                                    <a type="button" @click.prevent="deleteAward(awd)"
                                       style="color: #ff3d46;display: none"> 删除</a>
                                </div>
                            </li>
                        </ul>
                    </div>

                    <div style="margin-top: 0.8rem">
                        <label for="">个人简历</label>
                        <div>
                            <script id="ueintroduction" type="text/plain" style="height:300px;"></script>
                        </div>
                    </div>

                    <div style="margin-top: 0.8rem">
                        <label for="">研究方向</label>
                        <div>
                            <script id="uedirection" type="text/plain" style="height:300px;"></script>
                        </div>
                    </div>

                    <div style="margin-top: 0.8rem">
                        <label for="">承担项目</label>
                        <div>
                            <script id="ueproject" type="text/plain" style="height:300px;"></script>
                        </div>
                    </div>

                    <div style="margin-top: 0.8rem">
                        <label for="">标志性成果</label>
                        <div>
                            <script id="ueachievement" type="text/plain" style="height:300px;"></script>
                        </div>
                    </div>
                    <p>
                        <button type="button" class="am-btn am-btn-primary" @click="saveItem">保存</button>
                    </p>
                </fieldset>
            </form>
        </div>
    </div>
</div>


<div class="middles">
    <div id="copyRight">版权所有 © 天津大学材料科学与工程学院 2016新版上线<span></span></div>
    <div id="footer">联系地址：天津市海河教育园区雅观道135号31号教学楼 [<a href="http://l.map.qq.com/11222015482?m"
                                                     target="_blank">查看学院地图标注</a>]，邮政编码：300350<br>联系电话：022-27403405
        传真：022-XXXXXXXX 电子邮件：mseic@tju.edu.cn
    </div>
</div>

<script type="text/javascript">

    var ue_i = UE.getEditor('ueintroduction');
    var ue_d = UE.getEditor('uedirection');
    var ue_p = UE.getEditor('ueproject');
    var ue_a = UE.getEditor('ueachievement');

    $(function () {
        var vr = new Vue({
            http: {
                root: '/teacher'
            },
            el: "#data-form",
            data: {
                teacher: {
                    account: "",
                    name: "",
                    password: "",
                    jobTitle: 1,
                    department: "",
                    phone: "",
                    introduction: "",
                    direction:"",
                    project:"",
                    achievement: "",
                    img: ""
                },
                newAward: {
                    awardId: "",
                    awardName: ""
                }

            },
            methods: {
                "saveItem": function () {
                    this.teacher.introduction = UE.getEditor('ueintroduction').getContent();
                    this.teacher.direction = UE.getEditor('uedirection').getContent();
                    this.teacher.project = UE.getEditor('ueproject').getContent();
                    this.teacher.achievement = UE.getEditor('ueachievement').getContent();

                    this.$http.post('save', this.teacher).then(function (json) {
                        alert('操作成功');
                    }, function (json) {
                        alert('操作失败，请重试');
                    });

                },
                onFileChange: function (e) {
                    var files = e.target.files || e.dataTransfer.files;
                    if (!files.length)
                        return;
                    this.createImage(files[0]);
                },
                createImage: function (file) {
                    var image = new Image();
                    var reader = new FileReader();
                    var vm = this;

                    reader.onload = function (e) {
                        vm.teacher.img = e.target.result.substring(e.target.result.indexOf(",") + 1);
                    };
                    reader.readAsDataURL(file);
                },
                saveAward: function () {
                    this.$http.post('saveAward', this.newAward).then(function (json) {
                        if (!this.newAward.userId) {
                            this.teacher.awards.push(this.newAward);
                        }
                        this.newAward = {}
                        alert('操作成功');

                    }, function (json) {
                        alert('操作失败，请重试');
                    });
                    console.log(this.newAward)
                },
                editAward: function (awd) {
                    this.newAward = awd;
                    console.log((awd))
                },
                deleteAward: function (awd) {
                    this.$http.get("deleteAward?awardId=" + awd.awardId).then(
                            function (json) {
                                alert('操作成功');
                                this.teacher.awards.splice(this.teacher.awards.indexOf(awd), 1)
                            }
                    );
                }
            },
            created: function () {
                this.$http.get("getTeacher").then(
                        function (json) {
                            json.data.img = json.data.img || ""
                            this.teacher = json.data;
                            ue_i.ready(function () {
                                ue_i.setContent(vr.teacher.introduction || "");
                            })
                            ue_d.ready(function () {
                                ue_d.setContent(vr.teacher.direction || "");
                            })
                            ue_p.ready(function () {
                                ue_p.setContent(vr.teacher.project || "");
                            })
                            ue_a.ready(function () {
                                ue_a.setContent(vr.teacher.achievement || "");
                            })
                        }
                );

            },
            computed: {
                imageSrc: function () {
                    return "data:image/jpeg;base64," + this.teacher.img
                }
            },
            filters: {
                awardName: function (type) {
                    console.log(type)
                    switch (type) {
                        case 1:
                            return "国家千人计划";
                        case 2:
                            return "国家杰出青年基金获得者";
                        case 3:
                            return "国家级教学名师";
                        case 4:
                            return "国家优秀青年基金获得者";
                        case 5:
                            return "教育部“新世纪人才”";
                        case 6:
                            return "天津市千人计划";
                        case 7:
                            return "天津市中青年科技创新领军人才";
                        case 8:
                            return "天津市青年科技优秀人才";
                        case 9:
                            return "天津市重点领域创新团队";
                        case 10:
                            return "天津市青年拔尖人才";
                        case 11:
                            return "万人计划";
                        case 12:
                            return "天津市教学名师";
                        case 13:
                            return "天津市131创新团队";
                        case 14:
                            return "天津市131创新型人才工程第一层次";
                        default:
                            return "异常数据";
                    }
                }
            }
        });
    })
</script>

