package Auth

import (
	"encoding/json"
	"errors"
	"fmt"
	"server/common"
	"server/models"
	"strings"
)

type RoleAuth struct {
	AuthId int  `json:"auth_id"`
	Add    bool `json:"add"`
	Delete bool `json:"delete"`
	Edit   bool `json:"edit"`
	Select bool `json:"select"`
}
type AuthInfo struct {
	Add    AuthCRUNInfo `json:"add"`
	Delete AuthCRUNInfo `json:"delete"`
	Edit   AuthCRUNInfo `json:"edit"`
	Select AuthCRUNInfo `json:"select"`
}
type AuthCRUNInfo struct {
	Show      bool     `json:"show"`
	Router    []string `json:"router"`
	RouterMap map[string]bool
}

//获取管理后台路由列表
func FindRouter() map[int]models.Auth {
	Router := make(map[int]models.Auth, 0)
	rt := make([]models.Auth, 0)
	err := common.DbEngine.Where("visit in(0,1,2)").Find(&rt)
	if err != nil {
		panic("加载路由信息错误：" + err.Error())
	}
	for _, r := range rt {
		Router[r.Id] = r
	}
	return Router
}

//获取管理后台角色列表
func FindRole(roleIdStr string) map[string]models.Role {
	Role := make(map[string]models.Role, 0)
	re := make([]models.Role, 0)
	err := common.DbEngine.Where(fmt.Sprintf("id in(%v)", roleIdStr)).Find(&re)
	if err != nil {
		panic("加载角色信息错误：" + err.Error())
	}
	for _, r := range re {
		Role[fmt.Sprintf("%v", r.Id)] = r
	}
	return Role
}

//不用登录即可访问的路由
func GetAdminNoLoginController() (map[string]bool, bool) {
	AdminNoLoginController := make(map[string]bool) //不用登录即可访问的路由
	rt := make([]models.Auth, 0)
	err := common.DbEngine.Where("visit=0").Find(&rt)
	if err != nil {
		common.Logs.Error("加载路由信息错误：%v",err)
		return AdminNoLoginController, false
	}
	for _, r := range rt {
		auth := AuthInfo{}
		fmt.Println(r.Auth)
		err = json.Unmarshal(common.Str2Bytes(r.Auth), &auth)
		if err != nil {
			common.Logs.Error("解析不用登录的路由数据错误：%v",err)
			return AdminNoLoginController, false
		}
		for _, q := range auth.Add.Router {
			AdminNoLoginController[q] = true
		}
		for _, q := range auth.Delete.Router {
			AdminNoLoginController[q] = true
		}
		for _, q := range auth.Edit.Router {
			AdminNoLoginController[q] = true
		}
		for _, q := range auth.Select.Router {
			AdminNoLoginController[q] = true
		}
	}
	return AdminNoLoginController, true
}

//登录即可访问的路由
func GetAdminLoginController() (map[string]bool, bool) {
	AdminLoginController := make(map[string]bool) //登录即可访问的路由
	rt := make([]models.Auth, 0)
	err := common.DbEngine.Where("visit=1").Find(&rt)
	if err != nil {
		common.Logs.Error("加载路由信息错误：%v",err)
		return AdminLoginController, false
	}
	for _, r := range rt {
		auth := AuthInfo{}
		err = json.Unmarshal(common.Str2Bytes(r.Auth), &auth)
		if err != nil {
			common.Logs.Error("解析只需登录的路由数据错误：%v",err)
			return AdminLoginController, false
		}
		for _, q := range auth.Add.Router {
			AdminLoginController[q] = true
		}
		for _, q := range auth.Delete.Router {
			AdminLoginController[q] = true
		}
		for _, q := range auth.Edit.Router {
			AdminLoginController[q] = true
		}
		for _, q := range auth.Select.Router {
			AdminLoginController[q] = true
		}
	}
	return AdminLoginController, true
}

//登录即可访问的Router
func GetAdminLoginRouter() ([]models.Auth, bool) {
	Router := make([]models.Auth, 0)
	err := common.DbEngine.Where("visit=1").Find(&Router)
	if err != nil {
		fmt.Println("加载路由信息错误：" + err.Error())
		return Router, false
	}
	return Router, true
}

//获取前端菜单列表
func GetRouterList(roleIdStr string) ([]map[string]interface{}, bool, error) {
	roleIdArr := strings.Split(roleIdStr, ",")
	routerList := make([]map[string]interface{}, 0)
	MaprouterList := make(map[int]map[string]interface{})
	AdminLoginRouter, ok := GetAdminLoginRouter()
	if !ok {
		return routerList, false, errors.New("权限验证失败")
	}
	for _, r := range AdminLoginRouter {
		if r.AuthType == 0 && r.IsShow == 1 {
			tem := make(map[string]interface{})
			tem["id"] = r.Id
			tem["title"] = r.Title
			tem["pid"] = r.Pid
			tem["icon"] = r.Icon
			tem["crouter"] = r.Crouter
			tem["visit"] = r.Visit
			tem["auth_type"] = r.AuthType
			tem["is_show"] = r.IsShow
			tem["sort"] = r.Sort
			tem["auth"] = map[string]bool{
				"add":    true,
				"edit":   true,
				"delete": true,
				"select": true,
			}
			MaprouterList[r.Id] = tem
		}
	}
	Role := FindRole(roleIdStr)
	Router := FindRouter()
	for _, roleId := range roleIdArr {
		listStr := Role[roleId].AuthList
		if listStr != "" {
			roleList := make([]RoleAuth, 0)
			if err := json.Unmarshal(common.Str2Bytes(listStr), &roleList); err != nil {
				return routerList, false, errors.New("权限验证错误：" + err.Error())
			}
			for _, roleAuth := range roleList {
				route := Router[roleAuth.AuthId]
				if route.AuthType == 0 && route.IsShow == 1 {
					tem := make(map[string]interface{})
					tem["id"] = route.Id
					tem["title"] = route.Title
					tem["pid"] = route.Pid
					tem["icon"] = route.Icon
					tem["crouter"] = route.Crouter
					tem["visit"] = route.Visit
					tem["auth_type"] = route.AuthType
					tem["is_show"] = route.IsShow
					tem["sort"] = route.Sort
					if route.Auth != "" {
						auth := AuthInfo{}
						if err := json.Unmarshal(common.Str2Bytes(route.Auth), &auth); err != nil {
							return routerList, false, errors.New("权限验证错误：" + err.Error())
						}
						temA, ok := MaprouterList[route.Id]
						if ok {
							temAuth := temA["auth"].(map[string]bool)
							tem["auth"] = map[string]bool{
								"add":    roleAuth.Add || temAuth["add"],
								"edit":   roleAuth.Edit || temAuth["edit"],
								"delete": roleAuth.Delete || temAuth["delete"],
								"select": roleAuth.Select || temAuth["select"],
							}
						} else {
							tem["auth"] = map[string]bool{
								"add":    roleAuth.Add,
								"edit":   roleAuth.Edit,
								"delete": roleAuth.Delete,
								"select": roleAuth.Select,
							}
						}

					}
					MaprouterList[route.Id] = tem
				}
			}
		}
	}
	for _, router := range MaprouterList {
		routerList = append(routerList, router)
	}
	listLen := len(routerList)
	for index := 0; index < listLen; index++ {
		for key := index + 1; key < listLen; key++ {
			if routerList[index]["sort"].(int) > routerList[key]["sort"].(int) {
				routerList[index], routerList[key] = routerList[key], routerList[index]
			}
		}
	}
	return routerList, true, nil
}

//获取验证权限路由列表
func GetRouterPathList(roleIdStr string) (map[string]bool, bool, error) {
	pathList := make(map[string]bool)
	roleIdArr := strings.Split(roleIdStr, ",")
	Role := FindRole(roleIdStr)
	Router := FindRouter()
	for _, roleId := range roleIdArr {
		listStr := Role[roleId].AuthList
		if listStr != "" {
			roleList := make([]RoleAuth, 0)
			if err := json.Unmarshal(common.Str2Bytes(listStr), &roleList); err != nil {
				return pathList, false, errors.New("权限验证错误：" + err.Error())
			}
			for _, roleAuth := range roleList {
				route := Router[roleAuth.AuthId]
				if route.Auth != "" {
					auth := AuthInfo{}
					if err := json.Unmarshal(common.Str2Bytes(route.Auth), &auth); err != nil {
						return pathList, false, errors.New("权限验证错误：" + err.Error())
					}
					if roleAuth.Add {
						for _, path := range auth.Add.Router {
							pathList[path] = true
						}
					}
					if roleAuth.Edit {
						for _, path := range auth.Edit.Router {
							pathList[path] = true
						}
					}
					if roleAuth.Select {
						for _, path := range auth.Select.Router {
							pathList[path] = true
						}
					}
					if roleAuth.Delete {
						for _, path := range auth.Delete.Router {
							pathList[path] = true
						}
					}
				}
			}
		}
	}
	return pathList, true, nil
}
