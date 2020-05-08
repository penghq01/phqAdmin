package routers

import (
	"fmt"
	"github.com/astaxie/beego"
	"updateServer/controllers"
)

type RouterInfo struct {
	Name           string
	Path           string
	Controller     beego.ControllerInterface
	MappingMethods string
}

func InitRoute() {
	//✖ ▶ ✔
	//注册前端api路由
	for _, router := range GetApiRouterList() {
		beego.Router(router.Path, router.Controller, router.MappingMethods)
	}
	fmt.Println("▶ 路由注册完成")
}

//获取前端APi接口路由
func GetApiRouterList() []RouterInfo {
	var ApiRootPath string = "/update/api" //api接口路由root
	RouterList := []RouterInfo{
		//api接口路由 ------start--------
		RouterInfo{
			Name:"登录",
			Path:ApiRootPath+"/login",
			Controller:&controllers.Login{},
			MappingMethods:"post:Login",
		},
		RouterInfo{
			Name:"获取文件列表",
			Path:ApiRootPath+"/file/dir",
			Controller:&controllers.Update{},
			MappingMethods:"post:Dir",
		},
		RouterInfo{
			Name:"获取文件列表",
			Path:ApiRootPath+"/file/list",
			Controller:&controllers.Update{},
			MappingMethods:"post:List",
		},
		RouterInfo{
			Name:"上传文件",
			Path:ApiRootPath+"/file/upload",
			Controller:&controllers.Update{},
			MappingMethods:"post:Upload",
		},
		RouterInfo{
			Name:"删除文件",
			Path:ApiRootPath+"/file/del",
			Controller:&controllers.Update{},
			MappingMethods:"post:Del",
		},
		RouterInfo{
			Name:"下载文件",
			Path:ApiRootPath+"/file/download",
			Controller:&controllers.Update{},
			MappingMethods:"post:Download",
		},
		RouterInfo{
			Name:"解压文件",
			Path:ApiRootPath+"/file/decompress",
			Controller:&controllers.Update{},
			MappingMethods:"post:DeCompress",
		},
		RouterInfo{
			Name:"执行文件",
			Path:ApiRootPath+"/file/run",
			Controller:&controllers.Update{},
			MappingMethods:"post:Run",
		},
		//api接口路由 ------end--------
	}
	return RouterList
}
