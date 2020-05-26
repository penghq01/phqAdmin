<template>
    <div>
        <el-button type="primary" size="mini" @click="showImage=true" v-if="!readonly">{{btnTitle}}</el-button>
        <a @click="clear" v-if="!readonly"> 清空图片</a>
        <Pmodel v-model="showImage" v-if="!readonly">
            <UploadImg :is-select="true" @select="selectImage"></UploadImg>
        </Pmodel>
        <div class="select-img-div" v-if="multiple">
            <div v-for="(src,index) in ImagesSrc" :key="index" @click="previewImg=src">
                <span v-if="!readonly" class="select-img-close" @click="delPostImg(index)">×</span>
                <img :src="imgHost+src" />
            </div>
        </div>
        <div class="select-img-div" v-else>
            <div @click="previewImg=ImagesSrc" v-show="ImagesSrc!=''">
                <span v-if="!readonly" class="select-img-close" @click="delImg()">×</span>
                <img :src="imgHost+ImagesSrc" />
            </div>
        </div>
        <PreviewImg v-model="previewImg"/>
    </div>
</template>

<script>
    import config from "../config"
    import utils from "../lib/utils";
    import PreviewImg from "./PreviewImg";
    import Pmodel from "./Pmodel";
    import UploadImg from "./UploadImg";
    export default {
        name: "SelectImages",
        components:{UploadImg,Pmodel,PreviewImg},
        props:{
            value:{},
            btnTitle:{
                type:String,
                default:"选择图片"
            },
            //是否多选
            multiple:{
                type:Boolean,
                default:false
            },
            //是否只读
            readonly:{
                type:Boolean,
                default:false
            },
        },
        data(){
            return{
                previewImg:"",
                imgHost:"",
                showImage:false,
                ImagesSrc:[],
            }
        },
        mounted(){
            this.imgHost=config.imgHost;
            if(utils.empty(this.value)){
                this.multiple?this.ImagesSrc=[]:this.ImagesSrc="";
            }else{
                this.ImagesSrc=this.value;
            }
        },
        methods:{
            selectImage(img){
                if(this.multiple){
                    this.ImagesSrc.push(img.src);
                    this.$emit("input", this.ImagesSrc);
                }else{
                    this.ImagesSrc=img.src;
                }
                this.$emit("input",this.ImagesSrc);
                this.showImage=false;
            },
            delPostImg(index){
                this.ImagesSrc.splice(index,1);
                this.$emit("input", this.ImagesSrc);
            },
            delImg(){
                this.ImagesSrc="";
                this.$emit("input",this.ImagesSrc);
            },
            clear(){
                this.multiple?this.ImagesSrc=[]:this.ImagesSrc="";
                this.$emit("input",this.ImagesSrc);
            }
        },
        watch:{
            value(val){
                if(utils.empty(val)){
                    this.multiple?this.ImagesSrc=[]:this.ImagesSrc="";
                }else{
                    this.ImagesSrc=val;
                }
            }
        }
    }
</script>

<style scoped lang="scss">
    .select-img-div{
        padding:10px 0;
        display:flex;
        flex-wrap: wrap;
        &>div{
            display:flex;
            justify-content: center;
            align-items:center;
            background-color:$text-gray1-color;
            height:100px;
            width:100px;
            margin-right:10px;
            margin-bottom:10px;
            position:relative;
            &>.select-img-close{
                margin:0;
                padding:0;
                background-color:red;
                color:#FFFFFF;
                position:absolute;
                top:-10px;
                right:-5px;
                width:25px;
                height:25px;
                font-size:25px;
                border-radius:50%;
                display:flex;
                justify-content: center;
                align-items:center;
                transition:all 0.5s ease-out;
                &:hover{
                    transform: rotate(180deg);
                    cursor: pointer;
                }
            }
            &>img{
                max-height:100%;
                max-width:100%;
            }
        }
    }
</style>