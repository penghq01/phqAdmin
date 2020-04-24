<template>
  <div>
    <div class="index-list">
      <div>
        <el-card class="box-card">
          <div slot="header" class="clearfix">
            <span>系统信息</span>
          </div>
          <div>
            <div class="input-div">当前版本：v{{version}}</div>
            <div class="input-div">开发：penghq</div>
          </div>
        </el-card>
      </div>
    </div>
  </div>
</template>

<script>

  import config from "../config";

  export default {
    name: 'Index',
    data () {
      return {
        version:"1.0.0"
      }
    },
    mounted(){
      this.version=config.version;
    },
    methods: {}
  }
</script>

<style scoped lang="scss">

</style>
