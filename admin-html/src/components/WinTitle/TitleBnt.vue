<template>
    <div class="title-btn" :class="style" v-on:click="click"/>
</template>

<script>
import {ipcRenderer} from "electron"
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
            click: function () {
                ipcRenderer.send(this.type);
            }
        }
    }
</script>

<style scoped lang="scss">
    .min{
        color:$warning-color;
        right:100px;
    }
    .max {
        color:$success-color;
        right:60px;
    }
    .close {
        color:$danger-color;
        right:20px;
    }
    .title-btn {
        position: absolute;
        width: 20px;
        height: 20px;
        top: 0;
        bottom: 0;
        font-size:24px;
        margin: auto 0;
        display:flex;
        background-color:#fff;
        border-radius:50%;
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
