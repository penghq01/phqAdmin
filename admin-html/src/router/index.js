import Vue from 'vue'
import Router from 'vue-router'
import routes from './router'
import logic from '../lib/logic'
Vue.use(Router);

const RouterInfo = new Router({
  mode: 'hash',
  routes:routes
});
RouterInfo.beforeEach((to, from, next) => {
  if(to.path != "/login" && !logic.isLogin()){
    next({ path: '/login' });
    return false;
  }else{
    next();
  }
});
export default RouterInfo
