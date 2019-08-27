<template>
    <div class="home">
        <div class="index-left">
            <Menu :list="menuTreeList" :active-menu="activeMenu" @select="triggerSelect"/>
        </div>
        <div class="index-right">
            <div class="index-header">
                <div class="router">
                    <transition-group name="list-complete" tag="div">
                       <div v-for="(item,index) in routerHistory" :key="item.id" :class="item.active?'active':''" @click="triggerSelect(item.key)">
                           {{item.title}}
                           <i class="el-icon-error" @click.stop="delRouterHistory(index)"></i>
                       </div>
                   </transition-group>
                </div>
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
    import message from "../lib/message";
    export default {
        name: 'home',
        data() {
            return {
                editUser: {},
                opened: false,
                userInfo: {},
                activeMenu:"/index",
                routerHistory:[],
                menuList:[],
                menuTreeList:[],
                isPush:false,
            }
        },
        mounted() {
            this.activeMenu=this.$router.history.current.path;
            //this.routerHistory=storage.routerHistory.get();
            this.getUserInfo();
            this.getAuthList();
        },
        methods: {
            triggerSelect(key) {
                let index=this.routerHistory.findIndex(r=>r.key==key);
                this.routerHistory.forEach(r=>r.active=false);
                if(index<0){
                    let i=this.menuList.findIndex(i=>i.crouter==key);
                    let title="";
                    let id=this.routerHistory.length+1;
                    if(i>=0){
                        title=this.menuList[i].title;
                        id=this.menuList[i].id;
                    }
                    this.routerHistory.push({"key":key,"active":true,"title":title,"id":id});
                }else{
                    this.routerHistory[index].active=true;
                }
                if(this.$router.history.current.path!=key){
                    this.activeMenu=key;
                    this.$router.push({'path': key})
                }
                storage.routerHistory.set(this.routerHistory);
            },
            delRouterHistory(index){
                if(this.routerHistory.length>1){
                    let active=this.routerHistory[index].active;
                    this.routerHistory.splice(index,1);
                    if(active){
                       index-=1;
                       if(index<0){
                           index=0;
                       }
                       this.routerHistory[index].active=true;
                       this.triggerSelect(this.routerHistory[index].key);
                    }
                }
            },
            listTotree(data,pid=0){
                let list=[];
                data.forEach((item,key)=>{
                    if(item.pid==pid){
                        let tem={"title":item.title,"key":item.crouter,"icon":item.icon};
                        let cd=this.listTotree(data,item.id);
                        if(cd.length>0){
                            tem.key=item.pid+"-"+item.id;
                            this.$set(tem,"children",cd);
                        }
                        if(!utils.empty(tem.auth)){
                            tem.auth=JSON.parse(tem.auth);
                        }
                        list.push(tem);
                        //data.splice(key,1);
                    }
                });
                return list;
            },
            getAuthList() {
                http.post("/admin/auth",{is_show:1,auth_type:0}).then(data => {
                    this.menuList=data;
                    this.menuTreeList=this.listTotree(data);
                    if(!this.isPush){
                        this.triggerSelect(this.$router.history.current.path);
                        this.isPush=true;
                    }
                    //console.log(this.menuTreeList);
                }).catch(err => {
                });
            },
            getUserInfo() {
                http.post("admin/info").then(data => {
                    this.userInfo = data;
                }).catch(err => {
                });
            },
            outLogin() {
                message.confirm("确定要推出登录吗?", {
                    okName: "确定退出", okFunction: () => {
                        storage.clearToken();
                        window.location.href = '/login';
                    }
                });
            },
            editPassword() {
                if (utils.empty(this.editUser.oldpass)) {
                    message.msg.error("旧密码不能为空");
                    return;
                }
                if (utils.empty(this.editUser.newpass)) {
                    message.msg.error("新密码不能为空");
                    return;
                }
                if (this.editUser.newpass != this.editUser.okpass) {
                    message.msg.error("两输入的新密码不一致");
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
        width:150px;
        color: #327AA3;
        position: relative;
        height: 100%;
        display:flex;
        align-items:center;
        justify-content: center;
        text-align: center;
        &>i{
            margin-right:5px;
        }
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
    .router{
        height:100%;
        width:calc(100% - 150px);
        &>div{
            height:100%;
            width:100%;
            background-color:$gray4-color;
            position:relative;
            display:flex;
            align-items:center;
            &>div{
                display:flex;
                justify-content:center;
                align-items:center;
                transition:all 0.8s ease-out;
                &>i{
                    margin-left:8px;
                    font-size:18px;
                    transition:all 0.8s ease-out;
                    &:hover{
                      //color:$red-color;
                      transform:scale(1.3) rotateZ(360deg);
                    }
                }
                background-color:#ffffff;
                height:30px;
                padding:0 6px;
                border-radius:5px;
                cursor:pointer;
                margin:0 5px;
                border:1px $gray1-color solid;
                &:hover{
                    border:1px $primary-gray solid;
                    background-color:$primary-gray;
                }
            }
            & > .active{
                color:#ffffff;
                background-color:$primary-color;
                &:hover{
                    background-color:$primary-color;
                }
            }
        }
    }
   .list-complete-enter{
        opacity: 0;
        transform: translateX(80px);
    }
    .list-complete-leave-active{
        opacity:0;
        position: absolute;
    }
    .list-complete-move{

        transition:all 1s ease-out;
    }

</style>
