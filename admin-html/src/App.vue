<template>
  <div id="app">
    <router-view></router-view>
  </div>
</template>

<script>
  import {mapActions} from "vuex";
  export default {
    name: 'App',
    methods:{...mapActions(["updateBodyHeight"])},
    mounted(){
      let that=this;
      let minHeight=240;
      let func=function(){
        let winHeight =document.body.clientHeight || document.documentElement.clientHeight;
        let height = winHeight - 110;
        if (height < minHeight) {
          height = minHeight;
        }
        that.updateBodyHeight(height);
      };
      func();
      window.onresize = func;
    }
  }
</script>
