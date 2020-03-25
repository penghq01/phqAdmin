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
  //导航路由列表，转菜单树
  routerListToNavTree(data,pid=0){
    let list=[];
    data.forEach((item,key)=>{
      if(item.auth_type===0 && item.is_show===1){
        if(item.pid===pid){
          let tem={"title":item.title,"key":item.router,"icon":item.icon};
          let cd=this.routerListToNavTree(data,item.id);
          if(cd.length>0){
            tem.key=item.pid+"-"+item.id;
            tem.children=cd;
            //vue.$set(tem,"children",cd);
          }
          if(!utils.empty(tem.auth)){
            tem.auth=JSON.parse(tem.auth);
          }
          list.push(tem);
        }
      }
    });
    return list;
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
