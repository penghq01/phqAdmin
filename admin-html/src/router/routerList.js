export default {
    routerList() {
        return [
            {
                path: '/admin',
                name: 'admin',
                nickname: "管理员管理",
                component: () => import('../views/auth/Admin.vue')
            },
            {
                path: '/role',
                name: 'role',
                nickname: "角色管理",
                component: () => import('../views/auth/Role.vue')
            },
            {
                path: '/auth',
                name: 'auth',
                nickname: "权限管理",
                component: () => import('../views/auth/Auth.vue')
            },
            {
                path: '/images',
                name: 'images',
                nickname: "图片管理",
                component: () => import('../views/annexes/Images.vue')
            },
            {
                path: '/icon',
                name: 'icon',
                nickname: "图标管理",
                component: () => import('../views/annexes/Icon.vue')
            },
            {
                path: '/user',
                name: 'user',
                nickname: "会员管理",
                component: () => import('../views/user/User.vue')
            },
            {
                path: '/paylog',
                name: 'paylog',
                nickname: "会员充值记录",
                component: () => import('../views/user/PayLog.vue')
            }
        ]
    }
}