<template>
    <transition name="fade">
    <div class="p-modal" v-if="value">
        <transition name="fade2">
        <div class="p-modal-body" v-show="value">
            <div class="p-modal-body-title">
                {{title}}
                <div class="p-modal-body-title-close" @click="closeModel"><i class="fa fa-times" ></i></div>
            </div>
            <div class="p-modal-body-content">
                <slot></slot>
            </div>
        </div>
        </transition>
    </div>
    </transition>
</template>

<script>
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
            }
        },
        methods:{
            closeModel(){
                this.$emit("input",false);
            }
        }
    }
</script>

<style scoped>

</style>