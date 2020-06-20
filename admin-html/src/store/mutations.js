
const mutations={
     //更新UI权限
     UPDATE_UI_AUTH(state,val){
          state.uiAuth=val;
     },
     //更新用户信息
     UPDATE_USER_INFO(state,val){
          state.userInfo=val;
     },
     //更新导航菜单列表
     UPDATE_ROUTER_LIST(state,val){
          state.routerList=val;
     },
     //更新导航菜单树
     UPDATE_ROUTER_TREE_LIST(state,val){
          state.menuTreeList=val;
     },
     //更新内容区域高度
     UPDATE_BODY_HEIGHT(state,val){
          state.bodyHeight=val;
     },
};
export default mutations
