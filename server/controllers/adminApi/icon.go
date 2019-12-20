package adminApi

import "server/models"

type Icon struct {
	AdminBase
}

func (this *Icon) Prepare() {
	this.ActionModel = new(models.Icon)
	this.AdminBase.Prepare()
}
