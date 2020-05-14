<template>
    <el-submenu v-if="params.children" :index="params.key">
        <template slot="title">
            <i :class="params.icon" class="phq-menu-icon"></i>
            <span slot="title">
                <span  class="phq-menu-txt">
                     {{params.title}}
                </span>
            </span>
        </template>
        <MenuSelectItem v-for="(item,index) in params.children" :key="index" :params="item"/>
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
    export default {
        name: "MenuSelectItem",
        props: {
            params: {
                type: Object,
                default: {}
            }
        }
    }
</script>

