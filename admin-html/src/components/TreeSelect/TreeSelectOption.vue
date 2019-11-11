<template>
    <div :style="{'margin-left':`${num>0?20:0}px`}" :class="num>0?'children-left':''">
        <div v-for="(item,index) in treeData" :key="index">
            <div>
                <el-option :label="item[labelKey]" :value="item[valKey]">
                   <span style="position:relative;">
                       <span class="hengx"></span>
                       {{item[labelKey]}}
                   </span>
                </el-option>
            </div>
            <div v-if="item.children.length>0">
                <TreeSelectOption :tree-data="item.children" :label-key="labelKey" :val-key="valKey" :num="num+10"/>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        name: "TreeSelectOption",
        props: {
            treeData: {
                type: Array,
                default: []
            },
            labelKey: {
                type: String,
                default: ""
            },
            valKey: {
                type: String,
                default: ""
            },
            num: {
                label: {
                    type: Number,
                    default: 0
                }
            }
        }
    }
</script>

<style scoped lang="scss">
    .hengx {
        display: block;
        width:20px;
        height: 1px;
        background-color: $gray1-color;
        position:absolute;
        left:-20px;
        bottom:calc(50% - 1px);
    }
    .children-bottom {
        border-bottom: 1px $gray1-color solid;
    }
    .children-left {
        border-left: 1px $gray1-color solid;
    }
    .children-top {
        border-top: 1px $gray1-color solid;
    }
</style>