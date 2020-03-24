package adminApi

import (
	"server/acc"
	"server/common"
	"server/models"
)

type Role struct {
	AdminBase
}

func (this *Role) Prepare() {
	this.ActionModel = new(models.Role)
	this.AdminBase.Prepare()
}

func (this *Role) AuthList() {
	auth := make([]models.Auth, 0)
	s := common.DbEngine.Asc("sort").Where("visit=2 AND auth_type=0 AND is_show=1")
	err := s.Find(&auth)
	if err != nil {

	}
	this.ServeSuccess("", auth)
}


func (this *Role) Add() {
	model:=new(models.Role)
	this.AnalyseJson(model)
	res := model.Add()
	if res.Err == nil {
		acc.RoleList[model.Id]=*model
		this.ServeSuccess(res.Msg, model)
	} else {
		this.ServeError(res.Msg, "")
	}
}

//删除
func (this *Role) Del() {
	model:=new(models.Role)
	this.AnalyseJson(model)
	res := model.Delete()
	if res.Err == nil {
        delete(acc.RoleList,model.Id)
		this.ServeSuccess(res.Msg, "")
	}
	this.ServeError(res.Msg, "")
}

//修改
func (this *Role) Edit() {
	model:=new(models.Role)
	this.AnalyseJson(model)
	res :=model.Edit()
	if res.Err == nil {
		acc.RoleList[model.Id]=*model
		this.ServeSuccess(res.Msg,model)
	}
	this.ServeError(res.Msg, "")
}