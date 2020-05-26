package adminApi

import (
	"server/src/auth"
	"server/src/app/models/mDefault"
	"server/src/common"
	"strconv"
	"time"
)

type Login struct {
	AdminBase
}

func (this *Login) Prepare() {
	this.AdminBase.Prepare()
}
func (this *Login) Login() {
	var user *mDefault.Admin = new(mDefault.Admin)
	var username string = this.Input("username").(string)
	var password string = this.Input("password").(string)
	ok := user.UserNameGet(username)
	if !ok {
		this.ServeError("管理员不存在", "")
	}
	if common.PassWordEncryption(password) != user.Password {
		this.ServeError("密码错误", "")
	}
	token, ok := common.NewToken(strconv.Itoa(user.AdminId), user.Username)
	if !ok {
		this.ServeError("登录失败", "")
	}
	updateAdmin := mDefault.Admin{
		LoginIp:   this.Ctx.Request.Host,
		LoginTime: time.Now().Unix(),
	}
	updateAdmin.IdUpdate(user.AdminId)
	this.LoginUser = user
	this.ServeSuccess("登录成功", map[string]interface{}{
		"token":         token,
		"public_router": auth.GetNoLoginAdminRoute(),
	})
}
