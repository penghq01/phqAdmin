<template>
        <el-submenu :index="list.key">
            <template slot="title">
                <i :class="list.icon" class="phq-icon"></i>
                <span slot="title">{{list.title}}</span>
            </template>
            <span v-for="(item,index) in list.children" :key="index">
                        <PMenuItem v-if="item.children===undefined" :list="item">
                        </PMenuItem>
                        <PSubMenu v-else :list="item"></PSubMenu>
            </span>
        </el-submenu>
</template>

<script>
    import PSubMenu from "./SubMenu"
    import PMenuItem from "./MenuItem"
    export default {
        name: "submenu",
        props:{
            list:{
                type:Object,
                default:{}
            }
        },
        data() {
            return {}
        },
        mounted() {
        },
        methods: {},
        components:{PSubMenu,PMenuItem}
    }
</script>

<style scoped lang="scss">

</style>