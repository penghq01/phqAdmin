package routers

import (
	"github.com/astaxie/beego"
	"server/common"
	"server/controllers/adminApi"
)

type RouterInfo struct {
	Id             int
	Name           string
	Path           string
	Controller     beego.ControllerInterface
	MappingMethods string
}

func InitRoute() {
	common.Logs.Info("▶ 初始化数据接口路由")
	RouterList := GetServerRouterList()
	list := make([]common.RouterInfo, 0)
	//设置api路由
	ApiList := GetApiRouterList()
	for _, router := range ApiList {
		beego.Router(router.Path, router.Controller, router.MappingMethods)
	}
	for _, router := range RouterList {
		beego.Router(router.Path, router.Controller, router.MappingMethods)
		list = append(list, common.RouterInfo{
			Path: router.Path,
			Name: router.Name,
		})
	}
	common.Logs.Info("▶ 数据接口路由初始化完成")
}

//获取后台管理数据接口路由
func GetServerRouterList() []RouterInfo {
	var AdminRootPath string = "/admin/api" //后台api接口路由root
	RouterList := []RouterInfo{
		//后台api接口路由 ------start--------
		{
			Name:           "后台登录",
			Path:           AdminRootPath + "/login",
			Controller:     &adminApi.Login{},
			MappingMethods: "post:Login",
		},
		{
			Name:           "获取管理员列表",
			Path:           AdminRootPath + "/admin/list",
			Controller:     &adminApi.Admin{},
			MappingMethods: "post:List",
		},
		{
			Name:           "添加管理员",
			Path:           AdminRootPath + "/admin/add",
			Controller:     &adminApi.Admin{},
			MappingMethods: "post:Add",
		},
		{
			Name:           "删除管理员",
			Path:           AdminRootPath + "/admin/del",
			Controller:     &adminApi.Admin{},
			MappingMethods: "post:Del",
		},
		{
			Name:           "修改管理员",
			Path:           AdminRootPath + "/admin/edit",
			Controller:     &adminApi.Admin{},
			MappingMethods: "post:Edit",
		},
		{
			Name:           "获取管理员信息",
			Path:           AdminRootPath + "/admin/info",
			Controller:     &adminApi.Admin{},
			MappingMethods: "post:Info",
		},
		{
			Name:           "管理员修改密码",
			Path:           AdminRootPath + "/admin/edit/pass",
			Controller:     &adminApi.Admin{},
			MappingMethods: "post:EditPass",
		},
		{
			Name:           "获取前端导航",
			Path:           AdminRootPath + "/admin/auth",
			Controller:     &adminApi.Admin{},
			MappingMethods: "post:AuthList",
		},
		{
			Name:           "获取图标列表（分页）",
			Path:           AdminRootPath + "/icon/list/:page_size/:page",
			Controller:     &adminApi.Icon{},
			MappingMethods: "post:PageList",
		},
		{
			Name:           "添加图片",
			Path:           AdminRootPath + "/icon/add",
			Controller:     &adminApi.Icon{},
			MappingMethods: "post:Add",
		},
		{
			Name:           "删除图标",
			Path:           AdminRootPath + "/icon/del",
			Controller:     &adminApi.Icon{},
			MappingMethods: "post:Del",
		},
		{
			Name:           "获取会员列表（分页）",
			Path:           AdminRootPath + "/user/list/:page_size/:page",
			Controller:     &adminApi.User{},
			MappingMethods: "post:List",
		},
		{
			Name:           "获取权限列表",
			Path:           AdminRootPath + "/auth/list",
			Controller:     &adminApi.Auth{},
			MappingMethods: "post:List",
		},
		{
			Name:           "添加权限",
			Path:           AdminRootPath + "/auth/add",
			Controller:     &adminApi.Auth{},
			MappingMethods: "post:Add",
		},
		{
			Name:           "修改权限",
			Path:           AdminRootPath + "/auth/edit",
			Controller:     &adminApi.Auth{},
			MappingMethods: "post:Edit",
		},
		{
			Name:           "删除权限",
			Path:           AdminRootPath + "/auth/del",
			Controller:     &adminApi.Auth{},
			MappingMethods: "post:Del",
		},
		{
			Name:           "获取数据接口列表(分页)",
			Path:           AdminRootPath + "/api/list/:page_size/:page",
			Controller:     &adminApi.Api{},
			MappingMethods: "post:PageList",
		},
		{
			Name:           "获取数据接口列表",
			Path:           AdminRootPath + "/api/list",
			Controller:     &adminApi.Api{},
			MappingMethods: "post:List",
		},
		{
			Name:           "添加数据接口",
			Path:           AdminRootPath + "/api/add",
			Controller:     &adminApi.Api{},
			MappingMethods: "post:Add",
		},
		{
			Name:           "修改数据接口",
			Path:           AdminRootPath + "/api/edit",
			Controller:     &adminApi.Api{},
			MappingMethods: "post:Edit",
		},
		{
			Name:           "删除数据接口",
			Path:           AdminRootPath + "/api/del",
			Controller:     &adminApi.Api{},
			MappingMethods: "post:Del",
		},
		{
			Name:           "上传图片",
			Path:           AdminRootPath + "/files/upload/img",
			Controller:     &adminApi.FileClass{},
			MappingMethods: "post:UploadImage",
		},
		{
			Name:           "添加文件分类",
			Path:           AdminRootPath + "/files/add/class",
			Controller:     &adminApi.FileClass{},
			MappingMethods: "post:Add",
		},
		{
			Name:           "修改文件分类",
			Path:           AdminRootPath + "/files/edit/class",
			Controller:     &adminApi.FileClass{},
			MappingMethods: "post:Edit",
		},
		{
			Name:           "获取文件分类列表",
			Path:           AdminRootPath + "/files/list/class",
			Controller:     &adminApi.FileClass{},
			MappingMethods: "post:List",
		},
		{
			Name:           "删除文件分类",
			Path:           AdminRootPath + "/files/del/class",
			Controller:     &adminApi.FileClass{},
			MappingMethods: "post:Del",
		},
		{
			Name:           "获取图片列表（分页）",
			Path:           AdminRootPath + "/files/list/:page_size/:page",
			Controller:     &adminApi.Files{},
			MappingMethods: "post:PageList",
		},
		{
			Name:           "删除图片",
			Path:           AdminRootPath + "/files/del",
			Controller:     &adminApi.Files{},
			MappingMethods: "post:Del",
		},
		{
			Name:           "获取角色列表",
			Path:           AdminRootPath + "/role/list",
			Controller:     &adminApi.Role{},
			MappingMethods: "post:List",
		},
		{
			Name:           "获取角色权限列表",
			Path:           AdminRootPath + "/role/auth-list",
			Controller:     &adminApi.Role{},
			MappingMethods: "post:AuthList",
		},
		{
			Name:           "删除角色",
			Path:           AdminRootPath + "/role/del",
			Controller:     &adminApi.Role{},
			MappingMethods: "post:Del",
		},
		{
			Name:           "修改角色",
			Path:           AdminRootPath + "/role/edit",
			Controller:     &adminApi.Role{},
			MappingMethods: "post:Edit",
		},
		{
			Name:           "添加角色",
			Path:           AdminRootPath + "/role/add",
			Controller:     &adminApi.Role{},
			MappingMethods: "post:Add",
		},
		{
			Name:           "SQL列表",
			Path:           AdminRootPath + "/sql/list",
			Controller:     &adminApi.Admin{},
			MappingMethods: "post:ListSql",
		},
		{
			Name:           "导出sql",
			Path:           AdminRootPath + "/sql/exprot",
			Controller:     &adminApi.Admin{},
			MappingMethods: "post:ExportSqL",
		},
		{
			Name:           "导入sql",
			Path:           AdminRootPath + "/sql/improt",
			Controller:     &adminApi.Admin{},
			MappingMethods: "post:ImportSqL",
		},
		{
			Name:           "删除sql",
			Path:           AdminRootPath + "/sql/del",
			Controller:     &adminApi.Admin{},
			MappingMethods: "post:DelSqL",
		},
		//后台api接口路由 ------end--------
	}
	return RouterList
}

//获取后台APi接口路由
func GetApiRouterList() []RouterInfo {
	//var ApiRootPath string = "/api" //api接口路由root
	RouterList := []RouterInfo{
		//api接口路由 ------start--------
		//api接口路由 ------end--------
	}
	return RouterList
}
