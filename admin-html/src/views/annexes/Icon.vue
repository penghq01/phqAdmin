<template>
    <myIcon></myIcon>
</template>

<script>
    import myIcon from "../../components/Icon"
    export default {
        methods:{
            select(icon){
                console.log(icon);
            }
        },
        components:{
            myIcon
        }
    }
</script>
