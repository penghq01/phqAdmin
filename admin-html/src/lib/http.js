import axios from 'axios'
import util from './utils'
import message from './message'
import storage from './storage'
import config from '../config'
import md5 from "js-md5"
let base64 = require('js-base64').Base64;
const HTTP_CODE = {
    SUCCESS:200,  //访问成功
    ERROR:400,    //访问失败
    LOGIN:4001,   //请登录后访问
    RELOGIN:4002, //登录过期，请重新登录
    NOAUTH:4003  //您没有权限访问
};

export default {
    post(url = '', params = {}, isToast = true,upload=false,progress=()=>{}){
    let httpURL = config.host + config.apiPath + url;
    let time=new Date().getTime();
    time=time.toString();
    let sign=md5(base64.encode(md5(time)+"."+base64.encode(JSON.stringify(params))+"."+time));
    sign+="."+time.toString();
    var instance = axios.create({
        onUploadProgress: function (progressEvent) {
            // 对原生进度事件的处理
            progress(progressEvent);
        },
    });
    instance.defaults.timeout = 1000 * 30 ;//超时时间
    instance.defaults.headers.common['auth-token'] = storage.token.get();//添加token
    instance.defaults.headers.common['sign'] = sign;//添加签名
    if(upload){
        instance.defaults.headers.post['Content-Type'] = 'multipart/form-data';
    }
    // 添加响应拦截器
    instance.interceptors.response.use(
        response => {
            // 对响应数据做点什么
            message.loading.hide();
            let data = response.data;
            let retData = {};
            switch (data.code) {
                case HTTP_CODE.SUCCESS:
                    isToast && !util.empty(data.msg) && message.msg.success(data.msg);
                    retData = Promise.resolve(data.data);
                    break;
                case HTTP_CODE.ERROR:
                    isToast && !util.empty(data.msg) && message.msg.error(data.msg);
                    retData = Promise.reject(data.msg);
                    break;
                case HTTP_CODE.NOAUTH:
                    message.alert(data.msg, {title: '提示',okFunction:()=>{

                        }});
                    retData = Promise.reject(data.msg);
                    break;
                case HTTP_CODE.LOGIN:
                    message.alert(data.msg,{title:"登录提示",okFunction:()=>{
                            storage.clear();
                            window.location.href = '/admin/#/login';
                        }});
                    retData = Promise.reject(data.msg);
                    break;
                case HTTP_CODE.RELOGIN:
                    message.alert(data.msg, {title:'登录过期',okFunction:()=>{
                            storage.clear();
                            window.location.href = '/admin/#/login';
                        }});
                    retData = Promise.reject(data.msg);
                    break;
                default:
                    message.msg.error('数据解析失败');
                    retData = Promise.reject(data.msg);
                    break
            }
            return retData
        },
        error => {
            message.loading.hide();
            // 对响应错误做点什么
            isToast && message.msg.error('服务器忙');
            return Promise.reject(error)
        });
    return instance.post(httpURL,params);
}
}
