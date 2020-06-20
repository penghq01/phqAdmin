<template>
    <div class="Region">

    </div>
</template>

<script>
    import {mapState} from "vuex";

    export default {
        name: "Region",
        computed: {...mapState(["uiAuth", "bodyHeight"])},
        data() {
            return {}
        },
        mounted() {
        },
        methods: {}
    }
</script>
<style scoped lang="scss">

</style>