import axios from 'axios'
import util from './utils'
import message from './message'
import storage from './storage'
const HTTP_CODE = {
    SUCCESS:200,  //访问成功
    ERROR:400,    //访问失败
    LOGIN:4001,   //请登录后访问
    RELOGIN:4002, //登录过期，请重新登录
    NOAUTH:4003  //您没有权限访问
};
//处理响应数据
const responseHandle=(data,executor={resolve:()=>{}, reject:()=>{},isToast:true})=>{
    switch (data.code) {
        case HTTP_CODE.SUCCESS:
            executor.isToast && !util.empty(data.msg) && message.msg.success(data.msg);
            executor.resolve(data.data);
            break;
        case HTTP_CODE.ERROR:
            executor.isToast && !util.empty(data.msg) && message.msg.error(data.msg);
            executor.reject(data.msg);
            break;
        case HTTP_CODE.NOAUTH:
            message.alert(data.msg, {title: '提示',okFunction:()=>{
                }});
            //executor.reject(data.msg);
            break;
        case HTTP_CODE.LOGIN:
            message.alert(data.msg,{title:"登录提示",okFunction:()=>{
                    storage.clear();
                    window.location.href = '/#/login';
                }});
            //executor.reject(data.msg);
            break;
        case HTTP_CODE.RELOGIN:
            message.alert(data.msg, {title:'登录过期',okFunction:()=>{
                    storage.clear();
                    window.location.href = '/#/login';
                }});
            //reject(data.msg);
            break;
        default:
            executor.isToast && message.msg.error('数据解析失败');
            executor.reject(data.msg);
            break
    }
};
export default {
    upload(url = '',params={},progress=()=>{},isToast=true){
        return new Promise((resolve, reject) =>{
            let config={
                headers:{"Content-Type":'multipart/form-data'},
                onUploadProgress:function (progressEvent) {
                    // 对原生进度事件的处理
                    progress(progressEvent);
                }
            };
            let param = new FormData();
            for(let key in params){
                param.append(key,params[key]);
            }
            axios.post(url,param,config).then(response=>{
                // 对响应数据做点什么
                let data = response.data;
                responseHandle(data,{resolve, reject,isToast});
            }).catch(err=>{
                isToast && message.msg.error('网路繁忙');
                reject(err);
            }).finally(()=>message.loading.hide())
        })
    },
    post(url = '',params={},isToast=true){
        return new Promise((resolve, reject) =>{
            axios.post(url,params).then(response=>{
                // 对响应数据做点什么
                let data = response.data;
                responseHandle(data,{resolve,reject,isToast});
            }).catch(err=>{
                isToast && message.msg.error('网路繁忙');
                reject(err);
            }).finally(()=>message.loading.hide())
        })
    }
}
