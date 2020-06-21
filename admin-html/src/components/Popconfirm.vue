<template>
    <el-popconfirm :title="title" @onConfirm="confirm">
        <el-button  slot="reference" :type="type" :icon="icon">{{name}}</el-button>
    </el-popconfirm>
</template>

<script>
    export default {
        name: "Popconfirm",
        props:{
            name:{
                type:String,
                default(){
                    return "删除"
                }
            },
            title:{
                type:String,
                default(){
                    return "确定要删除吗？删除后不可恢复！"
                }
            },
            type:{
                type:String,
                default(){
                    return "danger"
                }
            },
            icon:{
                type:String,
                default(){
                    return "el-icon-delete"
                }
            }
        },
        methods:{
            confirm(){
                this.$emit("ok");
            }
        }
    }
</script>