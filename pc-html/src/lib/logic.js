import storage from './storage'
import utils from './utils'
import defaultRouter from "../router/defaultRouter";
import routerList from "../router/routerList";
export default {
  //判断是否登录
  isLogin () {
    let token = storage.token.get();
    return !utils.empty(token);
  },
  //动态加载路由
  addRoutes(router){
    let routerArr=defaultRouter.getDefaultRouterList();
    //console.log(routerArr);
    let router_list= routerList.routerList();
    router_list.forEach(route=>{
        routerArr[0].children.push(route);
    });
    router.$addRoutes(routerArr);
  }
}
