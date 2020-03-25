<template>
  <div class="users">
     <div style="padding-bottom:10px;" v-if="uiAuth._admin_api_user_list_paginate">
        <el-input style="width:150px;" type="text" size="mini" v-model="search.nickname" placeholder="请输入昵称"/>
         <span class="interval-span"></span>
         <el-input style="width:150px;" type="text" size="mini" v-model="search.mobile" placeholder="请输入手机号"/>
         <span class="interval-span"></span>
         <el-button icon="h-icon-search" type="primary" size="mini" @click="searchUsers">查找会员</el-button>
     </div>
      <div v-if="uiAuth._admin_api_user_list_paginate">
          <el-table v-loading="loading" :data="userList" border size="mini">
              <el-table-column
                      label="头像"
                      width="60">
                  <template slot-scope="scope">
                      <img class="avatar_url" @click="imagePreview(scope.row.avatar_url)" :src="scope.row.avatar_url" />
                  </template>
              </el-table-column>
              <el-table-column label="昵称" prop="nickname" />
              <el-table-column label="手机号" prop="mobile" />
              <el-table-column
                      label="余额（元）">
                  <template slot-scope="scope">
                      {{scope.row.money/100}}
                  </template>
              </el-table-column>
              <el-table-column label="积分" prop="points" />

              <el-table-column label="性别" width="50">
                  <template slot-scope="scope">
                      <div style="font-size:20px;">
                          <span v-show="scope.row.sex===0" style="color:#12BB04">
                          <i class="fa fa-intersex" aria-hidden="true"></i></span>
                          <span v-show="scope.row.sex===1" style="color:#00A1FB">
                          <i class="fa fa-mars" aria-hidden="true"></i></span>
                          <span v-show="scope.row.sex===2" style="color:#FF5BBE">
                          <i class="fa fa-venus" aria-hidden="true"></i></span>
                      </div>
                  </template>
              </el-table-column>
              <el-table-column label="省份" prop="province"></el-table-column>
              <el-table-column label="城市" prop="city"></el-table-column>
              <el-table-column label="最后登录">
                  <template slot-scope="scope">
                      {{ unixToDateTime(scope.row.login_time) }}
                  </template>
              </el-table-column>

              <el-table-column label="操作">
                  <template slot-scope="scope">

                  </template>
              </el-table-column>
          </el-table>

          <Paging v-model="pageData" @change="pageChange"></Paging>

      </div>
  </div>
</template>

<script>
  import http from "../../lib/http";
  import utils from "../../lib/utils";
  import {mapState} from "vuex";
  export default {
    name: 'user',
    data () {
      return {
          showPayLog:false,
          payLogUserId:0,
        loading:true,
        userList:[],
          search:{},
        pageData:{
            page:1,
            page_size:12,
            total_count:0
        }
      }
    },
      computed:{...mapState(["uiAuth"])},
    mounted () {
        this.getUserList();
    },
    methods: {
        unixToDateTime(val=0){
            return utils.UnixToDateTime(val);
        },
        getUserList(){
            http.post(`user/list/${this.pageData.page_size}/${this.pageData.page}`,this.search).then(data=>{
                this.userList=data.data;
                this.pageData=data.paginate;
                this.loading=false;
            }).catch(err=>{
                this.loading=false;
            })
        },
        searchUsers(){
            this.pageData.page=1;
            this.pageData.otal_count=0;
            this.loading=true;
            this.getUserList();
        },
        pageChange() {
            this.loading=true;
            this.getUserList();
        },
        imagePreview(url){
            this.$ImagePreview([url],0);
        }
    }
  }
</script>

<style scoped lang="scss">
  .add-uri{
    padding:10px;
  }
    .avatar_url{
        width:30px;
        height:30px;
        border-radius:5px;
        box-shadow:0 0 5px #727272;
    }

</style>
