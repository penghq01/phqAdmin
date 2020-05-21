import Vue from 'vue'
import Router from 'vue-router'
import defaultRouter from './defaultRouter'
import logic from '../lib/logic'
import message from "../lib/message";
import storage from "../lib/storage";
import publicPath from "../lib/publicPath";

Vue.use(Router);

const RouterInfo = new Router({
    mode: 'hash',//history
    routes: defaultRouter
});
const isLoginPath = (path) => {
   let isTrue=true;
   publicPath.forEach(item =>{
       if(item===path){
           isTrue=false;
       }
   });
   return isTrue;
};
RouterInfo.beforeEach((to, from, next) => {
    if (isLoginPath(to.path) && !logic.isLogin()) {
        next({path: '/login'});
    } else {
        next();
    }
});
RouterInfo.$addRoutes = (params) => {
    RouterInfo.matcher = new Router({mode: 'history'}).matcher;
    RouterInfo.addRoutes(params)
};
export default RouterInfo
