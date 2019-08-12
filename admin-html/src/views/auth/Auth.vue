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
                <el-table-column label="前端路由" prop="croute"></el-table-column>
                <el-table-column label="后端路由" prop="sroute"></el-table-column>
                <el-table-column label="类型" :width="65">
                    <template slot-scope="scope">

                        <el-tag v-if="scope.row.auth_type==0" size="mini" >菜单</el-tag>
                        <el-tag v-if="scope.row.auth_type==1" type="warning" size="mini" >操作</el-tag>
                    </template>
                </el-table-column>
                <el-table-column label="显示" :width="65">
                    <template slot-scope="scope">
                        <el-tag v-if="scope.row.is_show==0" type="info" size="mini" >隐藏</el-tag>
                        <el-tag v-if="scope.row.is_show==1" type="success" size="mini" >正常</el-tag>
                    </template>
                </el-table-column>
                <el-table-column label="排序" width="70" prop="sort"></el-table-column>
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
                close-title="取 消"
                :ok-click="isEdit?edit:add"
                :ok-title="isEdit?'修改':'添加'"
        >
            <div class="input-div">权限标题：<el-input style="width:220px;" type="text" v-model="postAuth.title" placeholder="请输入标题"/></div>
            <div class="input-div">权限图标：<span v-if="postAuth.icon" :class="postAuth.icon"
                            style="font-size:30px;margin-right: 10px;"></span>
                <el-button type="primary" size="mini" @click="showIcon">选择图标</el-button>
            </div>
            <div class="input-div">前端路由：<el-input style="width:220px;" type="text" v-model="postAuth.croute" placeholder="请输入前端路由"/></div>
            <div class="input-div">后端路由：<el-input style="width:220px;" type="text" v-model="postAuth.sroute" placeholder="请输入后端路由"/></div>
            <div class="input-div">权限类型：
                <el-radio v-model="postAuth.auth_type" :label="0">菜单</el-radio>
                <el-radio v-model="postAuth.auth_type" :label="1">操作</el-radio>
            </div>
            <div class="input-div">是否显示：
                <el-radio v-model="postAuth.is_show" :label="1">显示</el-radio>
                <el-radio v-model="postAuth.is_show" :label="0">隐藏</el-radio>
            </div>
            <div class="input-div">排序数值：<el-input type="text" style="width:80px;" v-model="postAuth.sort" placeholder="排序"/></div>
        </myDialog>
        <Pmodel v-model="showSelectIcon" :title="'选择图标'">
            <icon :is-select="true" @on-select="selectIcon"></icon>
        </Pmodel>
    </div>
</template>

<script>
    import Pmodel from "../../components/Pmodel"
    import Icon from "../../components/Icon"
    import utils from "../../lib/utils";
    import http from "../../lib/http";

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
                postAuth: {auth_type: 0, is_show: 1}
            }
        },
        mounted() {
            this.getAuthList();
        },
        methods: {
            listTotree(data,pid=0){
               let list=[];
               data.forEach((item,key)=>{
                   if(item.pid==pid){
                       let tem=utils.NewObject(item);
                       this.$set(tem,"children",this.listTotree(data,item.id));
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
                this.postAuth = {auth_type: 0, is_show: 1};
                this.titleName = "添加权限";
                this.isEdit = false;
            },
            add() {
                if (utils.empty(this.postAuth.title)) {
                    this.message.msg.error("权限标题不能为空");
                    return;
                }
                this.message.loading.show("正在添加");
                this.postAuth.sort=parseInt(this.postAuth.sort);
                http.post("auth/add", this.postAuth).then(data => {
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
                this.titleName=`正在修改【 ${row.title} 】`;
                this.isEdit=true;
                this.opened = true;
            },
            edit() {
                if (utils.empty(this.postAuth.title)) {
                    this.message.msg.error("权限标题不能为空");
                    return;
                }
                this.message.loading.show("正在修改");
                this.postAuth.sort=parseInt(this.postAuth.sort);
                http.post("auth/edit", this.postAuth).then(()=> {
                    this.editItem(this.postAuth.id,this.treeAuthList,utils.NewObject(this.postAuth));
                    this.close();
                }).catch(err => {
                });
            },
            del(row){
                this.message.loading.show("正在删除");
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
            }
        },
        components: {
            Pmodel, Icon
        }
    }
</script>

<style scoped lang="scss">
    .add-uri {
        padding: 10px;
    }
</style>
