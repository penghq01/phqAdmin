package adminApi

import "phqAdmin/server/models"

type Files struct {
	AdminBase
}

func (this *Files) Prepare() {
	this.ActionModel=new(models.Files)
	this.AdminBase.Prepare()
}