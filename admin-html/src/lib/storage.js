import util from './utils'
import router from "../router/router";

const TOKEN_STR = 'PHQ_ADMIN_TOKEN';
const USER_STR = 'PHQ_ADMIN_USER';
const MENU_AUTH_MAP="MENU_AUTH_MAP";
export default {
 token:{
    get () {
      let val = localStorage.getItem(TOKEN_STR);
      return util.empty(val) ? '' : val
    },
    set (val = '') {
      if (!util.empty(val)) {
        localStorage.setItem(TOKEN_STR, val)
      }
    },
    remove () {
      localStorage.removeItem(TOKEN_STR)
    }
  },
 user:{
  get () {
    let val = localStorage.getItem(USER_STR);
    return util.empty(user) ? '' : JSON.parse(val)
  },
  set (val = '') {
    if (!util.empty(val)) {
      localStorage.setItem(USER_STR, JSON.stringify(val))
    }
  },
  remove () {
    localStorage.removeItem(USER_STR)
  }
},
 menuAuthMap:{
  get () {
    let val = localStorage.getItem(MENU_AUTH_MAP);
    return util.empty(val) ?new Map(): JSON.parse(val)
  },
  set (val = '') {
    if (!util.empty(val)) {
      localStorage.setItem(MENU_AUTH_MAP, JSON.stringify(val))
    }
  },
  remove () {
    localStorage.removeItem(MENU_AUTH_MAP)
  }
},
 clear(){
  localStorage.clear()
}
}
