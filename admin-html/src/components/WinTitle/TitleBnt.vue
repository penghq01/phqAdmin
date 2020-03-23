<template>
    <div class="title-btn" :class="style" @click="clickBtn"/>
</template>

<script>
import config from "../../config";
import message from "../../lib/message";
let ipcRenderer={send:()=>{}};
if(config.platform.isPC){
     ipcRenderer=require("electron").ipcRenderer;
}
const icon={
    min:"el-icon-remove",
    max:"el-icon-circle-plus",
    close:"el-icon-error"
};
    export default {
        name: "TitleBtn",
        props: ['type'],
        computed: {
            style: function () {
                return this.type+" "+icon[this.type];
            }
        },
        methods: {
           async clickBtn () {
                if (this.type === "close") {
                    await message.confirm("确定要关闭该系统吗?", {
                        okName: "关闭系统",
                        okFunction:()=>{
                            ipcRenderer.send(this.type);
                        }
                    });
                } else {
                    ipcRenderer.send(this.type);
                }
            }
        }
    }
</script>

<style scoped lang="scss">
    .min{
        color:$warning-color;
    }
    .max {
        color:$success-color;
    }
    .close {
        color:$danger-color;
    }
    .title-btn {
        width: 20px;
        height: 20px;
        top: 0;
        bottom: 0;
        font-size:24px;
        display:flex;
        background-color:#fff;
        border-radius:50%;
        margin:auto 5px;
        justify-content:center;
        align-items:center;
        -webkit-app-region: no-drag;
        transition:all 0.5s;
        cursor:pointer;
        box-shadow:0 0 5px #20456A;
        &:hover{
            transform:scale(1.2);
        }
    }
</style>
