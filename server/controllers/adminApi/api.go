package adminApi

import (
	"server/acc"
	"server/models"
)

type Api struct {
	AdminBase
}

func (this *Api) Prepare() {
	this.ActionModel = new(models.Api)
	this.AdminBase.Prepare()
}

func (this *Api) Add() {
	model := new(models.Api)
	this.AnalyseJson(model)
	res := model.Add()
	if res.Err == nil {
		acc.DateAPIList[model.Id] = *model
		this.ServeSuccess(res.Msg, model)
	} else {
		this.ServeError(res.Msg, "")
	}
}

//删除
func (this *Api) Del() {
	model := new(models.Api)
	this.AnalyseJson(model)
	res := model.Delete()
	if res.Err == nil {
		delete(acc.DateAPIList, model.Id)
		this.ServeSuccess(res.Msg, "")
	}
	this.ServeError(res.Msg, "")
}

//修改
func (this *Api) Edit() {
	model := new(models.Api)
	this.AnalyseJson(model)
	res := model.Edit()
	if res.Err == nil {
		acc.DateAPIList[model.Id] = *model
		this.ServeSuccess(res.Msg, model)
	}
	this.ServeError(res.Msg, "")
}
