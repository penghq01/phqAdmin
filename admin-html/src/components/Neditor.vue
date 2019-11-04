<template>
    <vue-neditor-wrap v-model="content" :config="myConfig" :destroy="false" @ready="ready"></vue-neditor-wrap>
</template>

<script>
    import VueNeditorWrap from 'vue-neditor-wrap'
    import utils from "../lib/utils";
    export default {
        name: "Neditor",
        components:{VueNeditorWrap},
        props:{
          value:{
              type:String,
              default:""
          },
          height:{
              type:Number,
              default:320
          },
          readonly:{
              type:Boolean,
              default:false
          },
        },
        mounted(){
          this.myConfig.initialFrameHeight=this.height;
          this.myConfig.readonly=this.readonly;
        },
        data () {
            return {
                content:"",
                myConfig: {
                    // 如果需要上传功能,找后端小伙伴要服务器接口地址
                    //serverUrl: '/api/web/upload/ueditor',
                    // 你的UEditor资源存放的路径,相对于打包后的index.html
                    UEDITOR_HOME_URL: '/NEditor/',
                    // 编辑器不自动被内容撑高
                    autoHeightEnabled: false,
                    // 初始容器高度
                    initialFrameHeight: 320,
                    // 初始容器宽度
                    initialFrameWidth: '100%',
                    //是否开启只读
                    readonly:false,
                    // 关闭自动保存
                    enableAutoSave: false,
                    toolbars: [
                        [
                            "fullscreen",
                            "source",
                            "|",
                            "undo",
                            "redo",
                            "|",
                            "bold",
                            "italic",
                            "underline",
                            "fontborder",
                            "strikethrough",
                            "superscript",
                            "subscript",
                            "removeformat",
                            "formatmatch",
                            "autotypeset",
                            "blockquote",
                            "pasteplain",
                            "|",
                            "forecolor",
                            "backcolor",
                            "insertorderedlist",
                            "insertunorderedlist",
                            "selectall",
                            "cleardoc",
                            "|",
                            "rowspacingtop",
                            "rowspacingbottom",
                            "lineheight",
                            "|",
                            "customstyle",
                            "paragraph",
                            "fontfamily",
                            "fontsize",
                            "|",
                            "directionalityltr",
                            "directionalityrtl",
                            "indent",
                            "|",
                            "justifyleft",
                            "justifycenter",
                            "justifyright",
                            "justifyjustify",
                            "|",
                            "touppercase",
                            "tolowercase",
                            "|",
                            "link",
                            "unlink",
                            "anchor",
                            "|",
                            "imagenone",
                            "imageleft",
                            "imageright",
                            "imagecenter",
                            "|",
                            // "simpleupload",
                            "insertimage",
                            "map",
                            "insertframe",
                            // "webapp",
                            "pagebreak",
                            "template",
                            "background",
                            "|",
                            "horizontal",
                            "date",
                            "time",
                            "spechars",
                            "|",
                            "inserttable",
                            "deletetable",
                            "insertparagraphbeforetable",
                            "insertrow",
                            "deleterow",
                            "insertcol",
                            "deletecol",
                            "mergecells",
                            "mergeright",
                            "mergedown",
                            "splittocells",
                            "splittorows",
                            "splittocols",
                            "charts",
                            "|",
                            "searchreplace",
                            "help"
                        ]
                    ],
                }
            }
        },
        methods:{
            ready(Neditor){
                this.init();
            },
            init(){
                if(utils.empty(this.value)){
                    this.content="";
                }else{
                    this.content=this.value;
                }
                //console.log("内容=",this.content);
            },
        },
        watch:{
            value(){
              this.init();
            },
           content(val){
              if(!utils.empty(val)){
                  this.$emit("input",val);
              }
           }
        }
    }
</script>

<style scoped>
.neditor-html{
    margin-top:10px;
    border:1px #DCDCDC solid;
    border-radius:5px;
    padding:10px;
}
</style>