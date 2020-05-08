import Vue from "vue"
import utils from "./utils";

//全局过滤器

//格式化时间
Vue.filter('unixToDateTime', function(value = '0',format="YYYY-MM-DD HH:mm:ss") {
    return utils.UnixToDateTime(value,format);
});


