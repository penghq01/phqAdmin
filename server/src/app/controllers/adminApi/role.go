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
	res := model.Add()
	if res.Err == nil {
		auth.RoleList[model.Id] = *model
		this.ServeSuccess(res.Msg, model)
	} else {
		this.ServeError(res.Msg, "")
	}
}

//删除
func (this *Role) Del() {
	model := new(mDefault.Role)
	this.AnalyseJson(model)
	if model.Id == 1 {
		this.ServeError("您没有权限删除该角色", "")
	}
	res := model.Delete()
	if res.Err == nil {
		delete(auth.RoleList, model.Id)
		this.ServeSuccess(res.Msg, "")
	}
	this.ServeError(res.Msg, "")
}

//修改
func (this *Role) Edit() {
	model := new(mDefault.Role)
	this.AnalyseJson(model)
	if model.Id == 1 {
		this.ServeError("您没有权限修改该角色", "")
	}
	res := model.Edit()
	if res.Err == nil {
		auth.RoleList[model.Id] = *model
		this.ServeSuccess(res.Msg, model)
	}
	this.ServeError(res.Msg, "")
}

//列表
func (this *Role) List() {
	list := make([]mDefault.Role, 0)
	err := models.Find(new(mDefault.Role), func(db *xorm.Session) error {
		if this.LoginUser.AdminId > 1 {
			db.Where("id>1")
		}
		return db.Find(&list)
	})
	if err.Err == nil {
		this.ServeSuccess("", list)
	}
	this.ServeError(err.Msg, "")
}
