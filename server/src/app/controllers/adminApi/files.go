package adminApi

import (
	"server/src/app/models/mDefault"
)

type Files struct {
	AdminBase
}

func (this *Files) Prepare() {
	this.ActionModel = new(mDefault.Files)
	this.AdminBase.Prepare()
}
