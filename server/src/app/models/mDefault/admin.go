package mDefault

import (
	"errors"
	"fmt"
	"server/src/app/models"
	"server/src/common"
	"xorm.io/xorm"
)

//后台管理员表
type Admin struct {
	models.Models `xorm:"-"`
	AdminId       int    `json:"admin_id" xorm:"int(11) pk notnull autoincr"`  //后台管理员表ID
	Username      string `json:"username" xorm:"varchar(60) notnull unique"`   //账号
	Password      string `json:"password" xorm:"varchar(128) notnull"`         //密码
	Role          []int  `json:"role" xorm:"text json"`                        //角色权限
	LoginTime     int64  `json:"login_time" xorm:"int(11) notnull default(0)"` //上次登录时间
	LoginIp       string `json:"login_ip" xorm:"varchar(100)"`                 //上次登录IP
}

func (Admin) TableName() string {
	return "admin"
}
func (Admin) GetSlice() interface{} {
	return new([]Admin)
}

//管理员数据校验
type AdminValid struct {
	models.BaseVaild
	AdminId  bool
	Username bool
	Password bool
}

func (this *AdminValid) Valid(obj *Admin) (bool, string) {
	if this.AdminId {
		if ok, msg := this.Required(obj.AdminId, "ID"); !ok {
			return false, msg
		}
	}
	if this.Username {
		if ok, msg := this.RangeSize(obj.Username, 4, 20, "账号"); !ok {
			return false, msg
		}
	}
	if this.Password {
		if ok, msg := this.Required(obj.Password, "密码"); !ok {
			return false, msg
		}
	}
	return true, ""
}

//通过用户名查找管理员
func (this *Admin) UserNameGet(username string) bool {
	ok, err := common.DbEngine.Where("username=?", username).Get(this)
	if !ok {
		common.Logs.Error("通过用户名查找管理员:%v", err)
		return false
	} else {
		return true
	}
}

//通过id查找管理员
func (this *Admin) IdNameGet(id int) bool {
	ok, err := common.DbEngine.Where("admin_id=?", id).Get(this)
	if !ok {
		common.Logs.Error(fmt.Sprintf("通过id查找管理员:%v", err))
		return false
	} else {
		return true
	}
}

//通过ID和用户名查找管理员
func (this *Admin) IdUserNameGet(id int, username string) bool {
	ok, err := common.DbEngine.Where("admin_id=? AND username=?", id, username).Get(this)
	if !ok {
		common.Logs.Error("通过ID和用户名查找管理员:%v", err)
		return false
	} else {
		return true
	}
}

//更新登录信息
func (this *Admin) IdUpdate(id int) bool {
	rows, err := common.DbEngine.Where("admin_id=?", id).Update(this)
	if rows > 0 && err == nil {
		return true
	} else {
		common.Logs.Error("更新登录信息:%v", err)
		return false
	}
}
func (this *Admin) Add() error {
	va := AdminValid{
		Username: true,
		Password: true,
	}
	isOk, msg := va.Valid(this)
	if !isOk {
		return errors.New(msg)
	}
	if this.Username == "root" || this.Username == "admin" {
		return errors.New("不能添加该名称的管理员账号")
	}
	ok, _ := common.DbEngine.Where("username=?", this.Username).Exist(new(Admin))
	if ok {
		return errors.New("管理员账号已经存在")
	}
	this.Password = common.PassWordEncryption(this.Password)
	err := models.Insert(this)
	this.Password = ""
	return err
}
func (this *Admin) Delete() error {
	va := AdminValid{
		AdminId: true,
	}
	ok, msg := va.Valid(this)
	if !ok {
		return errors.New(msg)
	}
	if this.AdminId == 1 {
		return errors.New("您没有权限删除该账号")
	}
	return models.Remove(this, func(db *xorm.Session) {
		db.Where("admin_id=?", this.AdminId)
	})
}
func (this *Admin) Edit() error {
	if this.AdminId == 1 {
		return errors.New("没有权限操作")
	}
	va := AdminValid{
		AdminId:  true,
		Username: true,
	}
	ok, msg := va.Valid(this)
	if !ok {
		return errors.New(msg)
	}
	if this.Password != "" {
		this.Password = common.PassWordEncryption(this.Password)
	}
	return models.Update(this, func(db *xorm.Session) {
		db.Where("admin_id=?", this.AdminId)
	})
}
func (this *Admin) List(data *interface{}) error {
	return models.Find(this, data, func(db *xorm.Session) {
		db.Where("admin_id>?", 1).Omit("password")
	})
}
