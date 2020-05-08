<template>
    <el-dialog
            :title="title"
            :visible.sync="showBox"
            :width="width"
            @closed="close"
            :show-close="showClose"
			 :append-to-body="true"
            :close-on-click-modal="false"
    :close-on-press-escape="false">
            <div>
              <slot></slot>
            </div>
        <span slot="footer" class="dialog-footer">
           <el-button v-if="!one" @click="showBox=false">{{closeTitle}}</el-button>
           <el-button v-if="!isSee" type="primary" @click="okClick">{{okTitle}}</el-button>
        </span>
    </el-dialog>
</template>

<script>
    export default {
        name: "myDialog",
        props: {
            showClose:{
                type:Boolean,
                default:true,
            },
            one:{
                type:Boolean,
                default:false,
            },
            close: {
                type: Function,
                default: () => {
                }
            },
            isSee:{
                type:Boolean,
                default:false,
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
            return {
                showBox:false,
            }
        },
        mounted() {
            this.showBox=this.isShow;
        },
        watch:{
            isShow(val){
                this.showBox=val;
            }
        }
    }
</script>

<style scoped lang="scss">

</style>
