<template>
  <div class="role">
     <div style="padding-bottom:10px;">
       <el-button type="primary" size="mini" @click="opened=true">添加角色</el-button>
     </div>
    <div>
      <el-table  v-loading="loading" :data="roleList" border size="mini">
        <el-table-column label="ID" prop="id"></el-table-column>
        <el-table-column label="名称" prop="role_name"></el-table-column>
        <el-table-column label="权限" prop="auth_list"></el-table-column>
        <el-table-column label="描述" prop="role_desc"></el-table-column>
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
            width="50%"
             close-title="取 消"
            :ok-click="isEdit?edit:addRole"
            :ok-title="isEdit?'修改':'添加'"
    >
      <div class="input-div"><el-input type="text" v-model="postData.role_name" placeholder="角色名称"/></div>
      <div class="input-div"><el-input type="textarea" :rows="2" v-model="postData.role_desc" placeholder="角色描述"/></div>
      <div class="select-auth">
        <div>选择角色权限：</div>
        <el-tree ref="treeAuth" :data="authTree" show-checkbox node-key="id" default-expand-all :expand-on-click-node="true"  @check-change="checkChange">
           <span class="custom-tree-node" style="padding:3px 5px;" slot-scope="{ node, data }">
               <span v-if="data.icon" :class="data.icon" style="font-size:14px;"></span>
                {{ node.data.title }}

              <span v-if="data.visit==2 && data.auth!=''" style="padding-left:5px">
                 <el-checkbox v-model="data.auth.select.action" v-if="data.auth.select.show">查询</el-checkbox>
                 <el-checkbox v-model="data.auth.add.action" v-if="data.auth.add.show" >添加</el-checkbox>
                 <el-checkbox v-model="data.auth.edit.action" v-if="data.auth.edit.show" >修改</el-checkbox>
                 <el-checkbox v-model="data.auth.delete.action" v-if="data.auth.delete.show" >删除</el-checkbox>
              </span>

           </span>
        </el-tree>
      </div>
    </myDialog>
  </div>
</template>

<script>
  import http from "../../lib/http";
  import utils from "../../lib/utils";

  export default {
    name: 'Role',
    data () {
      return {
        titleName:"添加角色",
        loading:false,
        opened:false,
        isEdit:false,
        roleList:[],
        postData:{},
        authTree:[]
      }
    },
    mounted () {
      this.getAuthList();
    },
    methods: {
      listTotree(data,pid=0){
        let list=[];
        data.forEach((item,key)=>{
          if(item.pid==pid && item.visit==2){
            let tem=utils.NewObject(item);
            this.$set(tem,"children",this.listTotree(data,item.id));
            if(!utils.empty(tem.auth)){
              tem.auth=JSON.parse(tem.auth);
            }
            list.push(tem);
          }
        });
        return list;
      },
      getAuthList() {
        http.post("auth/list").then(data => {
          this.authTree=this.listTotree(data);
        }).catch(err => {
        });
      },
      getCheckAuth(){
        let arr=this.$refs.treeAuth.getCheckedNodes();
        let res=[];
        arr.forEach(item=>{
           let a={"title":item.title,"auth_id":item.id,"select":false,"add":false,"edit":false,"delete":false};
           if(item.auth!=""){
             for(let key in item.auth){
               a[key]=item.auth[key].action;
             }
           }
           res.push(a);
        });
        return res;
      },
      addRole(){
        console.log(this.getCheckAuth());
      },
      showEdit(row){
      },
      close(){
        this.isEdit=false;
        this.opened=false;
        this.postData={};
        this.titleName="添加角色";
      },
      edit(){
        console.log(this.getCheckAuth());
      },
      del(){},
      checkChange(data,check,children){
         if(data.auth!=""){
           for (let key in data.auth){
             this.$set(data.auth[key],"action",check);
           }
         }
      }
    }
  }
</script>
<style>
  .el-checkbox{
    margin-right:10px;
  }
  .el-checkbox__label{
    padding-left:5px;
  }
</style>
<style scoped lang="scss">
.select-auth{
  padding:5px;
  border-radius:5px;
  border:1px $gray2-color solid;
  & > div:first-child{
     padding:5px 0;
    color:$gray-color;
  }
}
</style>
