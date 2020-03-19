package models

import (
	"errors"
	"github.com/go-xorm/xorm"
)

//后台管理员角色表
type Role struct {
	Models   `xorm:"-"`
	Id       int    `json:"id" xorm:"int(11) pk notnull unique autoincr"` //角色表ID
	RoleName string `json:"role_name" xorm:"varchar(60)"`                 //角色名称
	AuthList string `json:"auth_list" xorm:"text"`                        //权限列表
	RoleDesc string `json:"role_desc" xorm:"varchar(512)"`                //角色描述
}

func (this *Role) TableName() string {
	return "role"
}

type RoleValid struct {
	BaseVaild
	Id       bool
	RoleName bool
	RoleDesc bool
}

func (this *RoleValid) Valid(obj *Role) error {
	if this.Id {
		if ok, msg := this.Required(obj.Id, "ID"); !ok {
			return errors.New(msg)
		}
	}
	if this.RoleName {
		if ok, msg := this.Required(obj.RoleName, "角色名称"); !ok {
			return errors.New(msg)
		}
		if ok, msg := this.MaxSize(obj.RoleName, 15, "角色名称"); !ok {
			return errors.New(msg)
		}
	}
	if this.RoleDesc {
		if ok, msg := this.MaxSize(obj.RoleDesc, 150, "角色描述"); !ok {
			return errors.New(msg)
		}
	}
	return nil
}

func (this *Role) Add() CurdResult {
	v := RoleValid{
		RoleName: true,
		RoleDesc: true,
	}
	if err := v.Valid(this); err != nil {
		return CurdResult{
			Err: err,
			Msg: err.Error(),
		}
	}
	return Insert(this)
}

func (this *Role) Delete() CurdResult {
	v := RoleValid{
		Id: true,
	}
	if err := v.Valid(this); err != nil {
		return CurdResult{
			Err: err,
			Msg: err.Error(),
		}
	}
	return Remove(this, func(db *xorm.Session) {
		db.Where("id=?", this.Id)
	})
}

func (this *Role) Edit() CurdResult {
	v := RoleValid{
		Id:       true,
		RoleName: true,
		RoleDesc: true,
	}
	if err := v.Valid(this); err != nil {
		return CurdResult{
			Err: err,
			Msg: err.Error(),
		}
	}
	return Update(this, func(db *xorm.Session) {
		db.Where("id=?", this.Id)
	})
}

func (this *Role) List() (interface{}, CurdResult) {
	list := make([]Role, 0)
	err := Find(this, func(db *xorm.Session) error {
		return db.Find(&list)
	})
	return list, err
}
