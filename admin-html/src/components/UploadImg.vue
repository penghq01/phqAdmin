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
                <el-tree :data="classList" @node-drag-start="nodeDragStart" @node-drop="nodeDrop"
                         @node-click="nodeClick" :allow-drag="allowDrag" :allow-drop="allowDrop" draggable node-key="id"
                         highlight-current default-expand-all :expand-on-click-node="false">
                    <span class="custom-tree-node" slot-scope="{ node, data }">
                        <span class="tree-title">
                            <span class="tree-add" v-if="data.edit">
                                <i class="el-icon-error" @click="closeEdit(node,data)"></i>
                                <input v-model="data.label" placeholder="请输入分类名称"/>
                               <i class="el-icon-success" @click="editFileClass(node,data)"></i>
                            </span>
                            <span v-else>{{node.label}}</span>
                        </span>
                        <span class="tree-action">
                             <el-dropdown @command="handleCommand" trigger="hover">
                                <span class="el-dropdown-link">
                                  <i class="el-icon-more"></i>
                                </span>
                                <el-dropdown-menu slot="dropdown">
                                    <el-dropdown-item :command="{'action':'add','data':data}" icon="el-icon-plus">添加</el-dropdown-item>
                                    <el-dropdown-item v-if="data.id>0" :command="{'action':'edit','data':data}" icon="el-icon-edit-outline">修改</el-dropdown-item>
                                    <el-dropdown-item v-if="data.id>0" :command="{'action':'delete','data':data,'node':node}" icon="el-icon-delete">删除</el-dropdown-item>
                                </el-dropdown-menu>
                            </el-dropdown>
                        </span>
                    </span>
                </el-tree>
            </div>
            <div class="file-list">
                <transition-group name="list-animate" tag="div">
                    <div class="img-list" v-for="(img,index) in imgList" :key="img.id">
                        <div v-if="isSelect" class="img-action img-action-see" @click="selectImg(img)">选择图片</div>
                        <img @click="previewImg=img.src" :src="imgHost+img.src"/>
                        <div class="img-action img-action-del" @click="delImg(img)">删除</div>
                    </div>
                </transition-group>

                <div v-show="imgList.length==0">暂无图片</div>
                <Paging v-model="pageData" @change="pageChange"></Paging>

            </div>
        </div>
        <PreviewImg v-model="previewImg"/>
    </div>
</template>

<script>
    import message from "../lib/message";
    import http from "../lib/http";
    import utils from "../lib/utils";
    import config from "../config"
    import logic from "../lib/logic";
    import PreviewImg from "./PreviewImg";
    export default {
        name: "UploadImg",
        components:{PreviewImg},
        props:{
            isSelect:{
                type:Boolean,
                default:false
            }
        },
        data() {
            return {
                imgHost:"",
                selectUploadImageProgress: 0,
                imgList:[],
                previewImg:"",
                classList: [{
                    id: 0,
                    pid: 0,
                    label: '全部',
                    edit: false,
                    children: []
                }],
                postData: {},
                dropNode: {},
                dropNodeIndex: -1,
                selectFileClassId: 0,
                pageData: {
                    page: 1,
                    page_size: 20,
                    total_count: 0
                }
            }
        },
        mounted() {
            message.loading.show();
            this.imgHost=config.imgHost;
            this.getImageList();
            this.getFileClassList();
        },
        methods: {
            //把分类列表转为树结构
            classListToTree(id, list) {
                let resList = [];
                list.forEach(item => {
                    if (item.pid == id) {
                        resList.push({
                            id: item.id,
                            pid: item.pid,
                            label: item.label,
                            edit: false,
                            children: this.classListToTree(item.id, list)
                        });
                    }
                });
                return resList;
            },
            //获取分类列表
            getFileClassList() {
                message.loading.show("加载数据");
                http.post("files/list/class").then(data => {
                    this.$set(this.classList[0], "children", this.classListToTree(0, data));
                }).catch(err => {
                });
            },
            //获取图片列表
            getImageList() {
                http.post(`files/list/${this.pageData.page_size}/${this.pageData.page}`, {"class_id": this.selectFileClassId}).then(list => {
                    this.imgList=list.data;
                    this.pageData = list.paginate;
                }).catch(err => {
                    this.imgList=[];
                });
            },
            //选择上传前回调
            beforeAvatarUpload(file) {
                const isJPG = file.type == 'image/jpeg' || file.type == 'image/png';
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
                let param = {
                "upload_img":file.file,
                "class_id":this.selectFileClassId
                };
                http.upload("files/upload/img",param,progress=> {
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
                        this.deleteTree(command.node, command.data);
                        break;
                    case "edit":
                        this.editTree(command.data);
                    default:
                        break;
                }
            },
            //添加节点
            appendTree(data) {
                const newChild = {id: 0, pid: data.id, edit: true, label: '', children: []};
                if (utils.empty(data.children)) {
                    this.$set(data, 'children', []);
                }
                data.children.push(newChild);
            },
            //添加修改节点
            editFileClass(node, data) {
                if (utils.empty(data.label)) {
                    message.msg.error("分类名称不能为空");
                    return
                }
                if (data.id > 0) {
                    if( this.menuAuth.edit){
                        message.loading.show("修改中");
                        http.post("files/edit/class", {"id": data.id, "pid": data.pid, "label": data.label}).then(res => {
                            data.edit = false;
                        }).catch(err => {
                            data.edit = false;
                        });
                    }

                } else {
                    if( this.menuAuth.add) {
                        message.loading.show("添加中");
                        http.post("files/add/class", {"label": data.label, "pid": data.pid}).then(res => {
                            //console.log(res);
                            data.id = res.id;
                            data.edit = false;
                            this.selectFileClassId =  res.id;
                        }).catch(err => {
                            this.removeTree(node, data)
                        });
                    }
                }
            },
            //启用用节点编辑
            editTree(data) {
                if (data.id > 0) {
                    data.edit = true;
                }
            },
            //取消节点编辑
            closeEdit(node, data) {
                data.edit = false;
                if (data.id <= 0) {
                    this.removeTree(node, data);
                }
            },
            //删除节点
            deleteTree(node, data) {
                if (data.id > 0) {
                    message.confirm("确定要删除吗？", {
                        okName: "删除", okFunction: () => {
                            message.loading.show("删除中");
                            http.post("files/del/class",{"id": data.id}).then(res => {
                                this.removeTree(node, data);
                            }).catch(err => {
                            });
                        }
                    });
                }
            },
            //一出节点
            removeTree(node, data) {
                const parent = node.parent;
                const children = parent.data.children || parent.data;
                const index = children.findIndex(d => d.id === data.id);
                children.splice(index, 1);
            },
            //节点被点击时的回调
            nodeClick(data) {
                this.selectFileClassId = data.id;
                message.loading.show();
                this.getImageList();
            },
            //判断节点能否被拖拽
            allowDrag(node) {
                return node.data.id > 0
            },
            //拖拽时判定目标节点能否被放置
            allowDrop(draggingNode, dropNode, type) {
                if (type == "inner") {
                    return true;
                }
            },
            //拖拽成功完成时触发的事件
            nodeDrop(dropNode, toNode, type) {
                //console.log(toNode);
                message.loading.show("修改中");
                http.post("files/edit/class", {
                    "id": dropNode.data.id,
                    "pid": toNode.data.id,
                    "label": dropNode.data.label
                }).then(res => {
                    dropNode.data.pid = toNode.data.id;
                }).catch(err => {
                    this.dropNode.children.splice(this.dropNodeIndex, 0, dropNode.data);
                    let index = toNode.data.children.findIndex(i => i.id == dropNode.data.id);
                    toNode.data.children.splice(index, 1);
                });
            },
            //节点开始拖拽时触发的事件
            nodeDragStart(node) {
                this.dropNode = node.parent.data;
                this.dropNodeIndex = node.parent.data.children.findIndex(item => item.id == node.data.id);
            },
            //分页
            pageChange() {
                message.loading.show();
                this.getImageList();
            },
            //删除图片
            delImg(img){
                message.confirm("确定要删除吗？",{okName:"删除",okFunction:()=>{
                        message.loading.show("删除中");
                        http.post("files/del",{"id":img.id}).then(data=>{
                            let index=this.imgList.findIndex(i=>i.id==img.id);
                            this.imgList.splice(index,1);
                        }).catch(err=>{});
                    }});
            },
            //选择图片
            selectImg(img){
                this.$emit("select",img);
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
            color:$text-primary-color;
            left: calc(50% - 50px);
        }
    }

    .files {
        display: flex;
        padding-top: 10px;
    }

    .click-node {
        color: $primary-color;
    }

    .tree-add {
        display: flex;
        align-items: center;

        & > input {
            border-radius: 5px;
            border: 1px $border-color1 solid;
            box-shadow: 0 0 5px $box-gray1-color;
            font-size: 14px;
            padding: 0 5px;
            width: 120px;
        }

        & > i {
            font-size: 22px;

            &:last-child {
                margin-left: 5px;
                color: $primary-color;

                &:active {
                    color: $primary-color-active;
                }
            }

            &:first-child {
                margin-right: 5px;
                color: $text-gray-color;

                &:active {
                    color: $text-primary-color;
                }
            }
        }
    }

    .files-class {
        width: 240px;
        margin-right: 10px;
        padding: 10px;
        box-shadow: 0 0 5px $box-gray2-color;
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
            color: $primary-color;
        }
    }

    .file-list {
        width: calc(100% - 250px);
        padding: 10px;
        box-shadow: 0 0 5px $box-gray2-color;

        & > div {
            display: flex;
            flex-wrap: wrap;
            position:relative;
            & > div {
                    width: 122px;
                    height: 122px;
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    margin-right: 15px;
                    margin-bottom: 15px;
                    border: 1px $border-color1 solid;
                    background-color: $background-color;
                    overflow: hidden;
                    position:relative;
                & > img {
                    max-width: 120px;
                    max-height: 120px;
                    transition: all 1S ease-out;
                }
                & .img-action{
                    position:absolute;
                    width:100%;
                    text-align:center;
                    padding:3px 0;
                    color:#ffffff;
                    transition:all 0.5s ease-out;
                    cursor:pointer;
                }
                .img-action-see{
                    transform:translateY(-30px);
                    top:0;
                    background-color:rgba(51,153,225,0.5);
                }
                .img-action-del{
                    transform:translateY(30px);
                    bottom:0;
                    background-color:rgba(213,8,8,0.5);
                }
            }
            & > .list-animate-leave-active{
                position: absolute;
            }
            &>div:hover{
                & > img{
                    max-width: 260px;
                    max-height: 260px;
                }
                & .img-action{
                    transform:translateY(0);
                }
            }
        }
    }


</style>
