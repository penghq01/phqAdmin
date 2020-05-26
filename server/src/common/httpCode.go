package common

const (
	HTTP_SUCCESS = 200  //访问成功
	HTTP_ERROR   = 400  //访问失败
	HTTP_LOGIN   = 4001 //请登录后访问
	HTTP_RELOGIN = 4002 //登录过期，请重新登录
	HTTP_NOAUTH  = 4003 //您没有权限访问
)
