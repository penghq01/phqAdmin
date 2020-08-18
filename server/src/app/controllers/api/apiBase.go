package api

import (
	"server/src/app/controllers"
	"server/src/app/models"
	"server/src/common"
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
	err := this.ActionModel.Add()
	if err == nil {
		this.ServeSuccess("添加成功", this.ActionModel)
	} else {
		this.ServeError("添加失败，"+err.Error(), "")
	}
}

//删除
func (this *ApiBase) Del() {
	this.AnalyseJson(this.ActionModel)
	err := this.ActionModel.Delete()
	if err == nil {
		this.ServeSuccess("删除成功", "")
	} else {
		this.ServeError("删除失败，"+err.Error(), "")
	}
}

//修改
func (this *ApiBase) Edit() {
	this.AnalyseJson(this.ActionModel)
	err := this.ActionModel.Edit()
	if err == nil {
		this.ServeSuccess("修改成功", this.ActionModel)
	} else {
		this.ServeError("修改失败，"+err.Error(), "")
	}

}

//获取单条
func (this *ApiBase) Get() {
	this.AnalyseJson(this.ActionModel)
	err := this.ActionModel.Get()
	if err == nil {
		this.ServeSuccess("获取数据成功", this.ActionModel)
	} else {
		this.ServeError("获取数据失败，"+err.Error(), "")
	}
}

//获取列表
func (this *ApiBase) List() {
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
func (this *ApiBase) PageList() {
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
