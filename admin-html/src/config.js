const HOST=process.env.NODE_ENV==='production'? 'http://localhost:8181':'';
export default {
  host:HOST,
  platform:{
    isWeb:process.env.VUE_APP_PLATFORM.trim()==="web",
    isPC:process.env.VUE_APP_PLATFORM.trim()==="pc"
  },
  imgHost:process.env.NODE_ENV==='production'? HOST+'/':'http://localhost:8181/',
  apiPath: '/admin-api/',
}
