package acc

import (
	"server/common"
	"server/models"
)

var (
	RoleList    map[int]models.Role //角色列表
	RouterList  map[int]models.Auth //前端菜单路由列表
	DateAPIList map[int]models.Api  //数据接口列表
)

func IntiAuth() {
	InitRoleList()
	InitRouteList()
	InitDateApi()
}

//初始化角色列表
func InitRoleList() {
	RoleList = make(map[int]models.Role)
	list := make([]models.Role, 0)
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
	RouterList = make(map[int]models.Auth)
	model := models.Auth{}
	list, err := model.GetList()
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
	DateAPIList = make(map[int]models.Api)
	list := make([]models.Api, 0)
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
func GetLoginAdminRoute(admin *models.Admin) []models.Auth {
	auth := make([]models.Auth, 0)
	if admin.AdminId == 1 {
		for _, a := range RouterList {
			auth = append(auth, a)
		}
	} else {
		list := make(map[int]models.Auth)
		for _, a := range admin.Role {
			for _, r := range RoleList[a].AuthList {
				list[r] = RouterList[r]
			}
		}
		for _, a := range RouterList {
			if a.Visit < 2 {
				auth = append(auth, a)
			}
		}
		for _, a := range list {
			if a.Visit < 3 {
				auth = append(auth, a)
			}
		}
	}
	for i := 0; i < len(auth); i++ {
		for y := i; y < len(auth); y++ {
			if auth[i].Sort > auth[y].Sort {
				auth[i], auth[y] = auth[y], auth[i]
			}
		}
	}
	return auth
}

//获取当前登录管理员可访问的数据接口
func GetLoginAdminDataApi(admin *models.Admin) map[string]string {
	dataApiMap := make(map[string]string)
	if admin.AdminId == 1 {
		for _, d := range DateAPIList {
			dataApiMap[d.Router] = d.Name
		}
	} else {
		for _, d := range DateAPIList {
			if d.Visit == 1 {
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

//获取不需要登录即可访问的数据接口(控制前端显示)
func GetNoLoginAdminDataApi() map[string]string {
	dataApiMap := make(map[string]string)
	for _, d := range DateAPIList {
		if d.Visit ==0 {
			dataApiMap[d.Router] = d.Name
		}
	}
	return dataApiMap
}

//获取当前登录管理员可访问的数据接口(控制前端显示)
func GetLoginAdminUIDataApi(admin *models.Admin) map[string]string {
	dataApiMap := make(map[string]string)
	if admin.AdminId == 1 {
		for _, d := range DateAPIList {
			dataApiMap[d.Name] = d.Router
		}
	} else {
		for _, d := range DateAPIList {
			if d.Visit < 2 {
				dataApiMap[d.Name] = d.Router
			}
		}
		for _, a := range admin.Role {
			for _, r := range RoleList[a].AuthData {
				dataApiMap[DateAPIList[r].Name] = DateAPIList[r].Router
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
