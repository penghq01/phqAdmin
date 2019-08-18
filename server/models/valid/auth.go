package valid

import "phqAdmin/server/models"

//权限表
type Auth struct{
	BaseVaild
	Id bool             //id
	Title bool        //标题
	Icon bool          //图标
	Visit bool         //访问权限 0公开，1登录，2权限，3,超级管理员
	AuthType bool    //路由类型 0菜单，1操作（按钮)
	IsShow bool      //是否显示
}
func (this *Auth) Valid(obj *models.Auth)(bool,string){
	if this.Id{
		if ok,msg:=this.Required(obj.Id,"ID");!ok{
			return false,msg
		}
	}
	if this.Title{
		if ok,msg:=this.Required(obj.Title,"标题");!ok{
			return false,msg
		}
	}
	if this.Visit{
		if ok,msg:=this.Range(obj.Visit,0,3,"访问类型");!ok{
			return false,msg
		}
	}
	if this.AuthType{
		if ok,msg:=this.Range(obj.AuthType,0,3,"路由类型");!ok{
			return false,msg
		}
	}
	if this.IsShow{
		if ok,msg:=this.Range(obj.IsShow,0,1,"显示");!ok{
			return false,msg
		}
	}
	return true,""
}