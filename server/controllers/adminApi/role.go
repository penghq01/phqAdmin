package adminApi

import (
	"phqAdmin/server/models"
)

type Role struct {
	AdminBase
}

func (this *Role) Prepare() {
	this.ActionModel=new(models.Role)
	this.AdminBase.Prepare()
}





