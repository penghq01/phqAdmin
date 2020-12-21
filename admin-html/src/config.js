//PC端连接地址
const HOST = process.env.NODE_ENV === 'production' ? CONFIG.host : ''
const IMG_HOST = process.env.NODE_ENV === 'production' ? CONFIG.img_host : 'http://localhost:8181'
const PC_HOST = process.env.NODE_ENV === 'production' ? "http://www.cgrj.top" : "http://localhost:8181";
const PC_IMG_HOST = process.env.NODE_ENV === 'production' ? "http://www.cgrj.top" : "http://localhost:8181";
export default {
    version: "1.0.0",
    sysName: CONFIG.appName,
    host: process.env.VUE_APP_PLATFORM.trim() === "pc" ? PC_HOST : HOST,
    platform: {
        isWeb: process.env.VUE_APP_PLATFORM.trim() === "web",
        isPC: process.env.VUE_APP_PLATFORM.trim() === "pc"
    },
    loginPath: CONFIG.loginHref,
    homePage: CONFIG.homePagePath,
    imgHost: process.env.VUE_APP_PLATFORM.trim() === "pc" ? PC_IMG_HOST : IMG_HOST,
    apiPath: CONFIG.api_path,
    httpTimeout: CONFIG.httpTimeout,
}
