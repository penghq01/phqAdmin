import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import "./assets/lib/font-awesome/css/font-awesome.css"

import ElementUI from 'element-ui'
import "./lib/scss/element-variables.scss"

import iview from 'view-design';
import 'view-design/dist/styles/iview.css';

import "./lib/scss/public.scss"
import myDialog from "./components/myDialog"
import Paging from "./components/Paging"
import logic from "./lib/logic";

import filter from "./lib/filter"

//Vue.use(filter);
Vue.use(iview);
Vue.use(ElementUI);
Vue.component("myDialog",myDialog);
Vue.component("Paging",Paging);
Vue.config.productionTip = false;
//动态加载路由----------------------
  logic.addRoutes(router);
//动态加载路由-----------------
new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app');
