<template>
  <div id="app">
    <router-view></router-view>
  </div>
</template>
<style scoped lang="scss">

</style>
<script>
  import {mapActions} from "vuex";
  export default {
    name: 'App',
    methods:{...mapActions(["updateBodyHeight"])},
    mounted(){
      let that=this;
      console.log();
      let minHeight=240;
      let func=(()=> {
        let height = document.body.offsetHeight;
        let res = height - 110;
        if (res < minHeight) {
          res = minHeight;
        }
        that.updateBodyHeight(res);
      });
      func();
      window.onresize = () => {
        return func();
      }
    }
  }
</script>
