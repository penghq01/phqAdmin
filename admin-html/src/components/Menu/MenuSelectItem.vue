<template>
    <el-submenu :class="`el-menu-children${children}`" v-if="isChildren" :index="params.key">
        <template slot="title">
            <i :class="params.icon" class="phq-menu-icon"></i>
            <span slot="title">
                <span  class="phq-menu-txt">
                     {{params.title}}
                </span>
            </span>
        </template>
        <MenuSelectItem v-for="(item,index) in params.children" :key="index" :params="item" :children="children+1"/>
    </el-submenu>

    <el-menu-item  v-else :index="params.key">
       <i :class="params.icon" class="phq-menu-icon"></i>
        <span slot="title">
            <span>
                 {{params.title}}
            </span>
        </span>
    </el-menu-item>
</template>

<script>
    import utils from "../../lib/utils";
    export default {
        name: "MenuSelectItem",
        props: {
            params: {
                type: Object,
                default: {}
            },
            children:{
                type: Number,
                default:0,
            }
        },
        computed:{
            isChildren(){
               return !utils.empty(this.params.children);
            }
        }
    }
</script>

