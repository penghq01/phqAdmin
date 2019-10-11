package Auth

import (
	"encoding/json"
	"fmt"
	"phqAdmin/server/common"
	"phqAdmin/server/models"
)

var(
	AdminNoLoginController  map[string]bool //不用登录即可访问的路由
	AdminLoginController  map[string]bool //登录即可访问的路由
	Router map[int]models.Auth //管理后台路由列表
	Role   map[int]models.Role //管理后台角色列表
)

type AuthInfo struct {
    Add AuthCRUNInfo `json:"add"`
	Delete AuthCRUNInfo `json:"delete"`
	Edit AuthCRUNInfo `json:"edit"`
	Select AuthCRUNInfo `json:"select"`
}
type AuthCRUNInfo struct {
	Show bool `json:"show"`
	Router []string `json:"router"`
}

func InitData() {
	AdminNoLoginController=make(map[string]bool,0) //不用登录即可访问的路由
	AdminLoginController=make(map[string]bool,0) //登录即可访问的路由
	Router = make(map[int]models.Auth, 0)
	Role = make(map[int]models.Role, 0)
	rt:=make([]models.Auth,0)
	re:=make([]models.Role,0)
	err:=common.DbEngine.Find(&rt)
	if err!=nil{
		panic("加载路由信息错误："+err.Error())
	}
	err=common.DbEngine.Find(&re)
	if err!=nil{
		panic("加载角色信息错误："+err.Error())
	}
	for _,r:=range rt{
		Router[r.Id]=r
		if r.Visit==0{
			auth:=AuthInfo{}
            err=json.Unmarshal(common.Str2Bytes(r.Auth),&auth)
            if err!=nil{
				fmt.Println(r.Auth)
				panic("解析不用登录的路由数据错误："+err.Error())
			}
            if len(auth.Add.Router)>0{
				for _,q:=range auth.Add.Router {
					AdminNoLoginController[q]=true
				}
			}
			if len(auth.Delete.Router)>0{
				for _,q:=range auth.Delete.Router {
					AdminNoLoginController[q]=true
				}
			}
			if len(auth.Edit.Router)>0{
				for _,q:=range auth.Edit.Router {
					AdminNoLoginController[q]=true
				}
			}
			if len(auth.Select.Router)>0{
				for _,q:=range auth.Select.Router {
					AdminNoLoginController[q]=true
				}
			}
		}
		if r.Visit==1{
			auth:=AuthInfo{}
			err=json.Unmarshal(common.Str2Bytes(r.Auth),&auth)
			if err!=nil{
				panic("解析只需登录的路由数据错误："+err.Error())
			}
			if len(auth.Add.Router)>0{
				for _,q:=range auth.Add.Router {
					AdminLoginController[q]=true
				}
			}
			if len(auth.Delete.Router)>0{
				for _,q:=range auth.Delete.Router {
					AdminLoginController[q]=true
				}
			}
			if len(auth.Edit.Router)>0{
				for _,q:=range auth.Edit.Router {
					AdminLoginController[q]=true
				}
			}
			if len(auth.Select.Router)>0{
				for _,q:=range auth.Select.Router {
					AdminLoginController[q]=true
				}
			}
		}
	}
	for _,r:=range re{
		Role[r.Id]=r
	}
}