<template>
    <div class="home">
        <div class="index-left">
            <Menu :list="menuTreeList" :active-menu="activeMenu" @select="triggerSelect"/>
        </div>
        <div class="index-right">
            <div class="index-header">

                <div class="user">
                    <i class="fa fa-user" aria-hidden="true"></i> 欢迎：{{userInfo.username}}
                    <div class="user-info">
                        <div @click="opened=true">修改密码</div>
                        <div>个人信息</div>
                        <div @click="outLogin">退出登录</div>
                    </div>
                </div>
            </div>
            <div class="index-content">
                <div class="admin-index">
                    <router-view/>
                </div>
            </div>
        </div>
        <myDialog
                title="修改登录密码"
                :is-show="opened"
                :close="close"
                close-title="取 消"
                :ok-click="editPassword"
                ok-title="保存修改"
        >
            <div class="input-div"><el-input type="password" v-model="editUser.oldpass" placeholder="请输入旧的密码"/></div>
            <div class="input-div"><el-input type="password" v-model="editUser.newpass" placeholder="请输入新密码"/></div>
            <div class="input-div"><el-input type="password" v-model="editUser.okpass" placeholder="请再次输入密码"/></div>
        </myDialog>
    </div>
</template>

<script>
    import http from "../lib/http";
    import storage from "../lib/storage";
    import utils from "../lib/utils";
    import md5 from "js-md5"
    import Menu from "../components/Menu/Menu"
    export default {
        name: 'home',
        data() {
            return {
                editUser: {},
                opened: false,
                userInfo: {},
                activeMenu:"/index",
                menuTreeList: [
                    {
                        title: '首页',
                        key: '/index',
                        icon: 'fa fa-home'
                    },
                    {
                        title: '系统与安全',
                        icon: 'fa fa-vcard',
                        key: 'admin-admin',
                        children: [
                            {
                                title: '管理员管理',
                                icon: 'fa fa-user',
                                key: '/admin'
                            },
                            {
                                title: '角色管理',
                                icon: 'fa fa-address-book',
                                key: '/role'
                            },
                            {
                                title: '权限管理',
                                icon: 'fa fa-sitemap',
                                key: '/auth'
                            }
                        ]
                    },
                    {
                        title: '附件管理',
                        icon: 'fa fa-folder-open',
                        key: 'admin-folder',
                        children: [
                            {
                                title: '图标管理',
                                icon: 'fa fa-free-code-camp',
                                key: '/icon'
                            }
                        ]
                    },
                    {
                        title: '用户管理',
                        icon: 'fa fa-user',
                        key: 'admin-user',
                        children: [
                            {
                                title: '会员列表',
                                icon: 'fa fa-users',
                                key: '/user'
                            },
                            {
                                title: '充值记录',
                                icon: 'fa fa-money',
                                key: '/paylog'
                            }
                        ]
                    }
                ]
            }
        },
        mounted() {
            this.activeMenu=this.$router.history.current.path;
            this.getUserInfo();
        },
        methods: {
            triggerSelect(key) {
                this.$router.push({'path': key})
            },
            getUserInfo() {
                http.post("admin/info").then(data => {
                    this.userInfo = data;
                }).catch(err => {
                });
            },
            outLogin() {
                this.message.confirm("确定要推出登录吗?", {
                    okName: "确定退出", okFunction: () => {
                        storage.clearToken();
                        window.location.href = '/login';
                    }
                });
            },
            editPassword() {
                if (utils.empty(this.editUser.oldpass)) {
                    this.message.msg.error("旧密码不能为空");
                    return;
                }
                if (utils.empty(this.editUser.newpass)) {
                    this.message.msg.error("新密码不能为空");
                    return;
                }
                if (this.editUser.newpass != this.editUser.okpass) {
                    this.message.msg.error("两输入的新密码不一致");
                    return;
                }
                http.post("admin/edit/pass", {
                    "old": md5(this.editUser.oldpass),
                    "new": md5(this.editUser.newpass)
                }).then(() => {
                    this.close();
                }).catch(err => {
                })
            },
            close() {
                this.opened = false;
                this.editUser = {};
            }
        },
        components:{Menu}
    }
</script>
<style scoped lang="scss">
    .home {
        width: 100%;
        height: 100%;
        display: flex;
    }

    .user {
        color: #327AA3;
        position: relative;
        height: 100%;
        display:flex;
        align-items:center;
        padding:0 20px;
        text-align: center;
        & > div {
            display: none;
            width:100%;
        }

        &:hover {
            background-color: $blue-color;
            color: #fff;
            cursor: pointer;
            & > div {
                display: block;
                position: absolute;
                width:100%;
                z-index: 9999;
                background-color: #fff;
                box-shadow: 0 0 5px #A7A7A7;
                left: 0;
                top: 100%;
                padding: 10px;
                color: #363636;
                & > div {
                    width: 100%;
                    padding: 5px;
                    text-align: center;
                    &:hover {
                        color: #0C7BBB;
                    }
                }
            }
        }
    }
</style>
