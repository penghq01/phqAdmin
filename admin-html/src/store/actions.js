import http from "../lib/http";
import publicPath from "../lib/publicPath";
import logic from "../lib/logic";

const actions={
    //更新UI权限
    updateUIAuth({commit}) {
        http.post("admin/ui_auth").then(data => {
            commit("UPDATE_UI_AUTH",data);
        }).catch(err => {});
     },
    //更新登陆用户信息
     updateUserInfo({commit}){
         http.post("admin/info").then(data => {
             commit("UPDATE_USER_INFO",data);
         }).catch(err => {
         });
     },
    //获取菜单列表
     updateRouterList({commit},router){
         http.post("admin/auth").then(data => {
             logic.addRoutes(router,data);
             publicPath.splice(0);
             data.forEach(item=>{
                 if(item.visit===0){
                     publicPath.push(item.router);
                 }
             });
             commit("UPDATE_ROUTER_LIST",data);
             let treeList=logic.routerListToNavTree(data);
             commit("UPDATE_ROUTER_TREE_LIST",treeList);
         }).catch(err => {});
     },
    //更新登陆用户信息
    updateBodyHeight({commit},height){
        commit("UPDATE_BODY_HEIGHT",height);
    },
};
export default actions
