<template>
    <el-popover
            placement="top"
            width="160"
            v-model="visible">
        <p>{{title}}</p>
        <div style="text-align: right; margin: 0">
            <el-button size="mini" type="text" @click="close">取消</el-button>
            <el-button type="primary" size="mini" @click="ok">确定</el-button>
        </div>
        <slot slot="reference"></slot>
    </el-popover>
</template>

<script>
    export default {
        name: "Poptip",
        props:{
            title:{
                type:String,
                default:"确定删除吗?"
            },
            onOk:{
                type:Function,
                default:()=>{}
            }
        },
        data() {
            return {
                visible:false,
            }
        },
        mounted() {
          this.visible=this.value;
        },
        methods: {
            close(){
                this.visible=false;
                this.$emit("input",false);
            },
            ok(){
                this.$emit("on-ok");
            }
        }
    }
</script>

<style scoped lang="">

</style>
