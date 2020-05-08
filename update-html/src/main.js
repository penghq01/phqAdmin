import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import "./assets/lib/font-awesome/css/font-awesome.css"

import ElementUI from 'element-ui'
import "./lib/scss/element-variables.scss"

import "./lib/scss/public.scss"
import myDialog from "./components/myDialog"
import Poptip from "./components/Poptip";
import "./lib/axios"
import  "./lib/filter"



//Vue.use(filter);
Vue.use(ElementUI);
Vue.component("Poptip",Poptip);
Vue.component("myDialog",myDialog);

Vue.config.productionTip = false;
new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app');
