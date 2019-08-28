import Home from '../views/Home.vue'

export default [
  {
    path: '/',
    component: Home,
    children:[
      {
        path: '/index',
        name: '/index',
        component: () => import('../views/Index.vue')
      },
      {
        path: '/admin',
        name: '/admin',
        component: () => import('../views/auth/Admin.vue')
      },
      {
        path: '/role',
        name: '/role',
        component: () => import('../views/auth/Role.vue')
      },
      {
        path: '/auth',
        name: '/auth',
        component: () => import('../views/auth/Auth.vue')
      },
      {
        path: '/images',
        name: '/images',
        component: () => import('../views/annexes/Images.vue')
      },
      {
        path: '/icon',
        name: '/icon',
        component: () => import('../views/annexes/Icon.vue')
      },
      {
        path: '/user',
        name: '/user',
        component: () => import('../views/user/User.vue')
      },
      {
        path: '/paylog',
        name: '/paylog',
        component: () => import('../views/user/PayLog.vue')
      },
      {
        path: "/",
        redirect:"/index"
      }
    ]
  },
  {
    path: '/login',
    name: '/login',
    component: () => import( '../views/Login.vue')
  }
]
