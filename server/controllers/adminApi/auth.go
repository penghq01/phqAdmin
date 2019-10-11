package adminApi

import (
	"phqAdmin/server/common"
	"phqAdmin/server/models"
)

type Auth struct {
	AdminBase
}

func (this *Auth) Prepare() {
	this.ActionModel=new(models.Auth)
	this.AdminBase.Prepare()
}

func(this *Auth) GetAuthList(){
     this.ServeSuccess("",common.RouterList)
}

