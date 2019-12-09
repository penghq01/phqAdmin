import Home from '../views/Home.vue'
export default {
    getDefaultRouterList(){
        return [
            {
                path: '/',
                component: Home,
                nickname:"主界面",
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
                nickname:"登录",
                component: () => import( '../views/Login.vue')
            },
            {
                path: "/",
                redirect:"/login"
            },
        ];
    }
}
