<template>
    <el-dialog
            :title="title"
            :visible.sync="isShow"
            :width="width"
            :before-close="close"
            :close-on-click-modal="false"
    :close-on-press-escape="false">
            <span>
              <slot></slot>
            </span>
        <span slot="footer" class="dialog-footer">
            <el-button v-if="!one" @click="close">{{closeTitle}}</el-button>
           <el-button type="primary" @click="okClick">{{okTitle}}</el-button>
        </span>
    </el-dialog>
</template>

<script>
    export default {
        name: "myDialog",
        props: {
            one:{
                type:Boolean,
                default:false,
            },
            close: {
                type: Function,
                default: () => {
                }
            },
            okClick: {
                type: Function,
                default: () => {
                }
            },
            isShow: {
                type: Boolean,
                default: false
            },
            okTitle:{
                type:String,
                default:"确定"
            },
            closeTitle:{
                type:String,
                default:"取消"
            },
            title:{
                type:String,
                default:"提示"
            },
            width:{
                type:String,
                default:"30%"
            }
        },
        data() {
            return {}
        },
        mounted() {
        },
        methods: {},
    }
</script>

<style scoped lang="scss">

</style>