<template>
    <vueQr :text="text" :margin="qMargin" :colorDark="qColor" :colorLight="backColor"   :size="qSize"></vueQr>
</template>
<script>
    /*
    * text	二维码内容
qSize	二维码宽高大小，因为是正方形，所以设一个参数即可
qMargin	默认边距20px，不喜欢的话自己设为0
qColor	实点的颜色，注意要和colorLight一起设置才有效
backColor	空白的颜色，注意要和colorDark一起设置才有效

bgSrc	嵌入背景图地址，没什么卵用，不建议设置
logoSrc	二维码中间的图，这个是好东西，设置一下显得专业点
logoScale	中间图的尺寸，不要设太大，太大会导致扫码失败的
dotScale	那些小点点的大小，这个也没什么好纠结的，不建议设置了
*/
    import vueQr from 'vue-qr'
    export default {
        name:"Qrcode",
        components: {
            vueQr
        },
        data() {
            return {};
        },
        props: {
            text: {
                type: String,
                default: ''
            },
            qSize: {
                type: Number,
                default:260
            },
            qMargin:{
                type: Number,
                default:15
            },
            qColor: {
                type: String,
                default: '#000000'
            },
            backColor: {
                type: String,
                default: '#ffffff'
            },
        }
    };
</script>
<style scoped>

</style>
