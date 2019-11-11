<template>
    <el-select v-model="selectValue" :placeholder="placeholder" :disabled="disabled" @change="selectChange" clearable @clear="clear">
        <TreeSelectOption :tree-data="treeData" :label-key="labelKey" :val-key="valKey" :num="0"/>
    </el-select>
</template>

<script>
    import TreeSelectOption from "./TreeSelectOption";
    export default {
        name: "TreeSelect",
        components:{TreeSelectOption},
        props:{
            value:{
                default:""
            },
            treeData:{
                type:Array,
                default:[]
            },
            disabled:{
                type:Boolean,
                default:false
            },
            placeholder:{
                type:String,
                default:"请选择"
            },
            labelKey:{
                type:String,
                default:""
            },
            valKey:{
                type:String,
                default:""
            }
        },
        data(){
            return{
                selectValue:""
            }
        },
        mounted(){
           this.selectValue=this.value;
        },
        methods:{
            selectChange(val){
               this.$emit("input",val);
               this.$emit("change",val);
            },
            clear(){
                this.$emit("clear","");
                this.$emit("change","");
            }
        }
    }
</script>

<style scoped>

</style>