<template>
    <div class="sql">
        <div class="action" style="padding-bottom: 10px;">
            <Poptip
                    v-if="uiAuth._admin_api_sql_exprot"
                    transfer
                    confirm
                    title="确定要备份数据吗?"
                    @on-ok="exprotSql">
                <el-button type="primary" size="mini">备份数据</el-button>
            </Poptip>
        </div>
        <div class="table" v-if="uiAuth._admin_api_sql_list">
            <el-table  v-loading="loading" :data="dataList" border size="mini">
                <el-table-column label="文件名" prop="file_name"></el-table-column>
                <el-table-column label="大小" width="100">
                    <template slot-scope="scope">
                        {{getSize(scope.row.file_size)}}
                    </template>
                </el-table-column>
                <el-table-column label="操作" align="center" width="160">
                    <template slot-scope="scope">
                        <Poptip
                                v-if="uiAuth._admin_api_sql_del"
                                transfer
                                confirm
                                title="确定删除吗?"
                                @on-ok="del(scope.row)">
                            <el-button type="danger" size="mini" icon="el-icon-delete"></el-button>
                        </Poptip>
                        <span class="interval-span"></span>
                        <Poptip
                                v-if="uiAuth._admin_api_sql_improt"
                                transfer
                                confirm
                                title="确定要恢复备份吗?"
                                @on-ok="improtSql(scope.row)">
                            <el-button type="primary" size="mini">恢复备份</el-button>
                        </Poptip>
                    </template>
                </el-table-column>
            </el-table>
        </div>
    </div>
</template>

<script>
    import http from "../../lib/http";
    import message from "../../lib/message";
    import {mapState} from "vuex";
    export default {
        name: "System",
        data(){
            return{
                loading:false,
                dataList:[]
            }
        },
        computed:{...mapState(["uiAuth"])},
        mounted(){
            this.getSqlList();
        },
        methods:{
           getSqlList(){
               http.post("sql/list").then(data=>{
                   this.dataList=data;
               }).catch(err=>{});
           },
            getSize(val=0){
               let kb=parseFloat(val)/1024;
               let mb=kb/1024;
               if(kb<1024.000){
                    return kb.toFixed(3)+" KB";
               }else{
                   return mb.toFixed(3)+" MB"
               }
            },
            del(row={"file_name":""}){
                http.post("sql/del",{"file_name":row.file_name}).then(data=>{
                   let index=this.dataList.findIndex(item=>item.key==row.key);
                    if(index>=0){
                        this.dataList.splice(index,1)
                    }
                }).catch(err=>{});
            },
            exprotSql(){
               message.loading.show("数据备份中，请耐心等待……");
                http.post("sql/exprot").then(data=>{
                    this.dataList.unshift(data);
                }).catch(err=>{}).finally(()=>message.loading.hide());
            },
            improtSql(row={"file_name":""}){
                message.loading.show("数据恢复中，请耐心等待……");
                http.post("sql/improt",{"file_name":row.file_name}).then(data=>{}).catch(err=>{}).finally(()=>message.loading.hide());
            },
        }
    }
</script>

<style scoped>

</style>
