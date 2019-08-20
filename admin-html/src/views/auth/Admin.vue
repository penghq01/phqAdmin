<template>
  <div class="admin">
    <div class="action">
      <el-button type="primary" size="mini" @click="opened=true">添加管理员</el-button>
    </div>
    <div class="table">
      <el-table  v-loading="loading" :data="adminList" border size="mini">
        <el-table-column label="ID" prop="admin_id"></el-table-column>
        <el-table-column label="账号" prop="username"></el-table-column>
        <el-table-column label="上次登录时间" prop="login_time"></el-table-column>
        <el-table-column label="上次登录IP" prop="login_ip"></el-table-column>
        <el-table-column label="操作" align="center" width="120">
          <template slot-scope="scope">
            <Poptip
                    transfer
                    confirm
                    title="确定删除吗?"
                    @on-ok="del(scope.row)">
              <el-button type="danger" size="mini" icon="el-icon-delete"></el-button>
            </Poptip>
            <span class="interval-span"></span>

            <el-button type="primary" size="mini" @click="showEdit(scope.row)" icon="el-icon-edit-outline"></el-button>
          </template>
        </el-table-column>
      </el-table>
    </div>
    <myDialog
            :title="titleName"
            :is-show="opened"
            :close="close"
            close-title="取 消"
            :ok-click="isEdit?edit:confirm"
            :ok-title="isEdit?'修改':'添加'"
    >
      <div class="input-div"><el-input type="text" v-model="addAdmin.username" placeholder="管理员账号"/></div>
      <div class="input-div"><el-input type="password" v-model="addAdmin.password" placeholder="管理员密码"/></div>
    </myDialog>
  </div>
</template>

<script>
  import http from "../../lib/http";
  import utils from "../../lib/utils";
  import md5 from "js-md5"
  import message from "../../lib/message";
  export default {
    name: 'admin',
    data () {
      return {
        titleName:"添加管理员",
        opened:false,
        loading:true,
        isEdit:false,
        adminList:[],
        addAdmin:{}
      }
    },
    mounted () {
      this.GetAdminList();
    },
    methods: {
      GetAdminList(){
         http.post("admin/list").then(data=>{
           this.adminList=data;
           this.adminList.forEach(item=>{
             item.login_time=utils.UnixToDateTime(item.login_time);
           });
           this.loading=false;
         }).catch(err=>{})
      },
      close(){
        this.opened=false;
        this.addAdmin={};
        this.titleName="添加管理员";
        this.isEdit=false;
      },
      confirm(){
        if(utils.empty(this.addAdmin.username) || utils.empty(this.addAdmin.password)){
          message.msg.error("管理员账号或密码不能为空");
          return
        }
        message.loading.show("添加中");
        let password=this.addAdmin.password;
        this.addAdmin.password=md5(password);
         http.post("admin/add",this.addAdmin).then((data)=>{
            this.close();
           data.login_time=utils.UnixToDateTime(data.login_time);
           this.adminList.unshift(data);
         }).catch((err)=>{
           this.addAdmin.password=password;
         })
      },
      del(rows){
        message.loading.show("删除中");
        http.post("admin/del",{"admin_id":rows.admin_id}).then(()=>{
          this.adminList.splice( this.adminList.indexOf(rows), 1);
        }).catch(()=>{})
      },
      showEdit(rows){
        this.titleName="修改管理员";
        this.$set(this.addAdmin,"username",rows.username);
        this.$set(this.addAdmin,"admin_id",rows.admin_id);
        this.opened=true;
        this.isEdit=true;
      },
      edit(){
        if(utils.empty(this.addAdmin.username)){
          message.msg.error("管理员账号不能为空");
          return
        }
        let postData={"username":this.addAdmin.username,"admin_id":this.addAdmin.admin_id};
        if(!utils.empty(this.addAdmin.password)){
          postData.password=md5(this.addAdmin.password);
        }
       message.loading.show("修改中");
        http.post("admin/edit",postData).then(()=>{
          this.close();
          this.loading=true;
          this.GetAdminList();
        }).catch((err)=>{})
      }
    }
  }
</script>

<style scoped lang="scss">
 .admin{
   padding:10px;
 }
  .table{
    padding-top:10px;
  }
</style>
