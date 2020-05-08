import storage from './storage'
import utils from './utils'
export default {
  //判断是否登录
  isLogin () {
    let token = storage.token.get();
    return !utils.empty(token);
  }
}
