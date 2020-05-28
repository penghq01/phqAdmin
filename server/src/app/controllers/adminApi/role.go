package adminApi

import (
	"github.com/go-xorm/xorm"
	"server/src/auth"
	"server/src/app/models"
	"server/src/app/models/mDefault"
	"server/src/common"
)

type Role struct {
	AdminBase
}

func (this *Role) Prepare() {
	this.ActionModel = new(mDefault.Role)
	this.AdminBase.Prepare()
}

func (this *Role) AuthList() {
	auth := make([]mDefault.Auth, 0)
	s := common.DbEngine.Asc("sort").Where("visit=2 AND auth_type=0 AND is_show=1")
	err := s.Find(&auth)
	if err != nil {

	}
	this.ServeSuccess("", auth)
}

func (this *Role) Add() {
	model := new(mDefault.Role)
	this.AnalyseJson(model)
	err := model.Add()
	if err == nil {
		auth.RoleList[model.Id] = *model
		this.ServeSuccess("添加成功", model)
	} else {
		this.ServeError("添加失败，"+err.Error(), "")
	}
}

//删除
func (this *Role) Del() {
	model := new(mDefault.Role)
	this.AnalyseJson(model)
	if model.Id == 1 {
		this.ServeError("您没有权限删除该角色", "")
	}
	err := model.Delete()
	if err == nil {
		delete(auth.RoleList, model.Id)
		this.ServeSuccess("删除成功", "")
	}else{
		this.ServeError("删除失败，"+err.Error(), "")
	}
}

//修改
func (this *Role) Edit() {
	model := new(mDefault.Role)
	this.AnalyseJson(model)
	if model.Id == 1  && this.LoginUser.AdminId>1{
		this.ServeError("您没有权限修改该角色", "")
	}
	err := model.Edit()
	if err == nil {
		auth.RoleList[model.Id] = *model
		this.ServeSuccess("修改成功", model)
	}else{
		this.ServeError("修改失败，"+err.Error(), "")
	}
}

//列表
func (this *Role) List() {
	 var list interface{}
	err := models.Find(new(mDefault.Role),&list, func(db *xorm.Session){
		if this.LoginUser.AdminId > 1 {
			db.Where("id>1")
		}
	})
	if err == nil {
		this.ServeSuccess("", list)
	}else{
		this.ServeError("获取数据失败，"+err.Error(), "")
	}
}
