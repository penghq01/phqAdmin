const conf =require("./conf.js");
export default {
  host:conf.HOST,
  platform:{
    isWeb:process.env.VUE_APP_PLATFORM.trim()==="web",
    isPC:process.env.VUE_APP_PLATFORM.trim()==="pc"
  },
  imgHost:process.env.NODE_ENV==='production'? conf.IMG_HOST:'http://localhost:8181',
  apiPath:conf.API_PATH,
}
