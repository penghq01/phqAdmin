import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import message from './lib/message'
import global from './lib/global'
import "./assets/lib/font-awesome/css/font-awesome.css"

import ElementUI from 'element-ui'
import "./lib/scss/element-variables.scss"
import {Poptip,Icon,Input} from 'iview';
import 'iview/dist/styles/iview.css';

import "./lib/scss/public.scss"
import myDialog from "./components/myDialog"
import Paging from "./components/Paging"
Vue.use(ElementUI);
Vue.component('Poptip', Poptip);
Vue.component('Icon', Icon);
Vue.component('Input', Input);
Vue.component("myDialog",myDialog);
Vue.component("Paging",Paging);
Vue.config.productionTip = false;
Vue.prototype.message = message;
Vue.prototype.global = global;
new Vue({
  mounted () {
    global._this = this
  },
  router,
  store,
  render: h => h(App)
}).$mount('#app');
