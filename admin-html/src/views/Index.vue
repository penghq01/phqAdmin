<template>
  <div>
    index
  </div>
</template>

<script>
  import utils from "../lib/utils";

  export default {
    name: 'Index',
    data () {
      return {}
    },
    mounted(){
      let ad=utils.GetDateTimeUnix();
      console.log(ad);
      console.log(utils.UnixToDateTime(ad));
    },
    methods: {}
  }
</script>

<style scoped lang="scss">

</style>
