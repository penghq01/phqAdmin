package controllers

import (
	"updateServer/common"
)

type Login struct {
	Base
}

func (this *Login) Prepare() {
	this.Base.Prepare()
}
func (this *Login) Login() {
	var username string = this.Input("username").(string)
	var password string = this.Input("password").(string)
	if username!="root" {
		this.ServeError("管理员不存在", "")
	}
	if common.PassWordEncryption(password) != common.GetPassWordEncryption() {
		this.ServeError("密码错误", "")
	}
	token, ok := common.NewToken()
	if !ok {
		this.ServeError("登录失败", "")
	}
	this.ServeSuccess("登录成功", map[string]interface{}{
		"token":         token,
	})
}
