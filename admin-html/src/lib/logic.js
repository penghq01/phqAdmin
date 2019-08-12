import storage from './storage'
import utils from './utils'

export default {
  isLogin () {
    let token = storage.token.get();
    return !utils.empty(token);
  }
}
