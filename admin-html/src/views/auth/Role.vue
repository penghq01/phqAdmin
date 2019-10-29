<template>
  <div class="role">
     <div style="padding-bottom:10px;">
       <el-button v-if="menuAuth.add" type="primary" size="mini" @click="opened=true">添加角色</el-button>
     </div>
    <div v-if="menuAuth.select">
      <el-table  v-loading="loading" :data="roleList" border size="mini">
        <el-table-column label="ID" prop="id"></el-table-column>
        <el-table-column label="名称" prop="role_name"></el-table-column>
        <el-table-column label="描述" prop="role_desc"></el-table-column>
        <el-table-column label="操作" align="center" width="120">
          <template slot-scope="scope">
            <Poptip
                    v-if="menuAuth.delete"
                    transfer
                    confirm
                    title="确定删除吗?"
                    @on-ok="del(scope.row)">
              <el-button type="danger" size="mini" icon="el-icon-delete"></el-button>
            </Poptip>
            <span class="interval-span"></span>

            <el-button v-if="menuAuth.edit" type="primary" size="mini" @click="showEdit(scope.row)" icon="el-icon-edit-outline"></el-button>
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
        <el-tree ref="treeAuth" :data="authTree" show-checkbox node-key="id" default-expand-all :expand-on-click-node="true"  @check-change="checkChange" :default-checked-keys="checkedAuth">
           <span class="custom-tree-node" style="padding:3px 5px;" slot-scope="{ node, data }">
               <span v-if="data.icon" :class="data.icon" style="font-size:14px;"></span>
                {{ node.data.title }}

              <span v-if="data.visit==2 && data.auth!=''" style="padding-left:5px">
                 <el-checkbox v-model="data.auth.select.action" @change="checkBoxChange($event,data,node)" v-if="data.auth.select.show">查询</el-checkbox>
                 <el-checkbox v-model="data.auth.add.action" @change="checkBoxChange($event,data,node)" v-if="data.auth.add.show" >添加</el-checkbox>
                 <el-checkbox v-model="data.auth.edit.action" @change="checkBoxChange($event,data,node)" v-if="data.auth.edit.show" >修改</el-checkbox>
                 <el-checkbox v-model="data.auth.delete.action" @change="checkBoxChange($event,data,node)" v-if="data.auth.delete.show" >删除</el-checkbox>
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
  import message from "../../lib/message";
  import logic from "../../lib/logic";

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
        authList:[],
        authTree:[],
        checkedAuth:[],
          menuAuth:{}
      }
    },
    mounted () {
        this.menuAuth=logic.getMenuAuth(this);
      this.getAuthList();
      this.getRoleList();
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
              if(utils.empty(tem.auth.add.action)){
                  this.$set(tem.auth.add,"action",false);
              }
              if(utils.empty(tem.auth.delete.action)){
                  this.$set(tem.auth.delete,"action",false);
              }
                if(utils.empty(tem.auth.edit.action)){
              this.$set(tem.auth.edit,"action",false);
                }
                if(utils.empty(tem.auth.select.action)) {
                    this.$set(tem.auth.select, "action", false);
                }
            }
            list.push(tem);
          }
        });
        return list;
      },
      getAuthList() {
        http.post("role/auth-list").then(data => {
           this.authList=data;
           this.authTree=this.listTotree(data);
        }).catch(err => {
        });
      },
      getRoleList(){
          this.loading=true;
          http.post("role/list").then(data=>{
              this.roleList=data;
          }).catch(err=>{}).finally(()=>{
              this.loading=false;
          });
        },
      getCheckAuth(){
        let arr=this.$refs.treeAuth.getHalfCheckedNodes();
        let checkArr=this.$refs.treeAuth.getCheckedNodes();
        checkArr.forEach(item=>{
            arr.push(item)
        });
        let res=[];
        arr.forEach(item=>{
           let a={"auth_id":item.id,"select":false,"add":false,"edit":false,"delete":false};
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
          if(utils.empty(this.postData.role_name)){
              message.msg.error("角色名称不能为空");
              return;
          }
          message.loading.show("添加中");
          this.postData.auth_list=JSON.stringify(this.getCheckAuth());
          http.post("role/add",this.postData).then(data=>{
              this.roleList.unshift(data);
              this.close();
          }).catch(err=>{})

      },
      //查找是否存在分类被选择
      findTreeAuthChildrenDelId(authTree){
          authTree.forEach(item=>{
             if(!utils.empty(item.children) && item.children.length>0){
                 let index=this.checkedAuth.findIndex(id=>id==item.id);
                 if(index>=0){
                     this.checkedAuth.splice(index,1);
                 }
                 this.findTreeAuthChildrenDelId(item.children);
             }
          });
       },
      showEdit(row){
          let list=utils.NewObject(this.authList);
          let rl=JSON.parse(row.auth_list);
          rl.forEach(item=>{
              let index=list.findIndex(i=>i.id==item.auth_id);
              if(index>=0){
                  this.checkedAuth.push(item.auth_id);
                  let auth=JSON.parse(list[index].auth);
                  if(item.select){
                      auth.select.action=item.select;
                  }
                  if(item.add){
                      auth.add.action=item.add;
                  }
                  if(item.edit){
                      auth.edit.action=item.edit;
                  }
                  if(item.delete){
                      auth.delete.action=item.delete;
                  }
                  list[index].auth=JSON.stringify(auth);
              }
          });
          this.authTree=this.listTotree(list,0);
          this.findTreeAuthChildrenDelId(this.authTree);
          this.postData=utils.NewObject(row);
          this.opened=true;
          this.isEdit=true;
          this.titleName=`修改角色【 ${row.role_name} 】`;
      },
      close(){
        this.authTree=this.listTotree(this.authList,0);
        this.isEdit=false;
        this.opened=false;
        this.postData={};
        this.checkedAuth=[];
        this.titleName="添加角色";
      },
      edit(){
          if(utils.empty(this.postData.role_name)){
              message.msg.error("角色名称不能为空");
              return;
          }
          message.loading.show("修改中");
          this.postData.auth_list=JSON.stringify(this.getCheckAuth());
          http.post("role/edit",this.postData).then(data=>{
              let index=this.roleList.findIndex(i=>i.id==this.postData.id);
              if(index>=0){
                  this.$set(this.roleList,index,this.postData);
              }
              this.close();
          }).catch(err=>{})

      },
      del(row){
          message.loading.show("删除中");
          http.post("role/del",{"id":row.id}).then(data=>{
              this.roleList.splice(this.roleList.findIndex(i=>i.id==row.id),1);
          }).catch(err=>{});
      },
      checkChange(data,check,children){
          if(check){
              data.auth.select.action=true;
          }else{
              if(data.auth!=""){
                  for (let key in data.auth){
                      this.$set(data.auth[key],"action",false);
                  }
              }
          }
      },
      checkBoxChange(isCheck,data,node){
          if(isCheck){
              if(!data.auth.select.action){
                  data.auth.select.action=true;
              }
              if(!node.checked){
                  node.checked=true;
              }
          }
          let nodeChecked=false;
          for (let key in node.data.auth) {
              if(node.data.auth[key].show){
                  if(data.auth[key].action){
                      nodeChecked=true;
                  }
              }
          }
         if(!nodeChecked){
             node.checked=false;
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
