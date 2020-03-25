<template>
    <div class="login-body">
        <div class="login">
            <el-card class="box-card">
                <div slot="header" class="clearfix">
                    <span>管理员登录</span>
                    <el-button style="float: right; padding: 3px 0" type="text">没有账号？请联系管理员</el-button>
                </div>
                <div class="login-info">
                   <div> <el-input v-model="postData.username"  placeholder="请输入登录账号"></el-input></div>
                    <div> <el-input type="password" v-model="postData.password" placeholder="请输入密码"></el-input></div>
                    <div> <el-button type="primary" @click.keyup.enter="login">登录</el-button></div>
                </div>
            </el-card>
        </div>
    </div>
</template>
<script>
    import publicPath from "../lib/publicPath";
    import utils from "../lib/utils";
    import message from "../lib/message";
    import http from "../lib/http";
    import storage from "../lib/storage";
    import md5 from "js-md5";
    import config from "../config";
    export default {
        name: 'login',
        data() {
            return {
                postData: {}
            }
        },
        methods: {
            login() {
                let param=utils.NewObject(this.postData);
                if (utils.empty(param.username)) {
                    message.msg.error('账号不能为空');
                    return;
                }
                if (utils.empty(param.password)) {
                    message.msg.error('密码不能为空');
                    return;
                }
                message.loading.show("登录中");
                param.password=md5(param.password);
                http.post('login', param).then(data => {
                    storage.token.set(data.token);
                    publicPath.splice(0);
                    data.public_router.forEach(item=>{
                        if(item.visit===0){
                            publicPath.push(item.router);
                        }
                    });
                    this.$router.push({path:config.homePage})
                }).catch(()=> {});

            }
        }
    }
</script>
<style scoped>
    .login-body {
        height: 100%;
        width: 100%;
        background-image: url("../assets/images/login.jpg");
        background-repeat: no-repeat;
        background-size: 100% 100%;
    }

    .login {
        width: 300px;
        position: fixed;
        right: 5%;
        top: calc(50% - 200px);
    }
    .login-info >div{
        padding:8px 0;
        text-align:center;
    }
</style>
