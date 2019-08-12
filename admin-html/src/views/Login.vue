<template>
    <div class="login-body">
        <div class="login">
            <el-card class="box-card">
                <div slot="header" class="clearfix">
                    <span>管理员登录</span>
                    <el-button style="float: right; padding: 3px 0" type="text">没有账号？请联系管理员</el-button>
                </div>
                <div class="login-info">
                   <div> <el-input v-model="postData.username"  placeholder="请输登录账号"></el-input></div>
                    <div> <el-input type="password" v-model="postData.password" placeholder="请输入密码"></el-input></div>
                    <div> <el-button type="primary" @click="login">登录</el-button></div>
                </div>
            </el-card>
        </div>
    </div>
</template>
<script>
    import api from '../lib/api/api'

    export default {
        name: 'login',
        data() {
            return {
                postData: {}
            }
        },
        methods: {
            login() {
                api.Login(this.postData).then(() => this.$router.push({path: '/'}));
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
        right: 15%;
        top: calc(50% - 200px);
    }
    .login-info >div{
        padding:8px 0;
        text-align:center;
    }
</style>
