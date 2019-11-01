package routers

import (
	"github.com/astaxie/beego"
	"phqAdmin/server/common"
	"phqAdmin/server/controllers/adminApi"
)

type RouterInfo struct {
	Name string
	Path string
	Controller     beego.ControllerInterface
	MappingMethods string
}

func init() {
	RouterList:=GetServerRouterList()
	list:=make([]common.RouterInfo,0)
	for _,router:=range RouterList{
		beego.Router(router.Path,router.Controller,router.MappingMethods)
		list = append(list,common.RouterInfo{
			Path:  router.Path,
			Name:  router.Name,
		})
	}
	common.RouterList=list
}
//获取后台管理数据接口路由
func GetServerRouterList()[]RouterInfo{
	var AdminRootPath string = "/admin-api" //后台api接口路由root
	RouterList:= []RouterInfo{
		//后台api接口路由 ------start--------
		{
			Name:"后台登录",
			Path:AdminRootPath+"/login",
			Controller:      &adminApi.Login{},
			MappingMethods: "post:Login",
		},
		{
			Name:"获取管理员列表",
			Path:AdminRootPath+"/admin/list",
			Controller:      &adminApi.Admin{},
			MappingMethods: "post:List",
		},
		{
			Name:"添加管理员",
			Path:AdminRootPath+"/admin/add",
			Controller:      &adminApi.Admin{},
			MappingMethods: "post:Add",
		},
		{
			Name:"删除管理员",
			Path:AdminRootPath+"/admin/del",
			Controller:      &adminApi.Admin{},
			MappingMethods: "post:Del",
		},
		{
			Name:"修改管理员",
			Path:AdminRootPath+"/admin/edit",
			Controller:      &adminApi.Admin{},
			MappingMethods: "post:Edit",
		},
		{
			Name:"获取管理员信息",
			Path:AdminRootPath+"/admin/info",
			Controller:      &adminApi.Admin{},
			MappingMethods: "post:Info",
		},
		{
			Name:"管理员修改密码",
			Path:AdminRootPath+"/admin/edit/pass",
			Controller:      &adminApi.Admin{},
			MappingMethods: "post:EditPass",
		},
		{
			Name:"获取前端导航",
			Path:AdminRootPath+"/admin/auth",
			Controller:      &adminApi.Admin{},
			MappingMethods: "post:AuthList",
		},
		{
			Name:"获取图标列表（分页）",
			Path:AdminRootPath+"/icon/list/:page_size/:page",
			Controller:      &adminApi.Icon{},
			MappingMethods: "post:PageList",
		},
		{
			Name:"添加图片",
			Path:AdminRootPath+"/icon/add",
			Controller:      &adminApi.Icon{},
			MappingMethods: "post:Add",
		},
		{
			Name:"删除图标",
			Path:AdminRootPath+"/icon/del",
			Controller:      &adminApi.Icon{},
			MappingMethods: "post:Del",
		},
		{
			Name:"获取会员列表（分页）",
			Path:AdminRootPath+"/user/list/:page_size/:page",
			Controller:      &adminApi.User{},
			MappingMethods: "post:List",
		},
		{
			Name:"获取会员总余额和积分",
			Path:AdminRootPath+"/user/total/money-points",
			Controller:      &adminApi.User{},
			MappingMethods: "post:TotalMoneyPoints",
		},
		{
			Name:"获取会员充值记录",
			Path:AdminRootPath+"/user/pay/log/:page_size/:page",
			Controller:      &adminApi.User{},
			MappingMethods: "post:PayLog",
		},
		{
			Name:"获取权限列表",
			Path:AdminRootPath+"/auth/list",
			Controller:      &adminApi.Auth{},
			MappingMethods: "post:List",
		},
		{
			Name:"添加权限",
			Path:AdminRootPath+"/auth/add",
			Controller:      &adminApi.Auth{},
			MappingMethods: "post:Add",
		},
		{
			Name:"修改权限",
			Path:AdminRootPath+"/auth/edit",
			Controller:      &adminApi.Auth{},
			MappingMethods: "post:Edit",
		},
		{
			Name:"删除权限",
			Path:AdminRootPath+"/auth/del",
			Controller:      &adminApi.Auth{},
			MappingMethods: "post:Del",
		},
		{
			Name:"获取后台路由列表",
			Path:AdminRootPath+"/auth/get/router-list",
			Controller:      &adminApi.Auth{},
			MappingMethods: "post:GetAuthList",
		},
		{
			Name:"上传图片",
			Path:AdminRootPath+"/files/upload/img",
			Controller:      &adminApi.FileClass{},
			MappingMethods: "post:UploadImage",
		},
		{
			Name:"添加文件分类",
			Path:AdminRootPath+"/files/add/class",
			Controller:      &adminApi.FileClass{},
			MappingMethods: "post:Add",
		},
		{
			Name:"修改文件分类",
			Path:AdminRootPath+"/files/edit/class",
			Controller:      &adminApi.FileClass{},
			MappingMethods: "post:Edit",
		},
		{
			Name:"获取文件分类列表",
			Path:AdminRootPath+"/files/list/class",
			Controller:      &adminApi.FileClass{},
			MappingMethods: "post:List",
		},
		{
			Name:"删除文件分类",
			Path:AdminRootPath+"/files/del/class",
			Controller:      &adminApi.FileClass{},
			MappingMethods: "post:Del",
		},
		{
			Name:"获取图片列表（分页）",
			Path:AdminRootPath+"/files/list/:page_size/:page",
			Controller:      &adminApi.Files{},
			MappingMethods: "post:PageList",
		},
		{
			Name:"删除图片",
			Path:AdminRootPath+"/files/del",
			Controller:      &adminApi.Files{},
			MappingMethods: "post:Del",
		},
		{
			Name:"获取角色列表",
			Path:AdminRootPath+"/role/list",
			Controller:      &adminApi.Role{},
			MappingMethods: "post:List",
		},
		{
			Name:"获取角色权限列表",
			Path:AdminRootPath+"/role/auth-list",
			Controller:      &adminApi.Role{},
			MappingMethods: "post:AuthList",
		},
		{
			Name:"删除角色",
			Path:AdminRootPath+"/role/del",
			Controller:      &adminApi.Role{},
			MappingMethods: "post:Del",
		},
		{
			Name:"修改角色",
			Path:AdminRootPath+"/role/edit",
			Controller:      &adminApi.Role{},
			MappingMethods: "post:Edit",
		},
		{
			Name:"添加角色",
			Path:AdminRootPath+"/role/add",
			Controller:      &adminApi.Role{},
			MappingMethods: "post:Add",
		},
		//后台api接口路由 ------end--------
	}
	return RouterList
}

