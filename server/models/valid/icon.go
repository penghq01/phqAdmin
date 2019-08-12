package valid

import (
	"phqAdmin/server/models"
)

//图标数据校验
type Icon struct {
	BaseVaild
	Id bool
	Title bool
	Icon  bool
}
func (this *Icon) Valid(obj *models.Icon)(bool,string){
	if this.Id{
		if ok,msg:=this.Required(obj.Id,"ID");!ok{
			return false,msg
		}
	}
	if this.Icon{
		if ok,msg:=this.Required(obj.Icon,"图标样式");!ok{
			return false,msg
		}

	}
	return true,""
}