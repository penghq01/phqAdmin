import Vue from "vue"
import utils from "./utils";
import config from "../config";

//全局过滤器

//格式化时间
Vue.filter('unixToDateTime', function(value = '0',format="YYYY-MM-DD HH:mm:ss") {
    return utils.UnixToDateTime(value,format);
});

//格式化图片路径
Vue.filter('getImageSrc', function(path = '') {
    let src="";
    if(!utils.empty(path)){
        let str=path.substr(0,4);
        src=str=="http"?path:config.imgHost+path;
    }
    return src;
});
