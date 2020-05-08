import util from './utils'

const TOKEN_STR = 'PHQ_ADMIN_UPDATE_TOKEN';
export default {
    token: {
        get() {
            let val = localStorage.getItem(TOKEN_STR);
            return util.empty(val) ? '' : val
        },
        set(val = '') {
            if (!util.empty(val)) {
                localStorage.setItem(TOKEN_STR, val)
            }
        },
        remove() {
            localStorage.removeItem(TOKEN_STR)
        }
    },
    clear() {
        localStorage.clear();
        sessionStorage.clear();
    }
}
