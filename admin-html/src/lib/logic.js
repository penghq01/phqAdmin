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
  //从本地存储中获取菜单权限
  getMenuAuth(self){
    let path=self.$router.history.current.path;
    let MenuAuthMap=storage.menuAuthMap.get();
    return MenuAuthMap[path];
  },
  //动态加载路由
  addRoutes(router){
    let routerArr=defaultRouter.getDefaultRouterList();
    //console.log(routerArr);
    let MenuAuthMap=storage.menuAuthMap.get();
    let router_list= routerList.routerList();
    router_list.forEach(route=>{
      routerArr[0].children.push(route);
    });
    router.$addRoutes(routerArr);
  }
}
