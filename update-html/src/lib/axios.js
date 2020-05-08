import axios from "axios"
import config from "../config";
import storage from "./storage";

axios.defaults.timeout = 1000 * 60 * config.httpTimeout;//超时时间
// 添加请求拦截器
axios.interceptors.request.use(function (request) {
    // 在发送请求之前做些什么
    request.url=config.host + config.apiPath + request.url;
    request.headers.common['auth-token'] = storage.token.get();//添加token
    return request;
}, function (error) {
    // 对请求错误做些什么
    //console.log("请求错误",error);
    return Promise.reject(error);
});
