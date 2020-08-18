package adminApi

import (
	"server/src/app/controllers"
	"server/src/app/models"
	"server/src/app/models/mDefault"
	"server/src/auth"
	"server/src/common"
	"server/src/global"
)

type AdminBase struct {
	controllers.Base
	isUserLogin bool            //用户是否登录
	LoginUser   *mDefault.Admin //当前登录用户
	ActionModel models.IModels  //当前访问的控制所操作模型
}

//初始化
func (this *AdminBase) Prepare() {
	this.Base.Prepare()

	this.CheckAuthToken() //根据Token判断是否登录

	//判断是否有权限访问数据接口
	if this.isUserLogin {
		this.CheckDateApiAuth(auth.GetLoginAdminDataApi(this.LoginUser))
	} else {
		this.CheckDateApiAuth(auth.GetNoLoginAdminDataApi())
	}
}

//判断是否有权限访问数据接口
func (this *AdminBase) CheckDateApiAuth(dataApi map[string]string) {
	_, ok := dataApi[this.Uri]
	if !ok {
		NewUri := this.UriReplacePage(this.Uri)
		_, ok = dataApi[NewUri]
		if !ok {
			UriName := auth.UriGetDateAPIName(this.Uri)
			if UriName == "" {
				UriName = auth.UriGetDateAPIName(NewUri)
			}
			if this.isUserLogin {
				this.ServeNOAUTH("您没有权限访问该数据接口 [ "+UriName+" ]=>[ "+this.Uri+" ]", "")
			} else {
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
			user, ok := global.LoginAdminMap[id]
			if !ok {
				user = mDefault.Admin{}
				ok = user.IdUserNameGet(id, username)
				if !ok {
					this.isUserLogin = false
				}
				global.LoginAdminMap[user.AdminId] = user
			}
			this.isUserLogin = true
			this.LoginUser = &user
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
	err := this.ActionModel.Add()
	if err == nil {
		this.ServeSuccess("添加成功", this.ActionModel)
	} else {
		this.ServeError("添加失败，"+err.Error(), "")
	}
}

//删除
func (this *AdminBase) Del() {
	this.AnalyseJson(this.ActionModel)
	err := this.ActionModel.Delete()
	if err == nil {
		this.ServeSuccess("删除成功", "")
	} else {
		this.ServeError("删除失败，"+err.Error(), "")
	}
}

//修改
func (this *AdminBase) Edit() {
	this.AnalyseJson(this.ActionModel)
	err := this.ActionModel.Edit()
	if err == nil {
		this.ServeSuccess("修改成功", this.ActionModel)
	} else {
		this.ServeError("修改失败，"+err.Error(), "")
	}

}

//获取单条
func (this *AdminBase) Get() {
	this.AnalyseJson(this.ActionModel)
	err := this.ActionModel.Get()
	if err == nil {
		this.ServeSuccess("获取数据成功", this.ActionModel)
	} else {
		this.ServeError("获取数据失败，"+err.Error(), "")
	}
}

//获取列表
func (this *AdminBase) List() {
	this.AnalyseJson(this.ActionModel)
	var list interface{}
	err := this.ActionModel.List(&list)
	if err == nil {
		this.ServeSuccess("", list)
	} else {
		this.ServeError("获取数据失败，"+err.Error(), "")
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
	err := this.ActionModel.PageList(&pd)
	if err == nil {
		this.ServeSuccess("", pd)
	} else {
		this.ServeError("获取数据失败，"+err.Error(), "")
	}
}
