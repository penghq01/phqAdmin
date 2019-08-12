<template>
    <el-menu-item :index="list.key">
        <i :class="list.icon" class="phq-icon"></i>
        <span slot="title">{{list.title}}</span>
    </el-menu-item>
</template>

<script>
    export default {
        name: "MenuItem",
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
    }
</script>

<style scoped lang="scss">

</style>