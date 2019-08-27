package adminApi

import (
	"phqAdmin/server/common"
	"phqAdmin/server/models"
)

type Admin struct {
	AdminBase
}

func (this *Admin) Prepare() {
	this.ActionModel=new(models.Admin)
	this.AdminBase.Prepare()
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
	if row, err := common.DbEngine.Where("admin_id=?", this.LoginUser.AdminId).Update(user); row > 0 && err == nil {
		this.ServeSuccess("密码修改成功", "")
	}
	this.ServeError("密码修改失败", "")
}

func (this *Admin) AuthList(){
	a:=new(models.Auth)
	this.AnalyseJson(a)
	auth := make([]models.Auth, 0)
	err :=common.DbEngine.Asc("sort").Where("auth_type=? AND is_show=?",a.AuthType,a.IsShow).Find(&auth)
	if err != nil {
		this.ServeError("","")
	}
	this.ServeSuccess("",auth)
}
