<template>
    <div id="win-title">
        <TitleBnt type="min" />
        <TitleBnt type="max" />
        <TitleBnt type="close" />
    </div>
</template>

<script>
    import TitleBnt from "./TitleBnt";
    export default {
        name: "WinTitle",
        components:{TitleBnt},
        data() {
            return {}
        },
        mounted() {

        },
        methods: {}
    }
</script>

<style scoped lang="scss">
    #win-title {
        position: absolute;
        width: 100%;
        height: 40px;
        background-color:$primary-color;
        -webkit-app-region: drag;
    }
</style>
