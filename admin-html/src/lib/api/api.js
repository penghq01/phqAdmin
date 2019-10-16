import utils from '../utils'
import http from '../http'
import storage from '../storage'
import message from '../message'
import md5 from "js-md5"
import routerList from "../../router/routerList";
export default {
    Login(data = {}) {
        return new Promise((resolve, reject) => {
            data=utils.NewObject(data);
            if (utils.empty(data.username)) {
                message.msg.error('账号不能为空');
                return;
            }
            if (utils.empty(data.password)) {
                message.msg.error('密码不能为空');
                return;
            }
            message.loading.show("登录中");
            data.password=md5(data.password);
            http.post('login', data).then(data => {
                storage.token.set(data.token);
                let MenuAuthMap=new Map();
                data.menu_auth.forEach(item=>{
                    if(!utils.empty(item.crouter)){
                        MenuAuthMap[item.crouter]=item.auth;
                    }
                });
                storage.menuAuthMap.set(MenuAuthMap);
                resolve();
            }).catch(err => {})
        })
    }
}
