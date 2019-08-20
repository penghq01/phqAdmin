<template>
    <div class="upload-img">
        <div>
            <el-upload
                    class="upload-demo"
                    action="#"
                    :show-file-list="false"
                    :before-upload="beforeAvatarUpload"
                    :http-request="httpRequest">
                <div class="upload-btn" @click="selectUploadImageProgress=0">
                    <el-progress :text-inside="true" :stroke-width="24" :percentage="selectUploadImageProgress"></el-progress>
                    <div class="upload-btn-title">上传图片</div>
                </div>
            </el-upload>
        </div>
        <div class="img-list">
             <div class="img-div" v-for="(img,index) in imgList" :key="index">
                 <img :src="imgHost+img" />
             </div>
        </div>
    </div>
</template>

<script>
    import message from "../lib/message";
    import http from "../lib/http";

    export default {
        name: "UploadImg",
        data(){
            return{
                imgHost:"http://localhost:8181/",
                selectUploadImageProgress:0,
                imgList:[]
            }
        },
        mounted(){
        },
       methods:{
           beforeAvatarUpload(file){
               const isJPG = file.type === 'image/jpeg';
               const isLt2M = file.size / 1024 / 1024 < 30;
               if (!isJPG) {
                   message.msg.error('只能上传图片!');
               }
               if (!isLt2M) {
                   message.msg.error('上传图片大小不能超过 30MB!');
               }
               return isJPG && isLt2M;
           },
           httpRequest(file){
               //console.log("自定义",file);
               let param = new FormData();
               param.append('upload_img',file.file);
               http.post("/upload/img",param,true,true,progress=>{
                   //console.log("上传中",progress);
                  this.selectUploadImageProgress=parseInt((progress.loaded/progress.total)*100);
               }).then(data=>{
                  this.imgList.unshift(data);
               }).catch(err=>{
                   this.selectUploadImageProgress=0;
                   //console.log("上传失败",err);
               });
           }
        },
    }
</script>

<style scoped lang="scss">
    .upload-demo{
        width:100%;
    }
    .upload-btn{
        width:100%;
        color:#FFFFFF;
        position:relative;
        &-jd{
          height:40px;
        }
        &-title{
          position:absolute;
          top:2px;
            color:$dark-color;
         left:calc(50% - 50px);
        }
    }
    .img-list{
            display:flex;
            flex-wrap: wrap;
            padding-top:15px;
            & >div{
                width:122px;
                height:122px;
                display:flex;
                justify-content: center;
                align-items: center;
                margin-right:15px;
                margin-bottom:15px;
                border:1px $gray2-color solid;
                background-color:$gray2-color;
                &>img{
                    max-width:120px;
                    max-height:120px;
                }
            }
    }
</style>