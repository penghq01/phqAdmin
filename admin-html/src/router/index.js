import Vue from 'vue'
import Router from 'vue-router'
import routes from './router'
import logic from '../lib/logic'
import message from "../lib/message";
import storage from "../lib/storage";
Vue.use(Router);

const RouterInfo = new Router({
  mode: 'hash',//history
  routes:routes
});
RouterInfo.beforeEach((to, from, next) => {
  if(to.path != "/login" && !logic.isLogin()){
    message.alert("您还没有登录或者登录状态已过期，请登录后访问", {title:'登录提示',okFunction:()=>{
        storage.clear();
        next({ path: '/login' });
    }});
  }else{
    next();
  }
});
RouterInfo.$addRoutes = (params) => {
  RouterInfo.matcher = new Router({mode: 'history'}).matcher;
  RouterInfo.addRoutes(params)
};
export default RouterInfo
