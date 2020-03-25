<template>
    <div class="pagination">
        <el-pagination
                background
                layout="total, sizes, prev, pager, next, jumper"
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
                pageSizeArray:[10,11,12,13,14,15,16,17,18,19,20,22,24,26,28,30,35,40,45,50,55,60,65,70,75,80,90,100,120,150,200,300],
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
