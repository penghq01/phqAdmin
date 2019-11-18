<template>
    <div class="previewImg" v-if="value!=''">
        <div class="previewImg-close"  @click="close">×</div>
        <img :src="value|getImageSrc" />
    </div>
</template>

<script>
    import config from "../config"
    import utils from "../lib/utils";
    export default {
        name: "PreviewImg",
        props:{
            value:{
                type:String,
                default:""
            }
        },
        methods:{
            close(){
                this.$emit("input","");
            }
        }
    }
</script>

<style scoped lang="scss">
    .previewImg{
        transition:all 0.5s ease-out;
        display:flex;
        justify-content:center;
        align-items: center;
        width:100%;
        height:100%;
        position:absolute;
        z-index:999;
        top:0;
        left:0;
        background-color:rgba(0,0,0,0.4);
    &>img{
         max-width:80%;
         max-height:80%;
        box-shadow:0 0 10px $dark-color;
     }
        & .previewImg-close{
            position:absolute;
            width:40px;
            height:40px;
            display:flex;
            justify-content:center;
            align-items: center;
            border-radius:50%;
            border:4px #FFFFFF solid;
            color:#FFFFFF;
            font-size:25px;
            font-weight: bold;
            top:10%;
            right:10%;
            cursor:pointer;
            transition:all 0.5s ease-out;
            &:hover{
                transform:rotate(180deg) scale(1.2);
            }
        }
    }
</style>
