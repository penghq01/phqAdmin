//PC端连接地址
const HOST = process.env.NODE_ENV === 'production' ? CONFIG.host : ''
const IMG_HOST = process.env.NODE_ENV === 'production' ? CONFIG.img_host : 'http://localhost:8181'
export default {
    version: "1.0.0",
    sysName: "PHQ管理后台",
    host: HOST,
    loginPath: CONFIG.loginHref,
    homePage: CONFIG.homePagePath,
    imgHost:IMG_HOST,
    apiPath: CONFIG.api_path,
    httpTimeout: CONFIG.httpTimeout,
}
