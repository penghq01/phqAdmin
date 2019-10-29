const HOST=process.env.NODE_ENV==='production'? '':'';
export default {
  host:HOST,
  imgHost:process.env.NODE_ENV==='production'? HOST+'/server/':'http://localhost:8181/',
  apiPath: '/admin-api/'
}
