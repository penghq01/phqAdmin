<template>
    <div class="upload-img">
        <div>
            <el-upload
                    class="upload-demo"
                    action="#"
                    :show-file-list="false"
                    :before-upload="beforeAvatarUpload"
                    :http-request="httpRequest">
                <div class="upload-btn" @click="selectUploadImageProgress=0">
                    <el-progress :text-inside="true" :stroke-width="24"
                                 :percentage="selectUploadImageProgress"></el-progress>
                    <div class="upload-btn-title">上传图片</div>
                </div>
            </el-upload>
        </div>
        <div class="files">
            <div class="files-class">
                <el-tree :data="classList" @node-drag-start="nodeDragStart" @node-drop="nodeDrop" @node-click="nodeClick" :allow-drag="allowDrag" :allow-drop="allowDrop" draggable node-key="id"  highlight-current  :expand-on-click-node="false">
                    <span class="custom-tree-node" slot-scope="{ node, data }">
                        <span class="tree-title">
                            <span class="tree-add" v-if="data.edit">
                                <input v-model="data.label" placeholder="请输入分类名称" />
                               <i class="el-icon-success" @click="editFileClass(node,data)"></i>
                            </span>
                            <span v-else>{{node.label}}</span>
                        </span>
                        <span class="tree-action">
                             <el-dropdown @command="handleCommand" trigger="click">
                                <span class="el-dropdown-link">
                                  <i class="el-icon-more"></i>
                                </span>
                                <el-dropdown-menu slot="dropdown">
                                    <el-dropdown-item :command="{'action':'add','data':data}"
                                                      icon="el-icon-plus">添加</el-dropdown-item>
                                    <el-dropdown-item v-if="data.id>0" :command="{'action':'edit','data':data}"
                                                      icon="el-icon-edit-outline">修改</el-dropdown-item>
                                    <el-dropdown-item v-if="data.id>0" :command="{'action':'delete','data':data,'node':node}"
                                                      icon="el-icon-delete">删除</el-dropdown-item>
                                </el-dropdown-menu>
                            </el-dropdown>
                        </span>
                    </span>
                </el-tree>
            </div>
            <div class="img-list">
                <div class="img-div" v-for="(img,index) in imgList" :key="index">
                    <img :src="imgHost+img"/>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    import message from "../lib/message";
    import http from "../lib/http";
    import utils from "../lib/utils";

    export default {
        name: "UploadImg",
        data() {
            return {
                imgHost: "http://localhost:8181/",
                selectUploadImageProgress: 0,
                imgList: [],
                classList: [{
                        id: 0,
                        pid:0,
                        label: '全部',
                        edit:false,
                        children:[]
                    }],
                postData:{},
                dropNode:{},
                dropNodeIndex:-1,
                selectFileClassId:0
            }
        },
        mounted() {
            this.getFileClassList();
        },
        methods: {
            //把分类列表转为树结构
            classListToTree(id,list){
                let resList=[];
                list.forEach(item=>{
                    if(item.pid==id){
                        resList.push({id:item.id,pid:item.pid,label:item.label,edit:false,children:this.classListToTree(item.id,list)});
                    }
                });
                return resList;
            },
            //回去分类列表
            getFileClassList(){
                message.loading.show("加载数据");
                http.post("/files/list/class").then(data=>{
                    this.$set( this.classList[0],"children",this.classListToTree(0,data));
                }).catch(err=>{});
            },
            //选择上传前回调
            beforeAvatarUpload(file) {
                const isJPG = file.type === 'image/jpeg';
                const isLt2M = file.size / 1024 / 1024 < 30;
                if (!isJPG) {
                    message.msg.error('只能上传图片!');
                }
                if (!isLt2M) {
                    message.msg.error('上传图片大小不能超过 30MB!');
                }
                return isJPG && isLt2M;
            },
            //自定义上传回调
            httpRequest(file) {
                let param = new FormData();
                param.append('upload_img', file.file);
                http.post("/files/upload/img", param, true, true, progress => {
                    this.selectUploadImageProgress = parseInt((progress.loaded / progress.total) * 100);
                }).then(data => {
                    this.imgList.unshift(data);
                }).catch(err => {
                    this.selectUploadImageProgress = 0;
                });
            },
            //节点操作指令回调
            handleCommand(command) {
                switch (command.action) {
                    case "add":
                        this.appendTree(command.data);
                        break;
                    case "delete":
                        this.removeTree(command.node,command.data);
                        break;
                    case "edit":
                        this.editTree(command.data);
                    default:
                        break;
                }
            },
            //添加节点
            appendTree(data) {
                const newChild = {id:0,pid:data.id,edit:true,label:'', children: []};
                if (utils.empty(data.children)) {
                    this.$set(data, 'children', []);
                }
                data.children.push(newChild);
            },
            //添加修改节点
            editFileClass(node, data){
                    if(utils.empty(data.label)){
                        message.msg.error("分类名称不能为空");
                        return
                    }
                    if(data.id>0){
                        message.loading.show("修改中");
                        http.post("/files/edit/class",{"id":data.id,"pid":data.pid,"label":data.label}).then(res=>{
                            data.edit=false;
                        }).catch(err=>{data.edit=false;});
                    }else{
                        message.loading.show("添加中");
                        http.post("/files/add/class",{"label":data.label,"pid":data.pid}).then(res=>{
                            //console.log(res);
                            data.id=res.id;
                            data.edit=false;
                        }).catch(err=>{
                            this.removeTree(node, data)
                        });
                    }
            },
            //启动用节点编辑
            editTree(data){
                if(data.id>0){
                    data.edit=true;
                }
            },
            //删除节点
            removeTree(node, data) {
                if(data.id>0){
                    message.confirm("确定要删除吗？",{okName:"删除",okFunction:()=>{
                            message.loading.show("删除中");
                            http.post("/files/del/class",{"id":data.id}).then(res=>{
                                const parent = node.parent;
                                const children = parent.data.children || parent.data;
                                const index = children.findIndex(d => d.id === data.id);
                                children.splice(index, 1);
                            }).catch(err=>{});
                        }});
                }
            },
            //节点被点击时的回调
            nodeClick(data){
              this.selectFileClassId=data.id;
            },
            //判断节点能否被拖拽
            allowDrag(node){
                return node.data.id>0
            },
            //拖拽时判定目标节点能否被放置
            allowDrop(draggingNode, dropNode, type){
                if(type=="inner"){
                    return true;
                }
            },
            //拖拽成功完成时触发的事件
            nodeDrop(dropNode, toNode, type){
                //console.log(toNode);
                message.loading.show("修改中");
                http.post("/files/edit/class",{"id":dropNode.data.id,"pid":toNode.data.id,"label":dropNode.data.label}).then(res=>{
                    dropNode.data.pid=toNode.data.id;
                }).catch(err=>{
                    this.dropNode.children.splice(this.dropNodeIndex,0,dropNode.data);
                    let index=toNode.data.children.findIndex(i=>i.id==dropNode.data.id);
                    toNode.data.children.splice(index,1);
                });
            },
            //节点开始拖拽时触发的事件
            nodeDragStart(node){
                this.dropNode=node.parent.data;
                this.dropNodeIndex=node.parent.data.children.findIndex(item=>item.id==node.data.id);
            }
        },
    }
</script>

<style scoped lang="scss">
    .upload-demo {
        width: 100%;
    }

    .upload-btn {
        width: 100%;
        color: #FFFFFF;
        position: relative;

        &-jd {
            height: 40px;
        }

        &-title {
            position: absolute;
            top: 2px;
            color: $dark-color;
            left: calc(50% - 50px);
        }
    }

    .files {
        display: flex;
    }
    .click-node{
        color:$primary-color;
    }
    .tree-add{
        display:flex;
        align-items:center;
        &>input{
          border-radius:5px;
            border:1px $gray2-color solid;
            box-shadow:0 0 5px $gray1-color;
            font-size:14px;
            padding:0 5px;
            width:120px;
        }
        &>i{
            font-size:22px;
            margin-left:5px;
            color:$primary-color;
            &:active{
               color:$primary-color-active;
            }
        }
    }
    .files-class {
        margin-top: 10px;
        padding: 10px;
        box-shadow: 0 0 5px $gray2-color;
    }

    .custom-tree-node {
        padding: 10px 5px;
    }

    .tree-title {
        display: inline-block;
        padding-right: 5px;
    }

    .tree-action {
        & .el-dropdown-link {
            color:$gray0-color;
        }
    }

    .img-list {
        display: flex;
        flex-wrap: wrap;
        padding-top: 15px;
        box-shadow: 0 0 5px $gray2-color;

        & > div {
            width: 122px;
            height: 122px;
            display: flex;
            justify-content: center;
            align-items: center;
            margin-right: 15px;
            margin-bottom: 15px;
            border: 1px $gray2-color solid;
            background-color: $gray2-color;

            & > img {
                max-width: 120px;
                max-height: 120px;
            }
        }
    }
</style>