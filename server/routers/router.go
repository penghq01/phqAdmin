package routers

import (
	"phqAdmin/server/controllers/adminApi"
	"github.com/astaxie/beego"
)

func init() {

	//后台api接口路由 ------start--------
	var AdminRootPath string="/admin-api"

    beego.Router(AdminRootPath+"/login", &adminApi.Login{},"post:Login")

	beego.Router(AdminRootPath+"/admin/list", &adminApi.Admin{},"post:List")
	beego.Router(AdminRootPath+"/admin/add", &adminApi.Admin{},"post:Add")
	beego.Router(AdminRootPath+"/admin/del", &adminApi.Admin{},"post:Del")
	beego.Router(AdminRootPath+"/admin/edit", &adminApi.Admin{},"post:Edit")

	beego.Router(AdminRootPath+"/admin/info", &adminApi.Admin{},"post:Info")
	beego.Router(AdminRootPath+"/admin/edit/pass", &adminApi.Admin{},"post:EditPass")

	beego.Router(AdminRootPath+"/icon/list/:pageszie/:page", &adminApi.Icon{},"post:List")
	beego.Router(AdminRootPath+"/icon/add", &adminApi.Icon{},"post:Add")
	beego.Router(AdminRootPath+"/icon/del", &adminApi.Icon{},"post:Del")

	beego.Router(AdminRootPath+"/user/list/:pageszie/:page", &adminApi.User{},"post:List")
	beego.Router(AdminRootPath+"/user/total/money-points", &adminApi.User{},"post:TotalMoneyPoints")
	beego.Router(AdminRootPath+"/user/pay/log/:pageszie/:page", &adminApi.User{},"post:PayLog")

	beego.Router(AdminRootPath+"/auth/list", &adminApi.Auth{},"post:List")
	beego.Router(AdminRootPath+"/auth/add", &adminApi.Auth{},"post:Add")
	beego.Router(AdminRootPath+"/auth/edit", &adminApi.Auth{},"post:Edit")
	beego.Router(AdminRootPath+"/auth/del", &adminApi.Auth{},"post:Del")
	//----------end------------

}