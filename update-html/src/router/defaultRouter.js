import Update from "../views/Update";
import Login from "../views/Login";
export default [
    {
        path: '/',
        name: 'Update',
        nickname:"后台主页",
        component: Update,
    },
    {
        path: '/login',
        name: 'login',
        nickname:"后台登录",
        component: Login
    },
    {
        path: "/*",
        redirect:"/"
    }
];
