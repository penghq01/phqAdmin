<template>
  <div id="app">
    <WinTitle />
    <router-view></router-view>
  </div>
</template>
<style scoped lang="scss">

</style>
<script>
  import WinTitle from "./components/WinTitle/WinTitle";
  export default {
    components: {WinTitle}
  }
</script>
