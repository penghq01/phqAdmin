package adminApi

import (
	"server/acc"
	"server/models"
)

type Auth struct {
	AdminBase
}

func (this *Auth) Prepare() {
	this.ActionModel = new(models.Auth)
	this.AdminBase.Prepare()
}

func (this *Auth) Add() {
	model := new(models.Auth)
	this.AnalyseJson(model)
	res := model.Add()
	if res.Err == nil {
		acc.RouterList[model.Id] = *model
		this.ServeSuccess(res.Msg, model)
	} else {
		this.ServeError(res.Msg, "")
	}
}

//删除
func (this *Auth) Del() {
	model := new(models.Auth)
	this.AnalyseJson(model)
	res := model.Delete()
	if res.Err == nil {
		delete(acc.RouterList, model.Id)
		this.ServeSuccess(res.Msg, "")
	}
	this.ServeError(res.Msg, "")
}

//修改
func (this *Auth) Edit() {
	model := new(models.Auth)
	this.AnalyseJson(model)
	res := model.Edit()
	if res.Err == nil {
		acc.RouterList[model.Id] = *model
		this.ServeSuccess(res.Msg, model)
	}
	this.ServeError(res.Msg, "")
}
