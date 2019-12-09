import axios from 'axios'
import message from "./message";
import util from "./utils";
import storage from "./storage";
const HTTP_CODE = {
    SUCCESS:200,  //访问成功
    ERROR:400,    //访问失败
    LOGIN:4001,   //请登录后访问
    RELOGIN:4002, //登录过期，请重新登录
    NOAUTH:4003  //您没有权限访问
};

export default {
 post(url = '',options={params:{},isToast:true}){
    return new Promise((resolve, reject) =>{
        axios.post(url,options.params).then(response=>{
            // 对响应数据做点什么
            let data = response.data;
            switch (data.code) {
                case HTTP_CODE.SUCCESS:
                    options.isToast && !util.empty(data.msg) && message.msg.success(data.msg);
                    resolve(data.data);
                    break;
                case HTTP_CODE.ERROR:
                    options.isToast && !util.empty(data.msg) && message.msg.error(data.msg);
                   reject(data.msg);
                    break;
                case HTTP_CODE.NOAUTH:
                    message.alert(data.msg, {title: '提示',okFunction:()=>{

                    }});
                    //reject(data.msg);
                    break;
                case HTTP_CODE.LOGIN:
                    message.alert(data.msg,{title:"登录提示",okFunction:()=>{
                            storage.clear();
                            window.location.href = '/#/login';
                    }});
                    //reject(data.msg);
                    break;
                case HTTP_CODE.RELOGIN:
                    message.alert(data.msg, {title:'登录过期',okFunction:()=>{
                            storage.clear();
                            window.location.href = '/#/login';
                        }});
                    //reject(data.msg);
                    break;
                default:
                    options.isToast && message.msg.error('数据解析失败');
                    reject(data.msg);
                    break
            }
        }).catch(err=>{
            options.isToast && message.msg.error('网路繁忙');
            reject(err);
        }).finally(()=>message.loading.hide())
    })
 }
}
