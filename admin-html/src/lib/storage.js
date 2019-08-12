import util from './utils'

const TOKEN_STR = 'PHQ_ADMIN_TOKEN';
const USER_STR = 'PHQ_ADMIN_USER';
const token = {
  get () {
    let token = localStorage.getItem(TOKEN_STR);
    return util.empty(token) ? '' : token
  },
  set (token = '') {
    if (!util.empty(token)) {
      localStorage.setItem(TOKEN_STR, token)
    }
  },
  remove () {
    localStorage.removeItem(TOKEN_STR)
  }
};
const user = {
  get () {
    let user = localStorage.getItem(USER_STR);
    return util.empty(user) ? '' : JSON.parse(user)
  },
  set (user = '') {
    if (!util.empty(user)) {
      localStorage.setItem(USER_STR, JSON.stringify(user))
    }
  },
  remove () {
    localStorage.removeItem(USER_STR)
  }
};
function clearToken () {
  localStorage.clear()
}

export default {
  token, user,clearToken
}
