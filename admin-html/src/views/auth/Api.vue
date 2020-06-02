<template>
    <div class="api">
        <div style="padding-bottom: 10px;">
            <el-button v-if="uiAuth._admin_api_api_add" type="primary" size="mini" @click="showAdd">添加</el-button>
        </div>
        <div v-if="uiAuth._admin_api_api_list_paginate">
            <el-table v-loading="loading" :data="dataList" border size="mini">
                <el-table-column label="标题" prop="title" width="200"></el-table-column>
                <el-table-column label="名称" prop="name" width="260"></el-table-column>
                <el-table-column label="签名" width="50">
                    <template slot-scope="scope">
                        <el-tag effect="dark" v-if="scope.row.sign==0" type="info" size="mini">否</el-tag>
                        <el-tag effect="dark" v-if="scope.row.sign==1" size="mini">是</el-tag>
                    </template>
                </el-table-column>
                <el-table-column label="访问" width="100">
                    <template slot-scope="scope">
                        <el-tag effect="dark" v-if="scope.row.visit==0" type="info" size="mini">公开</el-tag>
                        <el-tag effect="dark" v-if="scope.row.visit==1" type="success" size="mini">登录</el-tag>
                        <el-tag effect="dark" v-if="scope.row.visit==2" type="warning" size="mini">权限</el-tag>
                        <el-tag effect="dark" v-if="scope.row.visit==3" type="danger" size="mini">系统管理员</el-tag>
                    </template>
                </el-table-column>
                <el-table-column label="显示" width="60">
                    <template slot-scope="scope">
                        <el-tag effect="dark" v-if="scope.row.is_show==0" type="info" size="mini">隐藏</el-tag>
                        <el-tag effect="dark" v-if="scope.row.is_show==1" size="mini">显示</el-tag>
                    </template>
                </el-table-column>
                <el-table-column label="接口" prop="router" width="300"></el-table-column>
                <el-table-column label="结构体" prop="struct" width="200"></el-table-column>
                <el-table-column label="方法" prop="mapping_methods" width="160"></el-table-column>
                <el-table-column fixed="right" label="操作" width="120">
                    <template slot-scope="scope">
                        <el-button v-if="uiAuth._admin_api_api_edit" type="warning" @click="showEdit(scope.row)" icon="el-icon-edit-outline"
                                   size="mini"></el-button>
                        <span class="interval-span"></span>
                        <Poptip
                                v-if="uiAuth._admin_api_api_del"
                                transfer
                                confirm
                                title="确定删除吗?"
                                @on-ok="del(scope.row)">
                            <el-button type="danger" size="mini" icon="el-icon-delete"></el-button>
                        </Poptip>
                    </template>
                </el-table-column>
            </el-table>
            <Paging v-model="paginate" @change="getDataList"></Paging>
        </div>
        <Dialog
                :title="`${isEdit?'修改':'添加'}数据接口`"
                :is-show="opened"
                :close="close"
                width="45%"
                close-title="取 消"
                :ok-click="isEdit?edit:add"
                :ok-title="isEdit?'修改':'添加'"
        >
            <div class="input-div">
                <span class="title-name">标题：</span>
                <el-input style="width:220px;" type="text" v-model="params.title" placeholder="请输入"/>
            </div>
            <div class="input-div">
                <span  class="title-name">接口：</span>
                <el-input style="width:220px;" type="text" v-model="params.router" placeholder="请输入"/>
            </div>
            <div class="input-div">
                <span  class="title-name">名称：</span>
                <el-input style="width:220px;" type="text" @focus="routerFocus" v-model="params.name" placeholder="请输入"/>
            </div>
            <div class="input-div">
                <span  class="title-name">是否签名：</span>
                <el-radio v-model="params.sign" :label="0">否</el-radio>
                <el-radio v-model="params.sign" :label="1">是</el-radio>
            </div>
            <div class="input-div">
                <span  class="title-name">访问类型：</span>
                <el-radio v-model="params.visit" :label="0">公开</el-radio>
                <el-radio v-model="params.visit" :label="1">登录</el-radio>
                <el-radio v-model="params.visit" :label="2">权限</el-radio>
                <el-radio v-model="params.visit" :label="3">系统管理员</el-radio>
            </div>
            <div class="input-div">
                <span  class="title-name">是否显示：</span>
                <el-radio v-model="params.is_show" :label="0">隐藏</el-radio>
                <el-radio v-model="params.is_show" :label="1">显示</el-radio>
            </div>
            <div class="input-div">
                 <span  class="title-name">结构体：</span>
                <el-input style="width:220px;" type="text" v-model="params.struct" placeholder="请输入"/>
            </div>
            <div class="input-div">
                 <span  class="title-name">方法：</span>
                <el-input style="width:220px;" type="text" v-model="params.mapping_methods" placeholder="请输入"/>
            </div>
            <div class="input-div">
                   <el-button-group>
                    <el-button type="info" size="mini" @click="setMappingMethods('Get')">post:Get</el-button>
                    <el-button type="success" size="mini" @click="setMappingMethods('PageList')">post:PageList
                    </el-button>
                    <el-button type="success" size="mini" @click="setMappingMethods('List')">post:List</el-button>
                    <el-button type="warning" size="mini" @click="setMappingMethods('Edit')">post:Edit</el-button>
                    <el-button type="danger" size="mini" @click="setMappingMethods('Del')">post:Del</el-button>
                    <el-button type="primary" size="mini" @click="setMappingMethods('Add')">post:Add</el-button>
                </el-button-group>
            </div>
        </Dialog>
    </div>
</template>

<script>
    import http from "../../lib/http";
    import utils from "../../lib/utils";
    import {mapState} from "vuex";
    export default {
        name: "Api",
        data() {
            return {
                paginate:{
                    page:1,
                    page_size:14,
                    total_count:0
                },
                loading: false,
                isEdit: false,
                opened: false,

                dataList: [],
                params: {}
            }
        },
        computed:{...mapState(["uiAuth"])},
        mounted() {
            this.getDataList();
        },
        methods: {
            getDataList() {
                this.loading = true;
                http.post(`api/list/${this.paginate.page_size}/${this.paginate.page}`).then(data => {
                    this.paginate = data.paginate;
                    this.dataList = data.data;
                    this.loading = false;
                }).catch(err => this.loading = false)
            },
            showAdd(){
                this.params= {
                    "title":"",
                    "sign":1,
                    "visit":0,
                    "is_show":1,
                    "name":"admin_api_",
                    "router":"/admin/api/",
                    "struct":"",
                    "mapping_methods":"post:"
                };
                this.opened= true;
            },
            showEdit(row) {
                this.isEdit=true;
                this.params= {
                    "id":row.id,
                    "title":row.title,
                    "name":row.name,
                    "sign":row.sign,
                    "visit":row.visit,
                    "is_show":row.is_show,
                    "router":row.router,
                    "struct":row.struct,
                    "mapping_methods":row.mapping_methods,
                };
                this.opened= true;
            },
            close() {
                this.loading = false;
               this.isEdit=false;
               this.opened= false;
               this.params= {};
            },
            add() {
                this.loading = true;
                http.post("api/add",this.params).then(data => {
                    this.dataList.unshift(data);
                    //this.close();
                    this.loading = false;
                }).catch(err => this.loading = false)
            },
            edit() {
                this.loading = true;
                http.post("api/edit",this.params).then(data => {
                    let index=this.dataList.findIndex(item=>item.id===data.id);
                    index>=0 && this.dataList.splice(index,1,data);
                    this.close();
                }).catch(err => this.loading = false)
            },
            del(row) {
                this.loading = true;
                http.post("api/del",{"id":row.id}).then(data => {
                    let index=this.dataList.findIndex(item=>item.id===row.id);
                    index>=0 && this.dataList.splice(index,1);
                    this.loading = false
                }).catch(err => this.loading = false)
            },
            routerFocus(){
                if(!utils.empty(this.params.router)){
                    let r=this.params.router;
                    r=r.replace(/\/:page_size\/:page/g,"_paginate");
                    r=r.replace(/\//g,"_");
                    this.params.name=r;
                }
            },
            setMappingMethods(val) {
                this.params.mapping_methods = `post:${val}`;
                let structArr=this.params.struct.split(".");
                let titleArr=this.params.title.split("—");
                let struct="";
                if(structArr.length>1){
                    struct=structArr[structArr.length-1].toLowerCase();
                }
                if(titleArr.length>1){
                    titleArr.splice(1,1);
                }
                // "name": "admin_api_",
                // "router": "/admin/api/",
                // stock.Unit
                console.log(struct,this.params.struct);
                switch (val) {
                    case "Add":
                        this.params.router=`/admin/api/${struct}/add`;
                        titleArr.push("添加");
                        break;
                    case "Del":
                        this.params.router=`/admin/api/${struct}/del`;
                        titleArr.push("删除");
                        break;
                    case "Edit":
                        this.params.router=`/admin/api/${struct}/edit`;
                        titleArr.push("修改");
                        break;
                    case "List":
                        this.params.router=`/admin/api/${struct}/list`;
                        titleArr.push("查询列表");
                        break;
                    case "PageList":
                        this.params.router=`/admin/api/${struct}/list/:page_size/:page`;
                        titleArr.push("查询列表（分页）");
                        break;
                    case "Get":
                        this.params.router=`/admin/api/${struct}/get`;
                        titleArr.push("查询");
                        break;
                }
                this.params.title=titleArr.join("—");
                this.routerFocus();
            }
        }
    }
</script>

<style scoped lang="">

</style>
