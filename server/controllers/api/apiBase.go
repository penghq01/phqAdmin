package api

import (
	"server/common"
	"server/controllers"
	"server/models"
)

type ApiBase struct {
	controllers.Base
	ActionModel models.IModels //当前访问的控制所操作模型
}

//初始化
func (this *ApiBase) Prepare() {
	this.Base.Prepare()
}

//添加操作
func (this *ApiBase) Add() {
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
func (this *ApiBase) List() {
	this.AnalyseJson(this.ActionModel)
	list, res := this.ActionModel.List()
	if res.Err == nil {
		this.ServeSuccess(res.Msg, list)
	} else {
		this.ServeError(res.Msg, "")
	}
}

//获取带分页的列表
func (this *ApiBase) PageList() {
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
func (this *ApiBase) Del() {
	this.AnalyseJson(this.ActionModel)
	res := this.ActionModel.Delete()
	if res.Err == nil {
		this.ServeSuccess(res.Msg, "")
	}
	this.ServeError(res.Msg, "")
}

//修改
func (this *ApiBase) Edit() {
	this.AnalyseJson(this.ActionModel)
	res := this.ActionModel.Edit()
	if res.Err == nil {
		this.ServeSuccess(res.Msg, this.ActionModel)
	}
	this.ServeError(res.Msg, "")
}
