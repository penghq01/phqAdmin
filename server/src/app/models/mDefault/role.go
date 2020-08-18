package mDefault

import (
	"errors"
	"server/src/app/models"
	"xorm.io/xorm"
)

//后台管理员角色表
type Role struct {
	models.Models `xorm:"-"`
	Id            int    `json:"id" xorm:"int(11) pk notnull unique autoincr"` //角色表ID
	RoleName      string `json:"role_name" xorm:"varchar(60)"`                 //角色名称
	AuthList      []int  `json:"auth_list" xorm:"text json"`                   //路由权限列表
	AuthData      []int  `json:"auth_data" xorm:"text json"`                   //数据权限
	RoleDesc      string `json:"role_desc" xorm:"varchar(512)"`                //角色描述
}

func (Role) TableName() string {
	return "role"
}
func (Role) GetSlice() interface{} {
	return new([]Role)
}

type RoleValid struct {
	models.BaseVaild
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

func (this *Role) Add() error {
	v := RoleValid{
		RoleName: true,
		RoleDesc: true,
	}
	if err := v.Valid(this); err != nil {
		return err
	}
	return models.Insert(this)
}

func (this *Role) Delete() error {
	v := RoleValid{
		Id: true,
	}
	if err := v.Valid(this); err != nil {
		return err
	}
	return models.Remove(this, func(db *xorm.Session) {
		db.Where("id=?", this.Id)
	})
}

func (this *Role) Edit() error {
	v := RoleValid{
		Id:       true,
		RoleName: true,
		RoleDesc: true,
	}
	if err := v.Valid(this); err != nil {
		return err
	}
	return models.Update(this, func(db *xorm.Session) {
		db.Where("id=?", this.Id)
	})
}

func (this *Role) List(data *interface{}) error {
	return models.Find(this, data, func(db *xorm.Session) {})
}
