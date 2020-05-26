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
	res := model.Add()
	if res.Err == nil {
		auth.DateAPIList[model.Id] = *model
		this.ServeSuccess(res.Msg, model)
	} else {
		this.ServeError(res.Msg, "")
	}
}

//删除
func (this *Api) Del() {
	model := new(mDefault.Api)
	this.AnalyseJson(model)
	res := model.Delete()
	if res.Err == nil {
		delete(auth.DateAPIList, model.Id)
		this.ServeSuccess(res.Msg, "")
	}
	this.ServeError(res.Msg, "")
}

//修改
func (this *Api) Edit() {
	model := new(mDefault.Api)
	this.AnalyseJson(model)
	res := model.Edit()
	if res.Err == nil {
		auth.DateAPIList[model.Id] = *model
		this.ServeSuccess(res.Msg, model)
	}
	this.ServeError(res.Msg, "")
}
