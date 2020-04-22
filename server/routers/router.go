package routers

import (
	"github.com/astaxie/beego"
	"reflect"
	"server/acc"
	"server/common"
	"server/controllers/adminApi"
)

type RouterInfo struct {
	Name           string
	Path           string
	Controller     beego.ControllerInterface
	MappingMethods string
}

//注册控制器结构体
var registerControllers []beego.ControllerInterface = []beego.ControllerInterface{
	new(adminApi.Admin),
	new(adminApi.Api),
	new(adminApi.Role),
	new(adminApi.Auth),
	new(adminApi.User),
	new(adminApi.Files),
	new(adminApi.FileClass),
	new(adminApi.Icon),
	new(adminApi.Login),
}

//控制器map
var controllerMap map[string]beego.ControllerInterface

func InitRoute() {
	//✖ ▶ ✔
	common.Logs.Info("▶ 注册路由……")
	controllerMap = make(map[string]beego.ControllerInterface)
	for _, c := range registerControllers {
		controllerMap[reflect.TypeOf(c).Elem().String()] = c
	}
	//注册后台路由
	for _, api := range acc.DateAPIList {
		if api.Struct != "" && api.MappingMethods != "" {
			c, ok := controllerMap[api.Struct]
			if ok {
				beego.Router(api.Router, c, api.MappingMethods)
			} else {
				common.Logs.Info("✖ 路由 [ %v ],注册失败，没有找到对应的struct", api.Router)
			}
		}
	}
	//注册前端api路由
	for _, router := range GetApiRouterList() {
		beego.Router(router.Path, router.Controller, router.MappingMethods)
	}
	common.Logs.Info("▶ 路由注册完成")
}

//获取前端APi接口路由
func GetApiRouterList() []RouterInfo {
	//var ApiRootPath string = "/api" //api接口路由root
	RouterList := []RouterInfo{
		//api接口路由 ------start--------
		//api接口路由 ------end--------
	}
	return RouterList
}
