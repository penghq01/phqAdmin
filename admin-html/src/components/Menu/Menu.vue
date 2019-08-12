<template>
        <el-row class="tac">
            <el-menu
                    :default-active="activeMenu"

                    unique-opened
                   @select="selectMenu">
                    <span v-for="(item,index) in list" :key="index">
                         <PMenuItem v-if="item.children===undefined" :list="item">
                        </PMenuItem>
                        <PSubMenu v-else :list="item"></PSubMenu>
                    </span>
            </el-menu>
        </el-row>
</template>

<script>
    import PSubMenu from "./SubMenu"
    import PMenuItem from "./MenuItem"
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
        components:{PSubMenu,PMenuItem}
    }
</script>

<style scoped lang="scss">

</style>