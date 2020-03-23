export default {
  host:CONFIG.HOST,
  platform:{
    isWeb:process.env.VUE_APP_PLATFORM.trim()==="web",
    isPC:process.env.VUE_APP_PLATFORM.trim()==="pc"
  },
  loginPath:"/#/login",
  imgHost:process.env.NODE_ENV==='production'? CONFIG.IMG_HOST:'http://localhost:8181',
  apiPath:CONFIG.API_PATH,
}
