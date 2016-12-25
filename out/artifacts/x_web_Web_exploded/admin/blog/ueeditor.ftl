<!DOCTYPE html>
<html lang="en">
<head>
<#--<link rel="stylesheet" href="/assets/css/bootstrap.min.css">-->
    <link rel="stylesheet" href="/assets/js/element.css">
<#--<script src="/assets/js/jquery.min.js"></script>-->
<#--<script src="/assets/js/bootstrap.min.js"></script>-->
    <script src="/assets/js/moment.js"></script>

    <script type="text/javascript" charset="utf-8" src="/assets/ueeditor/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="/assets/ueeditor/ueditor.all.min.js"></script>
    <!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
    <!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
    <script type="text/javascript" charset="utf-8" src="/assets/ueeditor/lang/zh-cn/zh-cn.js"></script>
    <script src="/assets/js/vue2.0.js"></script>
    <script type="text/javascript" charset="utf-8" src="/assets/js/vue-resource.min.js"></script>
    <script src="/assets/js/element.js"></script>
</head>
<body>

<div id="app">
    <el-row :gutter="20">
        <el-col :span="18" :offset="3">
            <h2>文章内容</h2>
            <el-form :inline="true" :model="news" @submit.prevent="onSubmit" class="demo-form-inline">
                <el-form-item>
                    <img :src="imgUrl" style="width: 400px;height:200px">

                    <el-upload
                            :action="uploadPath"
                            :multiple="false"
                            :on-success="handleSuccess"
                            :before-upload="checkUpload">
                        <el-button size="small" type="primary" :disabled="!news.id">点击上传主图片</el-button>
                        <div class="el-upload__tip" slot="tip">只能上传jpg/png文件，且不超过500kb</div>
                    </el-upload>
                </el-form-item>
                <br>
                <el-form-item>
                    <el-input v-model="news.title" placeholder="标题"></el-input>
                </el-form-item>

                <el-form-item>
                    <span class="demonstration">发文时间</span>
                    <el-date-picker
                            v-model="news.createtime"
                            type="datetime"
                            placeholder="选择日期时间">
                    </el-date-picker>
                </el-form-item>

                <el-form-item>
                    <el-input v-model="news.author" placeholder="发稿人"></el-input>
                </el-form-item>

                <el-button type="primary" @click.native="save">保存</el-button>
            </el-form>
        </el-col>
    </el-row>

    <el-row :gutter="20">
        <el-col :span="18" :offset="3">
            <script id="editor" type="text/plain" style="height:300px;"></script>
        </el-col>
    </el-row>
</div>

<script type="text/javascript">

    //实例化编辑器
    //建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
    var ue = UE.getEditor('editor');

    new Vue({
        el: "#app",
        http: {
            root: '/admin/news',
        },
        data: {
            news: {
                createtime: new Date(),
                <#if type??>type:${type},</#if>
                <#if session.user??>author: "${session.user.name}"</#if>
            },
            formInline: {
                user: '',
                region: ''
            },
            categories: [],
            value8: '',
            dialogVisible: false
        },
        methods: {
            save: function () {
                this.news.content = UE.getEditor('editor').getContent();
                if (UE.getEditor('editor').getContentTxt().length > 180) {
                    this.news.overview = UE.getEditor('editor').getContentTxt().slice(0, 180);
                }else {
                    this.news.overview = UE.getEditor('editor').getContentTxt();
                }
                this.$http.post('save', this.news).then(function (json) {
                    this.news = json.data;
                    this.news.createtime = new Date(json.data.createtime);
                    this.$message('保存成功');
                }, function (json) {
                    this.$message({
                        message: '保存错误，请重试',
                        type: 'error'
                    });
                });
            },
            checkUpload: function (file) {
                if (file.name.indexOf(".jpg") < 0 && file.name.indexOf(".png") < 0) {
                    this.$message({
                        message: '请选择正确的文件类型',
                        type: 'error'
                    });
                    return false
                } else if (file.size > 512000) {
                    this.$message({
                        message: '文件过大',
                        type: 'error'
                    });
                    return false
                }
                return true;
            },
            handleSuccess: function (file, fileList) {
//                this.news.img = file.name
                window.location.reload()
            }

        },
        computed: {
            uploadPath: function () {
                return "/admin/file/upload/" + this.news.id
            }
            ,
            imgUrl: function () {
                return !this.news.img ? "" : "/upload/" + this.news.img

            }
        }
        ,
        created: function () {
            this.$http.get("categories").then(
                    function (json) {
                        this.categories = json.data
                    <#if id??>
                        this.$http.get("detail", {params: {id: "${id}"}}).then(
                                function (json) {
                                    this.news = json.data;
                                    this.news.createtime = new Date(json.data.createtime);
                                    UE.getEditor('editor').setContent(this.news.content)
                                }, function () {
                                    this.$message({
                                        message: '读取数据错误，请重试',
                                        type: 'error'
                                    });
                                }
                        )
                    </#if>
                    }, function () {
                        this.$message({
                            message: '保存错误，请重试',
                            type: 'error'
                        });
                    }
            )

        }
        ,
        filters: {
            moment: function (date) {
                return moment(date).format('YYYY-MM-DD HH:mm:ss');
            }
        }
    })
</script>
</body>
</html>