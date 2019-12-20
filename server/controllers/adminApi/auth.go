package adminApi

import (
	"server/common"
	"server/models"
)

type Auth struct {
	AdminBase
}

func (this *Auth) Prepare() {
	this.ActionModel = new(models.Auth)
	this.AdminBase.Prepare()
}

func (this *Auth) GetAuthList() {
	this.ServeSuccess("", common.RouterList)
}
