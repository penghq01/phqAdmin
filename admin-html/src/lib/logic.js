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
  addRoutes(self,router=[],isDefault=false){
    let routerArr=defaultRouter;
    if(isDefault){
      router.forEach(item=>{
        routerArr[0].children.push(item);
      });
    }else{
      let router_list=new Map();
      routerList.forEach(item=>{
        router_list[item.path]=item;
      });
      router.forEach(item=>{
        if(item.auth_type===0 && !utils.empty(item.router)){
          let r=router_list[item.router];
          if(!utils.empty(r)){
            routerArr[0].children.push(r);
          }
        }
      });
    }
    routerArr[0].children.push({path: "/", redirect:"/index"});
    self.$addRoutes(routerArr);
    routerArr[0].children=[];
  }
}
