package adminApi

import (
	"server/common"
	"server/models"
)

type Role struct {
	AdminBase
}

func (this *Role) Prepare() {
	this.ActionModel=new(models.Role)
	this.AdminBase.Prepare()
}

func (this *Role) AuthList(){
	auth := make([]models.Auth, 0)
	s:=common.DbEngine.Asc("sort").Where("visit=2 AND auth_type=0 AND is_show=1")
	err := s.Find(&auth)
	if err != nil {

	}
	this.ServeSuccess("",auth)
}




