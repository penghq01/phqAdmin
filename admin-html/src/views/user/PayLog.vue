<template>
  <div>
    <UsersPayLog></UsersPayLog>
  </div>
</template>

<script>
  import UsersPayLog from "../../components/UsersPayLog"
  export default {
    name: 'pay_log',
    components:{
      UsersPayLog
    }
  }
</script>

<style scoped lang="scss">
  .avatar_url{
    width:30px;
    height:30px;
    border-radius:5px;
    box-shadow:0 0 5px #727272;
  }
</style>
