//PC端连接地址
const CLI_HOST = "http://www.cgrj.top";
const IMG_HOST = process.env.NODE_ENV === 'production' ? CONFIG.img_host : 'http://www.cgrj.top'
export default {
    version: "1.0.0",
    sysName: "PHQ管理后台",
    host: process.env.VUE_APP_PLATFORM.trim() === "web" ? CONFIG.host : CLI_HOST,
    platform: {
        isWeb: process.env.VUE_APP_PLATFORM.trim() === "web",
        isPC: process.env.VUE_APP_PLATFORM.trim() === "pc"
    },
    loginPath: CONFIG.loginHref,
    homePage: CONFIG.homePagePath,
    imgHost: process.env.VUE_APP_PLATFORM.trim() === "web" ? IMG_HOST : CLI_HOST,
    apiPath: CONFIG.api_path,
    httpTimeout: CONFIG.httpTimeout,
}
