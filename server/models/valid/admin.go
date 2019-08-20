package valid

import (
	"phqAdmin/server/models"
)

//管理员数据校验
type Admin struct {
	BaseVaild
	AdminId  bool
	Username bool
	Password bool
}

func (this *Admin) Valid(obj *models.Admin) (bool, string) {
	if this.AdminId {
		if ok, msg := this.Required(obj.AdminId, "ID"); !ok {
			return false, msg
		}
	}
	if this.Username {
		if ok, msg := this.RangeSize(obj.Username, 6, 20, "账号"); !ok {
			return false, msg
		}
	}
	if this.Password {
		if ok, msg := this.Required(obj.Password, "密码"); !ok {
			return false, msg
		}
	}
	return true, ""
}
