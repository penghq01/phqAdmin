<template>
    <div class="region">
       <RegionTree :body-height="bodyHeight"></RegionTree>
    </div>
</template>

<script>
    import {mapState} from "vuex";
    import RegionTree from "../../components/region/RegionTree";
    // loadData
    export default {
        name: "Region",
        components: {RegionTree},
        computed: {...mapState(["bodyHeight"])}
    }
</script>
<style scoped lang="scss">
</style>