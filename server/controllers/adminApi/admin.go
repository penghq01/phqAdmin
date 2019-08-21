package adminApi

import (
	"phqAdmin/server/common"
	"phqAdmin/server/models"
)

type Admin struct {
	AdminBase
}

func (this *Admin) Prepare() {
	this.AdminBase.Prepare()
}
func (this *Admin) List() {
	list := make([]models.Admin, 0)
	err := common.DbEngine.Omit("password").Find(&list)
	if err != nil {
		this.ServeError("", "")
	} else {
		this.ServeSuccess("", list)
	}
}
func (this *Admin) Add() {
	user := new(models.Admin)
	this.AnalyseJson(user)
	va := models.AdminValid{
		Username: true,
		Password: true,
	}
	isOk, msg := va.Valid(user)
	if !isOk {
		this.ServeError(msg, "")
	}
	ok, _ := common.DbEngine.Where("username=?", user.Username).Exist(new(models.Admin))
	if ok {
		this.ServeError("管理员账号已经存在", "")
	}
	rows, err := common.DbEngine.Insert(user)
	if rows > 0 && err == nil {
		user.Password = ""
		this.ServeSuccess("添加管理员成功", user)
	}
	this.ServeError("添加管理员失败", "")
}
func (this *Admin) Del() {
	user := new(models.Admin)
	this.AnalyseJson(user)
	va := models.AdminValid{
		AdminId: true,
	}
	ok, msg := va.Valid(user)
	if !ok {
		this.ServeError(msg, "")
	}
	rows, err := common.DbEngine.Where("admin_id=?", user.AdminId).Delete(user)
	if rows > 0 && err == nil {
		this.ServeSuccess("删除管理员成功", "")
	}
	this.ServeError("删除失败", "")
}
func (this *Admin) Edit() {
	va := models.AdminValid{
		AdminId:  true,
		Username: true,
	}
	a := new(models.Admin)
	this.AnalyseJson(a)
	ok, msg := va.Valid(a)
	if !ok {
		this.ServeError(msg, "")
	}
	if a.Password != "" {
		a.Password = common.PassWordEncryption(a.Password)
	}
	rows, err := common.DbEngine.Where("admin_id=?", a.AdminId).Update(a)
	if rows > 0 && err == nil {
		this.ServeSuccess("修改成功", "")
	}
	this.ServeError("修改失败", "")
}

func (this *Admin) Info() {
	user := this.LoginUser
	user.Password = ""
	this.ServeSuccess("", user)
}
func (this *Admin) EditPass() {
	old := this.Params["old"].(string)
	newPass := this.Params["new"].(string)
	old = common.PassWordEncryption(old)
	newPass = common.PassWordEncryption(newPass)
	if old != this.LoginUser.Password {
		this.ServeError("旧密码不正确", "")
	}
	user := models.Admin{
		Password: newPass,
	}
	if row, err := this.Db.Where("admin_id=?", this.LoginUser.AdminId).Update(user); row > 0 && err == nil {
		this.ServeSuccess("密码修改成功", "")
	}
	this.ServeError("密码修改失败", "")
}
