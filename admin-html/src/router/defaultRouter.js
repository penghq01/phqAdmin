import Home from '../views/Home.vue'
export default {
    getDefaultRouterList(){
        return [
            {
                path: '/',
                component: Home,
                nickname:"后台",
                children:[
                    {
                        path: "/",
                        redirect:"/index"
                    },
                    {
                        path: '/index',
                        name: 'index',
                        nickname:"首页",
                        component: () => import('../views/Index.vue')
                    },
                ]
            },
            {
                path: '/login',
                name: 'login',
                nickname:"后台登录",
                component: () => import( '../views/Login.vue')
            },
            {
                path: '/404',
                name: 'NoPage',
                nickname:"404错误页面",
                component: () => import( '../views/NoPage.vue')
            },
            {
                path: "/*",
                redirect:"/404"
            },
        ];
    }
}