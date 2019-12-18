<template>
    <div id="win-title" v-if="platform.isPC">
        <TitleBnt type="min" />
        <TitleBnt type="max" />
        <TitleBnt type="close" />
    </div>
</template>

<script>
    import TitleBnt from "./TitleBnt";
    import config from "../../config";
    export default {
        name: "WinTitle",
        components:{TitleBnt},
        data() {
            return {
                platform:{isWeb:false,isPC:false},
            }
        },
        mounted() {
            this.platform=config.platform;
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
