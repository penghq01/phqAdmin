const HOST=process.env.NODE_ENV==='production'? '':'';
export default {
  host:HOST,
  apiPath: '/admin-api/'
}
