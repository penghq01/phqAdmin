<template>
    <div>
        <div style="padding-bottom: 10px;">
            <el-button type="primary" size="mini" @click="showAdd(0)">添加</el-button>
        </div>
        <div>
            <el-table v-loading="loading" :data="treeAuthList" border size="mini"  row-key="id">
                <el-table-column label="标题" prop="title"></el-table-column>
                <el-table-column label="图标" width="70">
                    <template slot-scope="scope">
                        <span :class="scope.row.icon" style="font-size:22px;"></span>
                    </template>
                </el-table-column>
                <el-table-column label="前端界面" prop="crouter">
                    <template slot-scope="scope">
                        <el-tag v-show="getUiRouterName(scope.row.crouter)" effect="dark" size="mini">{{getUiRouterName(scope.row.crouter)}}</el-tag>
                    </template>
                </el-table-column>
                <el-table-column label="访问" :width="95">
                    <template slot-scope="scope">
                        <el-tag v-if="scope.row.visit==0" type="info" size="mini" >公开</el-tag>
                        <el-tag v-if="scope.row.visit==1" type="success" size="mini" >登录</el-tag>
                        <el-tag v-if="scope.row.visit==2" type="warning" size="mini" >权限</el-tag>
                        <el-tag v-if="scope.row.visit==3" type="danger" size="mini" >超级管理员</el-tag>
                    </template>
                </el-table-column>
                <el-table-column label="类型" :width="70">
                    <template slot-scope="scope">
                        <el-tag v-if="scope.row.auth_type==0" size="mini" >菜单</el-tag>
                        <el-tag v-if="scope.row.auth_type==1" type="info" size="mini" >分类</el-tag>
                    </template>
                </el-table-column>
                <el-table-column label="显示" :width="70">
                    <template slot-scope="scope">
                        <el-tag v-if="scope.row.is_show==0" type="info" size="mini" >隐藏</el-tag>
                        <el-tag v-if="scope.row.is_show==1" type="success" size="mini" >正常</el-tag>
                    </template>
                </el-table-column>
                <el-table-column label="排序" width="50" prop="sort"></el-table-column>
                <el-table-column label="操作" width="180">
                    <template slot-scope="scope">
                        <el-button type="primary"  @click="showAdd(scope.row.id,scope.row)" icon="el-icon-plus" size="mini"></el-button>
                        <el-button type="warning"  @click="showEdit(scope.row)" icon="el-icon-edit-outline" size="mini"></el-button>
                        <span class="interval-span"></span>
                        <Poptip
                                transfer
                                confirm
                                title="确定删除吗?"
                                @on-ok="del(scope.row)">
                            <el-button type="danger" size="mini" icon="el-icon-delete"></el-button>
                        </Poptip>
                    </template>
                </el-table-column>
            </el-table>
        </div>
        <myDialog
                :title="titleName"
                :is-show="opened"
                :close="close"
                width="40%"
                close-title="取 消"
                :ok-click="isEdit?edit:add"
                :ok-title="isEdit?'修改':'添加'"
        >
            <div class="input-div">权限标题：<el-input style="width:220px;" type="text" v-model="postAuth.title" placeholder="请输入标题"/></div>
            <div class="input-div">权限图标：<span v-if="postAuth.icon" :class="postAuth.icon"
                            style="font-size:30px;margin-right: 10px;"></span>
                <el-button type="primary" size="mini" @click="showIcon">选择图标</el-button>
            </div>
            <div class="input-div">前端界面：
                <Select style="width:80%;" v-model="postAuth.crouter" @on-change="selectUiRouter" clearable placeholder="请选择前端界面">
                    <Option v-for="(item,index) in uiRouterList" :value="item.path" :label="item.name" :key="index">
                        {{item.name}}<span class="select-tip">{{item.path}}</span>
                    </Option>
                </Select>
            </div>
            <div class="input-div">数据接口：<span style="font-size:12px;color:#aaaaaa;">可选择多个</span>
                <div class="auth">
                    <div>
                        <el-checkbox v-model="postAuth.auth.select.show" @change="checkBoxSelect">查询</el-checkbox><span class="interval-span"></span>
                        <Select v-show="postAuth.auth.select.show" style="width:85%;" v-model="postAuth.auth.select.router" multiple placeholder="请选择路由">
                            <Option v-for="(item,index) in routerList" :value="item.path" :label="item.name" :key="index">
                                {{item.name}}<span class="select-tip">{{item.path}}</span>
                            </Option>
                        </Select>
                    </div>
                    <div>
                        <el-checkbox v-model="postAuth.auth.add.show" @change="checkBoxAdd">添加</el-checkbox><span class="interval-span"></span>
                        <Select v-show="postAuth.auth.add.show" style="width:85%;" v-model="postAuth.auth.add.router" multiple placeholder="请选择路由">
                            <Option v-for="(item,index) in routerList" :value="item.path" :label="item.name" :key="index">
                                {{item.name}}<span class="select-tip">{{item.path}}</span>
                            </Option>
                        </Select>
                    </div>
                    <div>
                        <el-checkbox v-model="postAuth.auth.edit.show" @change="checkBoxEdit">修改</el-checkbox><span class="interval-span"></span>
                        <Select v-show="postAuth.auth.edit.show" style="width:85%;" v-model="postAuth.auth.edit.router" multiple placeholder="请选择路由">
                            <Option v-for="(item,index) in routerList" :value="item.path" :label="item.name" :key="index">
                                {{item.name}}<span class="select-tip">{{item.path}}</span>
                            </Option>
                        </Select>
                    </div>
                    <div>
                        <el-checkbox v-model="postAuth.auth.delete.show" @change="checkBoxDelete">删除</el-checkbox><span class="interval-span"></span>
                        <Select v-show="postAuth.auth.delete.show" style="width:85%;" v-model="postAuth.auth.delete.router" multiple placeholder="请选择路由">
                            <Option v-for="(item,index) in routerList" :value="item.path" :label="item.name" :key="index">
                                {{item.name}}<span class="select-tip">{{item.path}}</span>
                            </Option>
                        </Select>
                    </div>
                </div>
            </div>
            <div class="input-div">访问类型：
                <el-radio v-model="postAuth.visit" :label="0">公开</el-radio>
                <el-radio v-model="postAuth.visit" :label="1">登录</el-radio>
                <el-radio v-model="postAuth.visit" :label="2">权限</el-radio>
                <el-radio v-model="postAuth.visit" :label="3">超级管理员</el-radio>
            </div>
            <div class="input-div">权限类型：
                <el-radio v-model="postAuth.auth_type" :label="0">菜单</el-radio>
                <el-radio v-model="postAuth.auth_type" :label="1">分类</el-radio>
            </div>
            <div class="input-div">是否显示：
                <el-radio v-model="postAuth.is_show" :label="1">显示</el-radio>
                <el-radio v-model="postAuth.is_show" :label="0">隐藏</el-radio>
            </div>
            <div class="input-div">排序数值：<el-input type="text" style="width:80px;" v-model="postAuth.sort" placeholder="排序"/></div>
        </myDialog>
        <Pmodel v-model="showSelectIcon" :title="'选择图标'">
            <MyIcon :is-select="true" @on-select="selectIcon"></MyIcon>
        </Pmodel>
    </div>
</template>

<script>
    import Pmodel from "../../components/Pmodel"
    import MyIcon from "../../components/Icon"
    import utils from "../../lib/utils";
    import http from "../../lib/http";
    import message from "../../lib/message";
    export default {
        name: 'Auth',
        data() {
            return {
                showSelectIcon: false,
                titleName: "添加权限",
                opened: false,
                loading: true,
                isEdit: false,
                treeAuthList: [],
                routerList:[],
                uiRouterList:[],
                postAuth: {
                    auth:{
                        add:{show:false,router:""},
                        delete:{show:false,router:""},
                        edit:{show:false,router:""},
                        select:{show:false,router:""},
                    },
                    visit:2,
                    auth_type: 0,
                    is_show: 1,
                    sort:0}
            }
        },
        mounted() {
            this.getAuthList();
            this.getRouterList();
            let routes=this.$router.options.routes;
            this.routersToArror(routes);
        },
        methods: {
            getRouterList() {
                http.post("auth/get/router-list").then(data => {
                    this.routerList=data;
                }).catch(err => {
                });
            },
            listTotree(data,pid=0){
               let list=[];
               data.forEach((item,key)=>{
                   if(item.pid==pid){
                       let tem=utils.NewObject(item);
                       this.$set(tem,"children",this.listTotree(data,item.id));
                       if(!utils.empty(tem.auth)){
                           tem.auth=JSON.parse(tem.auth);
                       }
                       list.push(tem);
                       //data.splice(key,1);
                   }
               });
               return list;
            },
            delItem(id,list){
                list.forEach((item,key)=>{
                    if(item.id==id){
                        list.splice(key,1);
                        return false;
                    }else{
                        if(item.children!==undefined){
                            this.delItem(id,item.children);
                        }
                    }
                });
            },
            editItem(id,list,editItem){
                list.forEach((item,key)=>{
                    if(item.id==id){
                        this.$set(list,key,editItem);
                        return false;
                    }else{
                        if(item.children!==undefined){
                            this.editItem(id,item.children,editItem);
                        }
                    }
                });
            },
            addItem(id,list,addItem){
                list.forEach((item,key)=>{
                    if(item.id==id){
                        if(item.children==undefined){
                            this.$set(item,"children",[addItem]);
                        }else{
                            item.children.push(addItem);
                        }
                        return false;
                    }else{
                        if(item.children!==undefined){
                            this.addItem(id,item.children,addItem);
                        }
                    }
                });
            },
            getAuthList() {
                http.post("auth/list").then(data => {
                    this.treeAuthList=this.listTotree(data);
                    this.loading = false;
                }).catch(err => {
                });
            },
            close() {
                this.opened = false;
                this.postAuth = {
                    auth:{
                        add:{show:false,router:""},
                        delete:{show:false,router:""},
                        edit:{show:false,router:""},
                        select:{show:false,router:""},
                    },
                    visit:2,
                    auth_type: 0,
                    is_show: 1,
                    sort:0};
                this.titleName = "添加权限";
                this.isEdit = false;
            },
            add() {
                if (utils.empty(this.postAuth.title)) {
                    message.msg.error("权限标题不能为空");
                    return;
                }
               message.loading.show("正在添加");
                let postAuth=utils.NewObject(this.postAuth);
                postAuth.auth=JSON.stringify(postAuth.auth);
                postAuth.sort=parseInt(postAuth.sort);
                http.post("auth/add",postAuth).then(data => {
                       data.auth=JSON.parse(data.auth);
                       if(this.postAuth.pid<=0){
                            this.treeAuthList.push(data);
                       }else{
                           this.addItem(this.postAuth.pid,this.treeAuthList,data);
                        }
                    this.close();
                }).catch(err => {
                });
            },
            showEdit(row){
                this.postAuth=utils.NewObject(row);
                if(utils.empty(this.postAuth.auth)){
                    this.$set(this.postAuth,"auth",{
                        add:{show:false,router:""},
                        delete:{show:false,router:""},
                        edit:{show:false,router:""},
                        select:{show:false,router:""},
                    })
                }
                this.titleName=`正在修改【 ${row.title} 】`;
                this.isEdit=true;
                this.opened = true;
            },
            edit() {
                if (utils.empty(this.postAuth.title)) {
                   message.msg.error("权限标题不能为空");
                    return;
                }
               message.loading.show("正在修改");
                let postAuth=utils.NewObject(this.postAuth);
                postAuth.auth=JSON.stringify(postAuth.auth);
                postAuth.sort=parseInt(postAuth.sort);
                http.post("auth/edit",postAuth).then(()=> {
                    this.editItem(this.postAuth.id,this.treeAuthList,utils.NewObject(this.postAuth));
                    this.close();
                }).catch(err => {
                });
            },
            del(row){
                message.loading.show("正在删除");
                http.post("auth/del",{id:row.id}).then(data=>{
                    this.delItem(row.id,this.treeAuthList);
                }).catch(err=>{});
            },
            showIcon() {
                this.showSelectIcon = true;
            },
            selectIcon(icon) {
                this.postAuth.icon = icon;
                this.showSelectIcon = false;
            },
            showAdd(pid,row) {
                this.postAuth.pid =pid;
                this.postAuth.sort = 0;
                if(pid>0){
                    this.titleName=`添加【 ${row.title} 】的子权限`;
                 }
                this.opened = true;
            },
            checkBoxAdd(e){
               this.postAuth.auth.add.router="";
            },
            checkBoxDelete(e){
                this.postAuth.auth.delete.router="";
            },
            checkBoxEdit(e){
                this.postAuth.auth.edit.router="";
            },
            checkBoxSelect(e){
                this.postAuth.auth.select.router="";
            },
            aothSelect(e){
                console.log(e);
            },
            getUiRouterName(route){
                let name="";
                this.uiRouterList.forEach(item=>{
                    if(route==item.path){
                        name=item.name;
                    }
                });
                return name;
            },
            selectUiRouter(path){
                this.$set(this.postAuth,"title",this.getUiRouterName(path));
            },
            routersToArror(routes=[]){
                let list=[];
                routes.forEach(item=>{
                    if(!utils.empty(item.nickname)){
                        this.uiRouterList.push({"path":item.path,"name":item.nickname});
                    }
                    if(!utils.empty(item.children)){
                        this.routersToArror(item.children)
                    }
                });

            }
        },
        components: {
            Pmodel, MyIcon
        }
    }
</script>

<style scoped lang="scss">
    .add-uri {
        padding: 10px;
    }
    .auth{
        padding-left:45px;
        &>div{
            padding:5px;
        }
    }
    .select-tip{
        font-size:12px;
        color:$gray0-color;
        padding-left:10px;
    }
</style>
