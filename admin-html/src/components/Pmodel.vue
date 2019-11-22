<template>
    <div class="p-modal" v-if="value" :style="{'z-index':maxZindex}">
        <div ref="pModalBody" class="p-modal-body" v-show="value" :style="{'width':width,'margin-left':marginRight}">
        <div class="p-modal-body-title">
            {{title}}
            <div class="p-modal-body-title-close" @click="closeModel"><i class="fa fa-times" ></i></div>
        </div>
        <div class="p-modal-body-content">
            <slot></slot>
        </div>
    </div>
    </div>
</template>
<script>
    import utils from "../lib/utils";

    export default {
        name: "Pmodel",
        props:{
            value:{
                type:Boolean,
                default:false
            },
            title:{
                type:String,
                default:""
            },
            width:{
                type:String,
                default:"70%"
            }
        },
        data(){
            return{
                marginRight:"0",
                maxZindex:0,
            }
        },
        mounted(){
            let width = document.documentElement.clientWidth || document.body.clientWidth;
            let widthNum=this.width.length;
            let unit=this.width.substr(widthNum-1,widthNum);
            let marginLeft=((width*0.7)/2).toFixed(2)+"px";
            if(unit == "%"){
                let bfj=parseFloat(this.width.substr(0,widthNum-1))/100;
                let bodyWidth=width*bfj;
                marginLeft=((width-bodyWidth)/2).toFixed(0)+"px";
            }
            if(unit=="x"){
                marginLeft=width-parseFloat(this.width.substr(0,widthNum-2))+"px";
            }
          this.marginRight=marginLeft;
        },
        methods:{
            closeModel(){
                this.$emit("input",false);
            }
        },
        watch:{
            //动态计算，z-index的数值
            value(){
                let allEle=[...document.all];
                let MaxZIndex=0;
                allEle.forEach(item=>{
                  let zIndex=item.style.zIndex;
                  if(!utils.empty(zIndex)){
                      if(parseInt(zIndex)>MaxZIndex){
                          MaxZIndex=parseInt(zIndex);
                          //console.log("元素",item);
                      }
                  }
                });

                this.maxZindex=MaxZIndex<100?100:MaxZIndex+1;
               // console.log("MaxZIndex",MaxZIndex+1);
            }
        }
    }
</script>

<style scoped>

</style>
