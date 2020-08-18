package adminApi

import (
	"server/src/app/models/mDefault"
	"server/src/auth"
)

type Auth struct {
	AdminBase
}

func (this *Auth) Prepare() {
	this.ActionModel = new(mDefault.Auth)
	this.AdminBase.Prepare()
}

func (this *Auth) Add() {
	model := new(mDefault.Auth)
	this.AnalyseJson(model)
	err := model.Add()
	if err == nil {
		auth.RouterList[model.Id] = *model
		this.ServeSuccess("添加成功", model)
	} else {
		this.ServeError("添加失败，"+err.Error(), "")
	}
}

//删除
func (this *Auth) Del() {
	model := new(mDefault.Auth)
	this.AnalyseJson(model)
	err := model.Delete()
	if err == nil {
		delete(auth.RouterList, model.Id)
		this.ServeSuccess("删除成功", "")
	} else {
		this.ServeError("删除失败，"+err.Error(), "")
	}
}

//修改
func (this *Auth) Edit() {
	model := new(mDefault.Auth)
	this.AnalyseJson(model)
	err := model.Edit()
	if err == nil {
		auth.RouterList[model.Id] = *model
		this.ServeSuccess("修改成功", model)
	} else {
		this.ServeError("修改失败，"+err.Error(), "")
	}
}
