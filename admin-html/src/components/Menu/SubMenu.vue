<template>
        <el-submenu :index="list.key">
            <template slot="title">
                <i :class="list.icon" class="phq-icon"></i>
                <span slot="title">{{list.title}}</span>
            </template>
            <span v-for="(item,index) in list.children" :key="index">
                        <MenuItem v-if="item.children==undefined" :list="item"></MenuItem>
                        <SubMenu v-else :list="item"></SubMenu>
            </span>
        </el-submenu>
</template>

<script>
    import SubMenu from "./SubMenu"
    import MenuItem from "./MenuItem"
    export default {
        name: "SubMenu",
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
        components:{SubMenu,MenuItem}
    }
</script>

<style scoped lang="scss">

</style>
