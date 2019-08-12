<template>
    <Icon></Icon>
</template>

<script>
    import Icon from "../../components/Icon"
    export default {
        methods:{
            select(icon){
                console.log(icon);
            }
        },
        components:{
            Icon
        }
    }
</script>
