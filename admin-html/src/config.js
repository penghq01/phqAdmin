const HOST=process.env.NODE_ENV==='production'? 'http://localhost:8181':'';
export default {
  host:HOST,
  imgHost:process.env.NODE_ENV==='production'? HOST+'/':'http://localhost:8181/',
  apiPath: '/admin-api/'
}
