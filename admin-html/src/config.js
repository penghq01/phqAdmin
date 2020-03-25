export default {
  host:CONFIG.host,
  platform:{
    isWeb:process.env.VUE_APP_PLATFORM.trim()==="web",
    isPC:process.env.VUE_APP_PLATFORM.trim()==="pc"
  },
  loginPath:CONFIG.loginHref,
  homePage:CONFIG.homePagePath,
  imgHost:process.env.NODE_ENV==='production'? CONFIG.img_host:'http://localhost:8181',
  apiPath:CONFIG.api_path,
}
