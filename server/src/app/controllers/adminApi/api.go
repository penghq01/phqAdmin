package adminApi

import (
	"server/src/auth"
	"server/src/app/models/mDefault"
)

type Api struct {
	AdminBase
}

func (this *Api) Prepare() {
	this.ActionModel = new(mDefault.Api)
	this.AdminBase.Prepare()
}

func (this *Api) Add() {
	model := new(mDefault.Api)
	this.AnalyseJson(model)
	err := model.Add()
	if err == nil {
		auth.DateAPIList[model.Id] = *model
		this.ServeSuccess("添加成功", model)
	} else {
		this.ServeError("添加失败，"+err.Error(), "")
	}
}

//删除
func (this *Api) Del() {
	model := new(mDefault.Api)
	this.AnalyseJson(model)
	err := model.Delete()
	if err == nil {
		delete(auth.DateAPIList, model.Id)
		this.ServeSuccess("删除成功", "")
	}else{
		this.ServeError("删除失败，"+err.Error(), "")
	}

}

//修改
func (this *Api) Edit() {
	model := new(mDefault.Api)
	this.AnalyseJson(model)
	err := model.Edit()
	if err == nil {
		auth.DateAPIList[model.Id] = *model
		this.ServeSuccess("修改成功", model)
	}else{
		this.ServeError("修改失败，"+err.Error(), "")
	}
}
