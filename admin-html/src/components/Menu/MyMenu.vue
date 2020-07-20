<template>
    <el-menu
            :default-active="activeMenu"
            unique-opened
            :collapse="isCollapse"
            @select="selectMenu">
        <MenuSelectItem v-for="(item,index) in list" :key="index" :params="item" :children="0" :is-collapse="isCollapse"/>
    </el-menu>
</template>

<script>
    import MenuSelectItem from "./MenuSelectItem";
    export default {
        name: "MyMenu",
        components: {MenuSelectItem},
        props: {
            list: {
                type: Array,
                default: []
            },
            activeMenu: {
                type: String,
                default: "/index"
            },
            isCollapse: {
                type: Boolean,
                default: false
            }
        },
        methods: {
            selectMenu(index, indexPath) {
                //console.log(index, indexPath);
                this.$emit("select", index);
            }
        }
    }
</script>
