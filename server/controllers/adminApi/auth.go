package adminApi

import "phqAdmin/server/models"

type Auth struct {
	AdminBase
}

func (this *Auth) Prepare() {
	this.ActionModel=new(models.Auth)
	this.AdminBase.Prepare()
}


