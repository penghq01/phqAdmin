<template>
    <Dialog
            title="选择行政区域"
            :is-show="value"
            :close="close"
            width="80%"
            close-title="取 消"
            :ok-click="confirm"
            ok-title="确定">
        <RegionTree select :body-height="bodyHeight" @change="selectChange" @db-change="dbChange"></RegionTree>
    </Dialog>
</template>

<script>
    import RegionTree from "./RegionTree";
    import message from "../../lib/message";

    export default {
        name: "SelectPGoods",
        components: {RegionTree},
        props: {
            value: {
                type: Boolean,
                default: false
            },
            bodyHeight: {
                type: Number,
                default: 0,
            },
            width:{
                type: String,
                default: "60",
            },
            autoClose:{
                type: Boolean,
                default: true
            }
        },
        data() {
            return {
                selectVal:null,
            }
        },
        methods: {
            close() {
                this.$emit("input", false);
            },
            selectChange(val){
                this.selectVal=val;
            },
            dbChange(val){
                this.selectVal=val;
                this.confirm();
            },
            confirm() {
                if(this.selectVal===null){
                    message.msg.error("没有选择任何内容");
                    return false;
                }
                this.$emit("change", this.selectVal);
                if(this.autoClose){
                    this.$emit("input",false);
                }
            },
        }
    }
</script>
