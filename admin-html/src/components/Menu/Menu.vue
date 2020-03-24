<template>
        <el-row class="tac">
            <el-menu
                    :default-active="activeMenu"
                    unique-opened
                   @select="selectMenu">
                    <span v-for="(item,index) in list" :key="index">
                        <MenuItem v-if="item.children==undefined" :list="item"></MenuItem>
                        <SubMenu v-else :list="item"></SubMenu>
                    </span>
            </el-menu>
        </el-row>
</template>

<script>
    import SubMenu from "./SubMenu"
    import MenuItem from "./MenuItem"
    export default {
        name: "Menu",
        props:{
            list:{
                type:Array,
                default:[]
            },
            activeMenu:{
                type:String,
                default:"/index"
            }
        },
        data() {
            return {}
        },
        mounted() {
        },
        methods: {
            selectMenu(index, indexPath){
                //console.log(index, indexPath);
                this.$emit("select",index);
            }
        },
        components:{SubMenu,MenuItem}
    }
</script>

<style scoped lang="scss">

</style>
