import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import "./assets/lib/font-awesome/css/font-awesome.css"

import ElementUI from 'element-ui'
import "./lib/scss/element-variables.scss"

import "./lib/scss/public.scss"
import myDialog from "./components/myDialog"
import "./lib/filter"
import logic from "./lib/logic";
import Log from "./lib/Log"
import "./lib/axios"
Vue.config.productionTip = false;

Vue.use(ElementUI);
Vue.component("myDialog",myDialog);

Vue.prototype.$Log=Log;
//动态加载路由----------------------
  logic.addRoutes(router);
//动态加载路由-----------------
new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app');
