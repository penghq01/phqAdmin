const HOST=process.env.NODE_ENV=='production'? '':'';
export default {
  host: HOST,
  imgHost: process.env.NODE_ENV== 'production' ? HOST + '/' : 'http://localhost:8181/',
  apiPath: '/api',
  isDebug: process.env.NODE_ENV== 'production' ? false : true,
}
