<template>
    <div class="login">
       <div class="qrcode">
           <Qrcode v-show="showQrCode" :text="clientId" :q-size="300"/>
           <div v-show="!showQrCode" class="loading"><i class="el-icon-loading"></i></div>
       </div>
        <div class="desc">请使用手机APP扫码登录</div>
    </div>
</template>
<script>
    import Qrcode from "../components/Qrcode";
    import md5 from "js-md5";
    import utils from "../lib/utils";
    import http from "../lib/http";
    import message from "../lib/message";
    import storage from "../lib/storage";
    export default {
        name: 'login',
        components:{Qrcode},
        data() {
            return {
                clientId:"",
                showQrCode:false,
            }
        },
        mounted(){
          this.clientId="wildfirechat://pcsession/"+storage.clientId.get();
          this.$Log.log("clientId=",this.clientId);
          this.getCode();
        },
        methods: {
         getCode(){
             this.showQrCode=false;
             http.post("/login_qrcode",{
                 params:{"cid":this.clientId}
             }).then(data=>{
                 this.$Log.log("data=",data);
                 this.showQrCode=true;
             });
         },
        }
    }
</script>
<style scoped lang="scss">
 .login{
     & .qrcode{
         display:inline-block;
         width:300px;
         height:300px;
         margin-left:calc(50% - 150px);
         margin-top:calc(50% - 150px);
         box-shadow:0 0 5px $box-gray1-color;
     }
     & .desc{
         padding-top:15px;
         text-align:center;
     }
     & .loading{
         width:100%;
         height:100%;
         display:flex;
         justify-content:center;
         align-items:center;
         &>i{
             font-size:30px;
             color:$primary-color;
         }
     }
 }
</style>
