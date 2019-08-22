const HOST=process.env.NODE_ENV==='production'? '':'';
export default {
  host:HOST,
  imgHost:"http://localhost:8181/",
  apiPath: '/admin-api/'
}
