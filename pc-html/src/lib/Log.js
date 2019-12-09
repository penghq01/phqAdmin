import config from "../config";

export default {
    log(...msg){
        if(config.isDebug){
            console.log(...msg);
        }
    },
    error(...msg){
        if(config.isDebug){
            console.error(...msg);
        }
    }
}
