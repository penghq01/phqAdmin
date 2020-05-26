package auth

import (
	"server/src/app/models/mDefault"
	"server/src/common"
)

var (
	RoleList    map[int]mDefault.Role //角色列表
	RouterList  map[int]mDefault.Auth //前端菜单路由列表
	DateAPIList map[int]mDefault.Api  //数据接口列表
)

func IntiAuth() {
	InitRoleList()
	InitRouteList()
	InitDateApi()
}

//初始化角色列表
func InitRoleList() {
	RoleList = make(map[int]mDefault.Role)
	list := make([]mDefault.Role, 0)
	err := common.DbEngine.Find(&list)
	if err == nil {
		for _, r := range list {
			RoleList[r.Id] = r
		}
	} else {
		common.Logs.Error("初始化前端菜单路由列表失败：%v", err)
	}
}

//初始化前端菜单路由列表
func InitRouteList() {
	RouterList = make(map[int]mDefault.Auth)
	list := make([]mDefault.Auth, 0)
	db := common.DbEngine.Asc("sort").Asc("id")
	err := db.Find(&list)
	if err == nil {
		for _, auth := range list {
			RouterList[auth.Id] = auth
		}
	} else {
		common.Logs.Error("初始化前端菜单路由列表失败：%v", err)
	}
}

//初始化数据接口
func InitDateApi() {
	DateAPIList = make(map[int]mDefault.Api)
	list := make([]mDefault.Api, 0)
	err := common.DbEngine.Find(&list)
	if err == nil {
		for _, d := range list {
			DateAPIList[d.Id] = d
		}
	} else {
		common.Logs.Error("初始化数据接口列表失败：%v", err)
	}
}

//获取当前登录管理员的前端菜单
func GetLoginAdminRoute(admin *mDefault.Admin) []mDefault.Auth {
	auth := make([]mDefault.Auth, 0)
	if admin.AdminId == 1 {
		for _, a := range RouterList {
			auth = append(auth, a)
		}
	} else {
		//登录可访问，和公开的
		for _, a := range RouterList {
			if a.Visit < 2 {
				auth = append(auth, a)
			}
		}
		//指定权限
		for _, a := range admin.Role {
			for _, rid := range RoleList[a].AuthList {
				//list[rid] = RouterList[rid]
				r := RouterList[rid]
				if r.Visit < 3 {
					auth = append(auth, r)
				}
			}
		}
	}
	//排序
	for i := 0; i < len(auth); i++ {
		for y := i; y < len(auth); y++ {
			if auth[i].Sort > auth[y].Sort {
				auth[i], auth[y] = auth[y], auth[i]
			}
		}
	}
	return auth
}

//获取公开的前端菜单
func GetNoLoginAdminRoute() []mDefault.Auth {
	auth := make([]mDefault.Auth, 0)
	for _, a := range RouterList {
		if a.Visit == 0 {
			auth = append(auth, a)
		}
	}
	return auth
}

//获取当前登录管理员可访问的数据接口
func GetLoginAdminDataApi(admin *mDefault.Admin) map[string]string {
	dataApiMap := make(map[string]string)
	if admin.AdminId == 1 {
		for _, d := range DateAPIList {
			dataApiMap[d.Router] = d.Name
		}
	} else {
		for _, d := range DateAPIList {
			if d.Visit < 2 {
				dataApiMap[d.Router] = d.Name
			}
		}
		for _, a := range admin.Role {
			for _, r := range RoleList[a].AuthData {
				dataApiMap[DateAPIList[r].Router] = DateAPIList[r].Name
			}
		}
	}
	return dataApiMap
}

//获取不需要登录即可访问的数据接口
func GetNoLoginAdminDataApi() map[string]string {
	dataApiMap := make(map[string]string)
	for _, d := range DateAPIList {
		if d.Visit == 0 {
			dataApiMap[d.Router] = d.Name
		}
	}
	return dataApiMap
}

//获取当前登录管理员可访问的数据接口（控制UI显示隐藏）
func GetLoginAdminUIDataApi(admin *mDefault.Admin) map[string]bool {
	dataApiMap := make(map[string]bool)
	if admin.AdminId == 1 {
		for _, d := range DateAPIList {
			dataApiMap[d.Name] = true
		}
	} else {
		for _, d := range DateAPIList {
			if d.Visit < 2 {
				dataApiMap[d.Name] = true
			}
		}
		for _, a := range admin.Role {
			for _, r := range RoleList[a].AuthData {
				dataApiMap[DateAPIList[r].Name] = true
			}
		}
	}
	return dataApiMap
}

//获取不需要签名的数据接口
func GetNoSignDataApi() map[string]string {
	dataApiMap := make(map[string]string)
	for _, d := range DateAPIList {
		if d.Sign == 0 {
			dataApiMap[d.Router] = d.Name
		}
	}
	return dataApiMap
}

//通过URI获取数据接口名称
func UriGetDateAPIName(uri string) string {
	name := ""
	for _, v := range DateAPIList {
		if v.Router == uri {
			name = v.Title
			break
		}
	}
	return name
}
