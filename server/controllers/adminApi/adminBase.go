package adminApi

import (
	"phqAdmin/server/common"
	"phqAdmin/server/controllers"
	"phqAdmin/server/models"
)

type AdminBase struct {
	controllers.Base
	LoginUser *models.Admin //当前登录用户
}

var (
	//不需要登录的即可访问的路由
	noLogin map[string]bool = map[string]bool{
		"/admin-api/login": true,
	}
)

func (this *AdminBase) Prepare() {
	this.Base.Prepare()
	if !noLogin[this.Uri] {
		if this.AuthToken == "" {
			this.ServeLOGIN("请登录后访问", "")
		}
		ok, _ := common.CheckToken(this.AuthToken, func(id int, username string) {
			var user *models.Admin = new(models.Admin)
			ok := user.IdUserNameGet(id, username)
			if !ok {
				this.ServeRELOGIN("管理员信息错误，请重登录登录", "")
			}
			this.LoginUser = user
		})
		if !ok {
			this.ServeRELOGIN("登录过期，重登录登录", "")
		}
	}
}
