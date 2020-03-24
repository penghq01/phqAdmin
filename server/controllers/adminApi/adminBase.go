package adminApi

import (
	"server/acc"
	"server/common"
	"server/controllers"
	"server/models"
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

	this.CheckAuthToken() //根据Token判断是否登录

	//判断是否有权限访问数据接口
	if this.isUserLogin {
		this.CheckDateApiAuth(acc.GetLoginAdminDataApi(this.LoginUser))
	} else {
		this.CheckDateApiAuth(acc.GetNoLoginAdminDataApi())
	}
}

//判断是否有权限访问数据接口
func (this *AdminBase) CheckDateApiAuth(dataApi map[string]string) {
	_, ok := dataApi[this.Uri]
	if !ok {
		_, ok = dataApi[this.UriReplacePage(this.Uri)]
		if !ok {
			if this.isUserLogin{
				this.ServeNOAUTH("您没有权限访问该数据接口 [ "+this.Uri+" ]", "")
			}else{
				this.ServeRELOGIN("您还没有登录或者登录状态已过期，请登录后访问", "")
			}
		}
	}
}

//根据Token判断是否登录
func (this *AdminBase) CheckAuthToken() {
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
