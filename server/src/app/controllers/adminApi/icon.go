package adminApi

import (
	"server/src/app/models/mDefault"
)

type Icon struct {
	AdminBase
}

func (this *Icon) Prepare() {
	this.ActionModel = new(mDefault.Icon)
	this.AdminBase.Prepare()
}
