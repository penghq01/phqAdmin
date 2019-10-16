<template>
    <div>
        <div v-if="menuAuth.select">
            <el-table  v-loading="loading" :data="payLogList" border size="mini" empty-text="暂无数据">
                <el-table-column
                        label="头像"
                        width="60">
                    <template slot-scope="scope">
                        <img class="avatar_url" @click="imagePreview(scope.row.avatar_url)" :src="scope.row.avatar_url" />
                    </template>
                </el-table-column>
                <el-table-column label="昵称" prop="nickname" />
                <el-table-column label="手机号" prop="mobile" />
                <el-table-column label="单号" prop="pay_sn" />
                <el-table-column label="充值金额（元）">
                    <template slot-scope="scope">
                        {{scope.row.price/100}}
                    </template>
                </el-table-column>
                <el-table-column label="充值时间">
                    <template slot-scope="scope">
                        {{ unixToDateTime(scope.row.add_time) }}
                    </template>
                </el-table-column>

            </el-table>
            <Paging v-model="pageData" @change="pageChange"></Paging>
        </div>
    </div>
</template>

<script>
    import http from "../lib/http";
    import Paging from "./Paging"
    import utils from "../lib/utils";
    import logic from "../lib/logic";
    export default {
        name: 'UsersPayLog',
        props:{
          userId:{
              type:Number,
              default:0
          }
        },
        data () {
            return {
                menuAuth:{},
                payLogList:[],
                loading:true,
                pageData:{
                    page:1,
                    page_size:14,
                    total_count:0
                }
            }
        },
        mounted () {
            this.menuAuth=logic.getMenuAuth(this);
            this.getPayLog();
        },
        methods: {
            unixToDateTime(val=0){
                return utils.UnixToDateTime(val);
            },
            getPayLog(){
                http.post(`/user/pay/log/${this.pageData.page_size}/${this.pageData.page}`,{"user_id":this.userId}).then(data=>{
                    this.pageData=data.paginate;
                    this.payLogList=data.data;
                    this.loading=false;
                }).catch(err=>{ this.loading=false;})
            },
            pageChange() {
                this.loading=true;
                this.getPayLog();
            },
            imagePreview(url){

            }
        },
        components:{
            Paging
        }
    }
</script>

<style scoped lang="scss">
    .avatar_url{
        width:30px;
        height:30px;
        border-radius:5px;
        box-shadow:0 0 5px #727272;
    }
</style>
