import axios from "axios"
import config from "../config";
import md5 from "js-md5"
import storage from "./storage";
let base64 = require('js-base64').Base64;


axios.defaults.timeout = 1000 * 30 ;//超时时间
// 添加请求拦截器
axios.interceptors.request.use(function (request) {
    // 在发送请求之前做些什么
    request.url=config.host + config.apiPath + request.url;
    //计算sign
    let time=new Date().getTime();
    time=time.toString();
    let sign=md5(base64.encode(md5(time)+"."+base64.encode(JSON.stringify(request.data))+"."+time));
    sign+="."+time.toString();
    request.headers.common['auth-token'] = storage.token.get();//添加token
    request.headers.common['sign'] = sign;//添加签名
    return request;
}, function (error) {
    // 对请求错误做些什么
    console.log("请求错误",error);
    return Promise.reject(error);
});
