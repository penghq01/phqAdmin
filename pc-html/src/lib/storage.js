import utils from './utils'
import md5 from "js-md5"
const TOKEN_STR = 'PHQ_ADMIN_TOKEN';
const USER_STR = 'PHQ_ADMIN_USER';
const IM_CLIENTID="IM_CLIENTID";

export default {
 token:{
    get () {
      let val = localStorage.getItem(TOKEN_STR);
      return utils.empty(val) ? '' : val
    },
    set (val = '') {
      if (!utils.empty(val)) {
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
    return utils.empty(user) ? '' : JSON.parse(val)
  },
  set (val = '') {
    if (!utils.empty(val)) {
      localStorage.setItem(USER_STR, JSON.stringify(val))
    }
  },
  remove () {
    localStorage.removeItem(USER_STR)
  }
},
 clientId:{
  get () {
    let val = localStorage.getItem(IM_CLIENTID);
    if(utils.empty(val)){
        let stamp= utils.GetDateTimeTimestamp();
        let unix=utils.GetDateTimeUnix();
        val=md5(unix+"-"+stamp);
        localStorage.setItem(IM_CLIENTID,val);
    }
    return val;
  },
     /*
  set (val = '') {
    if (!utils.empty(val)) {
      localStorage.setItem(IM_CLIENTID,val);
    }
  },
  remove () {
    localStorage.removeItem(IM_CLIENTID);
  }
  */
},
 clear(){
  localStorage.clear()
}
}
