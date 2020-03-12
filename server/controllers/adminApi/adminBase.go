package adminApi

import (
	"server/common"
	Auth2 "server/common/Auth"
	"server/controllers"
	"server/models"
	"strings"
)

type AdminBase struct {
	controllers.Base
	isUserLogin bool           //用户是否登录
	LoginUser   *models.Admin  //当前登录用户
	ActionModel models.IModels //当前访问的控制所操作模型
}

//初始化
func (this *AdminBase) Prepare() {
	this.Base.Prepare()
	this.CheckAuth() //判断是否有权限访问
}

func (this *AdminBase) CheckAuth() {
	if this.AuthToken == "" {
		this.isUserLogin = false
	} else {
		ok, _ := common.CheckToken(this.AuthToken, func(id int, username string) {
			user := new(models.Admin)
			ok := user.IdUserNameGet(id, username)
			if !ok {
				this.isUserLogin = false
			}
			this.isUserLogin = true
			this.LoginUser = user
		})
		if !ok {
			this.isUserLogin = false
		}
	}
	AdminNoLoginController, ok := Auth2.GetAdminNoLoginController()
	if !ok {
		this.ServeLOGIN("获取菜单列表失败，请重新登录", "")
	}
	if !AdminNoLoginController[this.Uri] {
		if !this.isUserLogin {
			this.ServeLOGIN("您没有登录或登录已经过期，请登录后访问", "")
		}
		AdminLoginController, ok := Auth2.GetAdminLoginController()
		if !ok {
			this.ServeLOGIN("登录验证失败，请重新登录", "")
		}
		if !AdminLoginController[this.Uri] {
			if this.LoginUser.AdminId != 1 {
				pathList, ok, err := Auth2.GetRouterPathList(this.LoginUser.Role)
				if !ok || err != nil {
					this.ServeNOAUTH(err.Error(), "")
				}
				if !pathList[this.Uri] {
					arr := strings.Split(this.Uri, "/")
					arrLen := len(arr)
					arr[arrLen-2] = ":page_size"
					arr[arrLen-1] = ":page"
					uri := strings.Join(arr, "/")
					if !pathList[uri] {
						this.ServeNOAUTH("您没有权限，请与联系管理员，错误："+this.Uri, "")
					}
				}
			}
		}
	}
}

//获取用户权限，和菜单
func (this *AdminBase) GetUserAuthMenu() (bool, []map[string]interface{}) {
	if this.LoginUser.AdminId == 1 {
		resData := make([]map[string]interface{}, 0)
		auth := make([]models.Auth, 0)
		err := common.DbEngine.Asc("sort").Find(&auth)
		if err != nil {
			return false, resData
		}
		for _, r := range auth {
			tem := make(map[string]interface{})
			tem["id"] = r.Id
			tem["title"] = r.Title
			tem["pid"] = r.Pid
			tem["icon"] = r.Icon
			tem["crouter"] = r.Crouter
			tem["visit"] = r.Visit
			tem["auth_type"] = r.AuthType
			tem["is_show"] = r.IsShow
			tem["auth"] = map[string]bool{
				"add":    true,
				"edit":   true,
				"delete": true,
				"select": true,
			}
			resData = append(resData, tem)
		}
		return true, resData
	} else {
		RouterList, ok, err := Auth2.GetRouterList(this.LoginUser.Role)
		if !ok || err != nil {
			return false, RouterList
		}
		return true, RouterList
	}
}

//上传图片
func (this *AdminBase) UploadImage() {
	this.UploadImg("upload_img")
}

//添加操作
func (this *AdminBase) Add() {
	this.AnalyseJson(this.ActionModel)
	res := this.ActionModel.Add()
	if res.Err == nil {
		this.ServeSuccess(res.Msg, this.ActionModel)
	} else {
		this.ServeError(res.Msg, "")
	}
}

//获取单条
func (this *AdminBase) Get() {
	this.AnalyseJson(this.ActionModel)
	res := this.ActionModel.Get()
	if res.Err == nil {
		this.ServeSuccess(res.Msg, this.ActionModel)
	} else {
		this.ServeError(res.Msg, "")
	}
}

//获取列表
func (this *AdminBase) List() {
	this.AnalyseJson(this.ActionModel)
	list, res := this.ActionModel.List()
	if res.Err == nil {
		this.ServeSuccess(res.Msg, list)
	} else {
		this.ServeError(res.Msg, "")
	}
}

//获取带分页的列表
func (this *AdminBase) PageList() {
	this.AnalyseJson(this.ActionModel)
	this.GetPageParam()
	pd := common.PaginateData{
		Data:     nil,
		Paginate: this.Paginate,
	}
	res := this.ActionModel.PageList(&pd)
	if res.Err == nil {
		this.ServeSuccess("", pd)
	} else {
		this.ServeError(res.Msg, "")
	}
}

//删除
func (this *AdminBase) Del() {
	this.AnalyseJson(this.ActionModel)
	res := this.ActionModel.Delete()
	if res.Err == nil {
		this.ServeSuccess(res.Msg, "")
	}
	this.ServeError(res.Msg, "")
}

//修改
func (this *AdminBase) Edit() {
	this.AnalyseJson(this.ActionModel)
	res := this.ActionModel.Edit()
	if res.Err == nil {
		this.ServeSuccess(res.Msg, this.ActionModel)
	}
	this.ServeError(res.Msg, "")
}
