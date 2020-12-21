<template>
    <div class="home" :style="`padding-left:${isCollapse?64:240}px;${homePaddingTop}`">
        <div class="home-left" :style="`width:${isCollapse?64:240}px;${leftAndHeaderTop}`">
            <div class="home-left-sysname">
                <span v-show="!isCollapse"> {{sysName}}</span>
                <el-tooltip effect="dark" content="收起展开菜单" placement="right">
                    <i @click="isCollapse=!isCollapse" :class="isCollapse?'el-icon-s-unfold':'el-icon-s-fold'"></i>
                </el-tooltip>
            </div>
            <div class="home-left-menu">
              <MyMenu :is-collapse="isCollapse" :list="menuTreeList" :active-menu="activeMenu" @select="triggerSelect"/>
            </div>
        </div>
        <div class="home-header" :style="`left:${isCollapse?64:240}px;width:calc(100% - ${isCollapse?64:240}px);${leftAndHeaderTop}`">
            <div class="home-header-info">
                <div class="user">
                    <i class="fa fa-user" aria-hidden="true"></i> 欢迎：{{userInfo.username}}
                    <div class="user-info">
                        <div v-if="uiAuth._admin_api_admin_edit_pass" @click="opened=true">修改密码</div>
                        <!--<div v-if="uiAuth._admin_api_admin_info">个人信息</div>-->
                        <div @click="outLogin">退出登录</div>
                    </div>
                </div>
            </div>
            <div class="home-header-history">
                <div class="routerLeft" @click="leftMove"><i class="el-icon-caret-left"></i></div>
                <div class="router" ref="routerHistory">
                    <transition-group ref="routerHistoryBox" name="list-complete" tag="div"
                                      :style="{width:routerHistoryWidth+'px',left:routerHistoryLeft+'px'}">
                        <div ref="routerHistoryList" v-for="(item,index) in routerHistory" :key="item.id"
                             :class="item.active?'active':''" @click="triggerSelect(item.key)">
                            {{item.title}}
                            <i class="el-icon-close" @click.stop="delRouterHistory(index)"></i>
                        </div>
                    </transition-group>
                </div>
                <div class="routerRight" @click="rightMove"><i class="el-icon-caret-right"></i></div>
            </div>
        </div>
        <div class="home-content">
            <router-view></router-view>
        </div>
        <Dialog
                title="修改登录密码"
                :is-show="opened"
                :close="close"
                close-title="取 消"
                :ok-click="editPassword"
                ok-title="保存修改">
            <div class="input-div"><el-input type="password" v-model="editUser.oldpass" placeholder="请输入旧的密码"/></div>
            <div class="input-div"><el-input type="password" v-model="editUser.newpass" placeholder="请输入新密码"/></div>
            <div class="input-div"><el-input type="password" v-model="editUser.okpass" placeholder="请再次输入密码"/></div>
        </Dialog>
    </div>
</template>

<script>
    import http from "../lib/http";
    import storage from "../lib/storage";
    import utils from "../lib/utils";
    import md5 from "js-md5";
    import MyMenu from "../components/Menu/MyMenu";
    import message from "../lib/message";
    import config from "../config";
    import myDialog from "../components/myDialog";
    import {mapState,mapActions} from "vuex";
    export default {
        name: 'home',
        components:{MyMenu,myDialog},
        data() {
            return {
                isCollapse:false,
                sysName:config.sysName,
                editUser: {},
                opened: false,
                activeMenu:"/index",
                routerHistory:[],
                isPush:false,
                routerHistoryWidth:0,
                routerHistoryLeft:0,
                platform:{isWeb:false,isPC:false},
            }
        },
        computed:{
            ...mapState(["uiAuth","userInfo","routerList","menuTreeList"]),
            leftAndHeaderTop(){
                if(this.platform.isWeb){
                    return "top:0";
                }else if(this.platform.isPC){
                    return "top:40px";
                }
            },
            homePaddingTop(){
                if(this.platform.isWeb){
                    return "padding-top:90px";
                }else if(this.platform.isPC){
                    return "padding-top:130px";
                }
            }
        },
        watch:{
            routerList(){
                this.setTriggerSelect();
            },
			$route(to,from){
                this.activeMenu = to.path;
                this.isPush=false;
                this.setTriggerSelect();
            }
        },
        mounted() {
            this.platform=config.platform;
            this.activeMenu=this.$router.history.current.path;
            this.updateUIAuth();
            this.updateRouterList(this.$router);
            this.updateUserInfo();
        },
        methods: {
            ...mapActions(["updateUIAuth","updateUserInfo","updateRouterList"]),
            setTriggerSelect(){
                if(!this.isPush){
                    this.triggerSelect(this.$router.history.current.path);
                    this.isPush=true;
                }
            },
            //点击菜单时触发
            triggerSelect(key) {
                let router=this.$router.history.current;
                let index=this.routerHistory.findIndex(r=>r.key===key);
                this.routerHistory.forEach(r=>r.active=false);
                if(index<0){
                    let i=this.routerList.findIndex(i=>i.router===key);
                    let title="";
                    let id=this.routerHistory.length+1;
                    if(i>=0){
                        title=this.routerList[i].title;
                        id=this.routerList[i].id;
                    }
                    this.routerHistory.push({"key":key,"active":true,cache:true,"title":title,"id":id});
                }else{
                    this.routerHistory[index].active=true;
                }
                if(router.path!==key){
                    this.activeMenu=key;
                    this.$router.push({'path': key});
                }
                this.calcRouterHistoryWidth();
            },
            //点击菜单时触发计算打开菜单历史移动方式
            calcRouterHistoryWidth(){
               this.$nextTick(()=>{
                   let Routerwidth=this.$refs.routerHistory.offsetWidth;
                   let list=this.$refs.routerHistoryList;
                   let width=list.length*10;
                   let active=null;
                   list.forEach(e=>{
                       e.classList.forEach(i=>{
                           if(i=="active"){
                               active=e;
                           }
                       });
                       width+=e.offsetWidth;
                   });
                   width=parseFloat(width.toFixed(2));
                   if(Routerwidth<width){
                       this.routerHistoryWidth=width;
                       let activeLeft=active.offsetLeft;
                       let activeWidth=active.offsetWidth;
                       let eLeft=this.routerHistoryLeft;
                       activeLeft=activeLeft - Math.abs(eLeft);
                       if(activeLeft < 5){
                           eLeft=eLeft+(5-activeLeft);
                           this.routerHistoryLeft=eLeft;
                       }else{
                           let maxSeeOff=Routerwidth-activeWidth-10;
                           if(activeLeft > maxSeeOff){
                               eLeft=eLeft+(activeLeft-maxSeeOff)*-1;
                               this.routerHistoryLeft=eLeft;
                           }
                       }
                   }else{
                       this.routerHistoryWidth=Routerwidth;
                       this.routerHistoryLeft=0;
                   }
               });
            },
            //删除菜单历史
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
            //菜单历史左移动
            leftMove(){
                let Routerwidth=this.$refs.routerHistory.offsetWidth;
                let list=this.$refs.routerHistoryList;
                let width=list.length*10;
                list.forEach(e=>{
                    width+=e.offsetWidth;
                });
                width=parseFloat(width.toFixed(2));
                if(Routerwidth<width){
                    this.routerHistoryLeft+=100;
                    if(this.routerHistoryLeft>0){
                        this.routerHistoryLeft=0;
                    }
                }
            },
            //菜单历史右移动
            rightMove(){
                let Routerwidth=this.$refs.routerHistory.offsetWidth;
                let list=this.$refs.routerHistoryList;
                let width=list.length*10;
                list.forEach(e=>{
                    width+=e.offsetWidth;
                });
                width=parseFloat(width.toFixed(2));
                if(Routerwidth<width){
                    let maxMove=Routerwidth-width;
                    this.routerHistoryLeft-=100;
                    if(this.routerHistoryLeft<maxMove){
                        this.routerHistoryLeft=maxMove;
                    }
                }
            },
            outLogin() {
                message.confirm("确定要退出登录吗?", {
                    okName: "确定退出", okFunction: () => {
                        storage.clear();
                        this.$router.push({'path': "/login"});
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
            },
        }
    }
</script>
<style scoped lang="scss">
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
