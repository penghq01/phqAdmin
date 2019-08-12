<template>
    <div class="pagination">
        <el-pagination
                background
                layout="sizes,prev,pager,next,jumper"
                :total="value.total_count"
                :page-size="value.page_size"
                :current-page="value.page"
                :page-sizes="pageSizeArray"
                @current-change="pageChange"
                @size-change="sizeChang"
        >
        </el-pagination>
    </div>
</template>

<script>
    export default {
        name: "pagination",
        props:{
            value:{
                type:Object,
                default:{}
            }
        },
        data(){
            return{
                pageSizeArray:[10,12,14,16,18,20,25,30,35,40,45,50],
            }
        },
        methods:{
            pageChange(currentPage){
                this.value.page = currentPage;
                this.$emit("input",this.value);
                this.$emit("change");
            },
            sizeChang(sizechang){
                this.value.page_size = sizechang;
                this.$emit("input",this.value);
                this.$emit("change");
            }
        }
    }
</script>

<style scoped>

</style>