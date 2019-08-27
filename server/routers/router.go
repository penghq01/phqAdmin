package routers

import (
	"github.com/astaxie/beego"
	"phqAdmin/server/controllers/adminApi"
)

func init() {

	//后台api接口路由 ------start--------

	var AdminRootPath string = "/admin-api"

	beego.Router(AdminRootPath+"/login", &adminApi.Login{}, "post:Login")

	beego.Router(AdminRootPath+"/admin/list", &adminApi.Admin{}, "post:List")
	beego.Router(AdminRootPath+"/admin/add", &adminApi.Admin{}, "post:Add")
	beego.Router(AdminRootPath+"/admin/del", &adminApi.Admin{}, "post:Del")
	beego.Router(AdminRootPath+"/admin/edit", &adminApi.Admin{}, "post:Edit")

	beego.Router(AdminRootPath+"/admin/info", &adminApi.Admin{}, "post:Info")
	beego.Router(AdminRootPath+"/admin/edit/pass", &adminApi.Admin{}, "post:EditPass")
	beego.Router(AdminRootPath+"/admin/auth", &adminApi.Admin{}, "post:AuthList")

	beego.Router(AdminRootPath+"/icon/list/:pageszie/:page", &adminApi.Icon{}, "post:PageList")
	beego.Router(AdminRootPath+"/icon/add", &adminApi.Icon{}, "post:Add")
	beego.Router(AdminRootPath+"/icon/del", &adminApi.Icon{}, "post:Del")


	beego.Router(AdminRootPath+"/user/list/:pageszie/:page", &adminApi.User{}, "post:List")
	beego.Router(AdminRootPath+"/user/total/money-points", &adminApi.User{}, "post:TotalMoneyPoints")
	beego.Router(AdminRootPath+"/user/pay/log/:pageszie/:page", &adminApi.User{}, "post:PayLog")


	beego.Router(AdminRootPath+"/auth/list", &adminApi.Auth{}, "post:List")
	beego.Router(AdminRootPath+"/auth/add", &adminApi.Auth{}, "post:Add")
	beego.Router(AdminRootPath+"/auth/edit", &adminApi.Auth{}, "post:Edit")
	beego.Router(AdminRootPath+"/auth/del", &adminApi.Auth{}, "post:Del")

	beego.Router(AdminRootPath+"/files/upload/img", &adminApi.FileClass{}, "post:UploadImage")
	beego.Router(AdminRootPath+"/files/add/class", &adminApi.FileClass{}, "post:Add")
	beego.Router(AdminRootPath+"/files/edit/class", &adminApi.FileClass{}, "post:Edit")
	beego.Router(AdminRootPath+"/files/list/class", &adminApi.FileClass{}, "post:List")
	beego.Router(AdminRootPath+"/files/del/class", &adminApi.FileClass{}, "post:Del")

	beego.Router(AdminRootPath+"/files/list/:pageszie/:page", &adminApi.Files{}, "post:PageList")
	beego.Router(AdminRootPath+"/files/del", &adminApi.Files{}, "post:Del")

	beego.Router(AdminRootPath+"/role/list", &adminApi.Role{}, "post:List")
	beego.Router(AdminRootPath+"/role/del", &adminApi.Role{}, "post:Del")
	beego.Router(AdminRootPath+"/role/edit", &adminApi.Role{}, "post:Edit")
	beego.Router(AdminRootPath+"/role/add", &adminApi.Role{}, "post:Add")



}
