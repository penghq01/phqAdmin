<template>
    <div class="role">
        <div style="padding-bottom:10px;">
            <el-button v-if="uiAuth._admin_api_role_add" type="primary" size="mini" @click="opened=true">添加角色</el-button>
        </div>
        <div v-if="uiAuth._admin_api_role_auth_list">
            <el-table v-loading="loading" :data="roleList" border size="mini">
                <el-table-column label="ID" prop="id"></el-table-column>
                <el-table-column label="名称" prop="role_name"></el-table-column>
                <el-table-column label="描述" prop="role_desc"></el-table-column>
                <el-table-column label="操作" align="center" width="120">
                    <template slot-scope="scope">
                        <Poptip
                                v-if="uiAuth._admin_api_role_del"
                                transfer
                                confirm
                                title="确定删除吗?"
                                @on-ok="del(scope.row)">
                            <el-button type="danger" size="mini" icon="el-icon-delete"></el-button>
                        </Poptip>
                        <span class="interval-span"></span>

                        <el-button v-if="uiAuth._admin_api_role_edit" type="primary" size="mini" @click="showEdit(scope.row)" icon="el-icon-edit-outline"></el-button>
                    </template>
                </el-table-column>
            </el-table>
        </div>
        <Dialog
                :title="titleName"
                :is-show="opened"
                :close="close"
                width="70%"
                close-title="取 消"
                :ok-click="isEdit?edit:addRole"
                :ok-title="isEdit?'修改':'添加'"
        >
            <div class="input-div">
                <el-input type="text" v-model="postData.role_name" placeholder="角色名称"/>
            </div>
            <div class="input-div">
                <el-input type="textarea" :rows="2" v-model="postData.role_desc" placeholder="角色描述"/>
            </div>
            <div class="select-auth">
                <div>选择角色数据权限：</div>
                <div>
                    <el-transfer
                            v-model="postData.auth_data"
                            :data="apiList"
                            :titles="['未有数据权限', '已有数据权限']"
                            :button-texts="['删除', '添加']">
                    </el-transfer>
                </div>
            </div>
            <div class="select-auth">
                <div>选择角色导航权限：</div>
                <div>
                    <el-tree ref="treeAuth" :data="authTree" show-checkbox node-key="id" default-expand-all :expand-on-click-node="true" :default-checked-keys="checkedAuth">
           <span class="custom-tree-node" style="padding:3px 5px;" slot-scope="{ node, data }">
               <span v-if="data.icon" :class="data.icon" style="font-size:14px;"></span>
                {{ node.data.title }}
           </span>
                    </el-tree>
                </div>
            </div>
        </Dialog>
    </div>
</template>

<script>
    import http from "../../lib/http";
    import utils from "../../lib/utils";
    import message from "../../lib/message";
    import {mapState,mapActions} from "vuex";
    export default {
        name: 'Role',
        data() {
            return {
                titleName: "添加角色",
                loading: false,
                opened: false,
                isEdit: false,
                roleList: [],
                apiList: [],
                selectApiList:[],
                postData: {},
                authList: [],
                authTree: [],
                checkedAuth: [],
            }
        },
        computed:{...mapState(["uiAuth","userInfo"])},
        mounted() {
            this.getAuthList();
            this.getRoleList();
            this.getApiList();
        },
        methods: {
            ...mapActions(["updateUIAuth","updateRouterList"]),
            listTotree(data, pid = 0) {
                let list = [];
                data.forEach((item, key) => {
                    if (item.pid == pid && item.visit == 2) {
                        let tem = utils.NewObject(item);
                        this.$set(tem, "children", this.listTotree(data, item.id));
                        list.push(tem);
                    }
                });
                return list;
            },
            getApiList() {
                http.post("api/list").then(data => {
                    data.forEach(item=>{
                      this.apiList.push({"key":item.id,"label":item.title,"disabled":false});
                    });
                }).catch(err => {
                });
            },
            getAuthList() {
                http.post("role/auth-list").then(data => {
                    this.authList = data;
                    this.authTree = this.listTotree(data);
                }).catch(err => {
                });
            },
            getRoleList() {
                this.loading = true;
                http.post("role/list").then(data => {
                    this.roleList = data;
                }).catch(err => {
                }).finally(() => {
                    this.loading = false;
                });
            },
            addRole() {
                if (utils.empty(this.postData.role_name)) {
                    message.msg.error("角色名称不能为空");
                    return;
                }
                let HalfCheckedKeys = this.$refs.treeAuth.getHalfCheckedKeys();
                let CheckedKeys = this.$refs.treeAuth.getCheckedKeys();
                this.postData.auth_list = [...HalfCheckedKeys, ...CheckedKeys];
                message.loading.show("添加中");
                http.post("role/add", this.postData).then(data => {
                    this.roleList.unshift(data);
                    this.close();
                }).catch(err => {
                })

            },
            showEdit(row) {
                let list = utils.NewObject(this.authList);
                this.authTree = this.listTotree(list);
                row.auth_list.forEach(item=>{
                    this.authList.forEach(al=>{
                        if(item===al.id && !utils.empty(al.router)){
                            this.checkedAuth.push(item);
                        }
                    });
                });
                this.postData = utils.NewObject(row);
                this.opened = true;
                this.isEdit = true;
                this.titleName = `修改角色【 ${row.role_name} 】`;
            },
            close() {
                this.authTree = this.listTotree(this.authList);
                this.isEdit = false;
                this.opened = false;
                this.postData = {};
                this.checkedAuth = [];
                this.titleName = "添加角色";
            },
            edit() {
                if (utils.empty(this.postData.role_name)) {
                    message.msg.error("角色名称不能为空");
                    return;
                }
                let HalfCheckedKeys = this.$refs.treeAuth.getHalfCheckedKeys();
                let CheckedKeys = this.$refs.treeAuth.getCheckedKeys();
                this.postData.auth_list = [...HalfCheckedKeys, ...CheckedKeys];
                message.loading.show("修改中");
                http.post("role/edit", this.postData).then(data => {
                    this.getUIAuth(this.postData.id);
                    let index = this.roleList.findIndex(i => i.id === this.postData.id);
                    if (index >= 0) {
                        this.$set(this.roleList, index, this.postData);
                    }
                    this.close();
                }).catch(err => {
                })

            },
            del(row) {
                message.loading.show("删除中");
                http.post("role/del", {"id": row.id}).then(data => {
                    this.getUIAuth(row.id);
                    this.roleList.splice(this.roleList.findIndex(i => i.id == row.id), 1);
                }).catch(err => {
                });
            },
            //更新UI权限
            getUIAuth(id=0){
                let update=true;
                this.userInfo.role.forEach(item=>{
                    if(update && item===id){
                        console.log("updateRouterList");
                        this.updateRouterList(this.$router);
                        this.updateUIAuth();
                        update=false;
                    }
                });
            },
        }
    }
</script>
<style>
    .role .el-checkbox {
        margin-right: 10px;
    }

    .role .el-checkbox__label {
        padding-left: 5px;
    }
    .el-transfer-panel{
      width:33%;
    }
    .el-transfer-panel .el-transfer-panel__header{
       height:auto;
       padding:8px 10px;
    }
    .el-transfer-panel__body,.el-transfer-panel__list{
      height:300px;
    }

</style>
<style scoped lang="scss">
    .select-auth {
        margin-bottom:10px;
        border-radius: 5px;
        border: 1px $border-color2 solid;
        & > div {
            padding: 5px;

            &:first-child {
                background-color: $text-gray2-color;
                color: $text-gray-color;
            }
        }
    }
</style>
