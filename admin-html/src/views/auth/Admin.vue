<template>
    <div class="admin">
        <div class="action">
            <el-button v-if="menuAuth.add" type="primary" size="mini" @click="opened=true">添加管理员</el-button>
        </div>
        <div class="table" v-if="menuAuth.select">
            <el-table v-loading="loading" :data="adminList" border size="mini">
                <el-table-column label="ID" prop="admin_id"></el-table-column>
                <el-table-column label="账号" prop="username"></el-table-column>
                <el-table-column label="权限角色">
                    <template slot-scope="scope">
                        <el-tag v-for="(item,key) in scope.row.role" :key="key" type="warning" size="mini"
                                style="margin-left:5px;">{{getRoleName(item)}}
                        </el-tag>
                    </template>
                </el-table-column>
                <el-table-column label="上次登录时间" prop="login_time"></el-table-column>
                <el-table-column label="上次登录IP" prop="login_ip"></el-table-column>
                <el-table-column label="操作" align="center" width="120">
                    <template slot-scope="scope">
                        <Poptip
                                v-if="menuAuth.delete"
                                title="确定删除吗?"
                                @on-ok="del(scope.row)">
                            <el-button type="danger" size="mini" icon="el-icon-delete"></el-button>
                        </Poptip>

                        <span class="interval-span"></span>
                        <el-button v-if="menuAuth.edit" type="primary" size="mini" @click="showEdit(scope.row)"
                                   icon="el-icon-edit-outline"></el-button>
                    </template>
                </el-table-column>
            </el-table>
        </div>
        <Dialog
                :title="titleName"
                :is-show="opened"
                :close="close"
                close-title="取 消"
                :ok-click="isEdit?edit:confirm"
                :ok-title="isEdit?'修改':'添加'"
        >
            <div class="input-div">
                <el-input type="text" v-model="addAdmin.username" placeholder="管理员账号"/>
            </div>
            <div class="input-div">
                <el-input type="password" v-model="addAdmin.password" placeholder="管理员密码"/>
            </div>
            <el-select v-model="addAdmin.role" multiple placeholder="角色权限">
                <el-option v-for="item in roleList" :value="item.id"  :label="item.role_name" :key="item.id"></el-option>
            </el-select>
        </Dialog>
    </div>
</template>

<script>
    import http from "../../lib/http";
    import utils from "../../lib/utils";
    import md5 from "js-md5"
    import message from "../../lib/message";
    import logic from "../../lib/logic";

    export default {
        name: 'admin',
        data() {
            return {
                titleName: "添加管理员",
                opened: false,
                loading: true,
                isEdit: false,
                adminList: [],
                roleList: [],
                addAdmin: {"role": []},
                menuAuth: {}
            }
        },
        mounted() {
            this.menuAuth = logic.getMenuAuth(this);
            this.getRoleList();
            this.GetAdminList();
        },
        methods: {
            GetAdminList() {
                http.post("admin/list").then(data => {
                    this.adminList = data;
                    this.adminList.forEach(item => {
                        item.login_time = utils.UnixToDateTime(item.login_time);
                        item.role = item.role.split(",");
                    });
                    this.loading = false;
                }).catch(err => {
                    this.loading = false;
                })
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
            close() {
                this.opened = false;
                this.addAdmin = {"role": []};
                this.titleName = "添加管理员";
                this.isEdit = false;
            },
            confirm() {
                if (utils.empty(this.addAdmin.username) || utils.empty(this.addAdmin.password)) {
                    message.msg.error("管理员账号或密码不能为空");
                    return
                }
                message.loading.show("添加中");
                let data = utils.NewObject(this.addAdmin);
                data.password = md5(data.password);
                data.role = data.role.join(",");
                http.post("admin/add", data).then((data) => {
                    this.close();
                    data.login_time = utils.UnixToDateTime(data.login_time);
                    data.role = data.role.split(",");
                    this.adminList.unshift(data);
                }).catch((err) => {
                })
            },
            del(rows) {
                message.loading.show("删除中");
                http.post("admin/del", {"admin_id": rows.admin_id}).then(() => {
                    this.adminList.splice(this.adminList.indexOf(rows), 1);
                }).catch(() => {
                })
            },
            showEdit(rows) {
                this.titleName = "修改管理员";
                this.$set(this.addAdmin, "username", rows.username);
                this.$set(this.addAdmin, "admin_id", rows.admin_id);
                let role = [];
                rows.role.forEach(item => role.push(parseInt(item)));
                this.$set(this.addAdmin, "role", role);
                this.opened = true;
                this.isEdit = true;
            },
            edit() {
                if (utils.empty(this.addAdmin.username)) {
                    message.msg.error("管理员账号不能为空");
                    return
                }
                let postData = {
                    "username": this.addAdmin.username,
                    "admin_id": this.addAdmin.admin_id,
                    "role": this.addAdmin.role.join(",")
                };
                if (!utils.empty(this.addAdmin.password)) {
                    postData.password = md5(this.addAdmin.password);
                }
                message.loading.show("修改中");
                http.post("admin/edit", postData).then(() => {
                    this.close();
                    this.loading = true;
                    this.GetAdminList();
                }).catch((err) => {
                })
            },
            getRoleName(id) {
                let name = "";
                this.roleList.forEach(item => {
                    if (id == item.id) {
                        name = item.role_name;
                    }
                });
                return name;
            }
        }
    }
</script>

<style scoped lang="scss">
    .table {
        padding-top: 10px;
    }
</style>
