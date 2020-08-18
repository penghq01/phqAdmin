import util from './utils'

const TOKEN_STR = 'PHQ_ADMIN_TOKEN';
export default {
    token: {
        get() {
            let val = localStorage.getItem(TOKEN_STR);
            if(util.empty(val)){
                val=sessionStorage.getItem(TOKEN_STR);
            }
            return  util.empty(val)? '' : val
        },
        set(val = '', local = false) {
            if (!util.empty(val)) {
                if (local) {
                    localStorage.setItem(TOKEN_STR, val);
                }
                sessionStorage.setItem(TOKEN_STR, val);
            }
        },
        remove() {
            localStorage.removeItem(TOKEN_STR)
            sessionStorage.removeItem(TOKEN_STR);
        }
    },
    clear() {
        localStorage.clear();
        sessionStorage.clear();
    }
}
