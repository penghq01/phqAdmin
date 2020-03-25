import Home from "../views/Home";
export default [
    {
        path: '/',
        component: Home,
        nickname:"后台主页",
        children:[]
    },
    {
        path: '/login',
        name: 'login',
        nickname:"后台登录",
        component: () => import( '../views/Login.vue')
    },
    {
        path: '/not-find',
        name: 'NotFindPage',
        nickname:"找不到页面",
        component: () => import( '../views/NotFindPage.vue')
    },
    {
        path: "/*",
        redirect:"/not-find"
    }
];
