<template>
  <div id="app">
    <WinTitle />
    <router-view></router-view>
  </div>
</template>

<script>
  import {mapActions} from "vuex";
  import WinTitle from "./components/WinTitle/WinTitle";
  export default {
    name: 'App',
    components: {WinTitle},
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
      this.$nextTick(()=>{
        let splash = document.getElementById('splash');
        splash.style.display = 'none';
      });
    }
  }
</script>
