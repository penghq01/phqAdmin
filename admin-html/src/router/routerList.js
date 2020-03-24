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
                name: 'Auth',
                nickname: "路由权限管理",
                component: () => import('../views/auth/Auth.vue')
            },
            {
                path: '/api',
                name: 'Api',
                nickname: "数据权限管理",
                component: () => import('../views/auth/Api.vue')
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
                path: '/sql',
                name: 'sql',
                nickname: "数据备份恢复",
                component: () => import('../views/system/Database.vue')
            }
        ]
    }
}
