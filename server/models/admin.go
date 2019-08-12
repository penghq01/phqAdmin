package models

import (
	"phqAdmin/server/common"
	"fmt"
)

//后台管理员表
type Admin struct{
	AdminId int     `json:"admin_id" xorm:"autoincr"`   //后台管理员表ID
	Username string `json:"username"`   //账号
	Password string `json:"password"`   //密码
	LoginTime int64 `json:"login_time"` //上次登录时间
	LoginIp string  `json:"login_ip"`   //上次登录IP
}

//通过用户名查找管理员
func (this *Admin)UserNameGet(username string)bool{
	ok,err:=common.DbEngine.Where("username=?",username).Get(this)
	if !ok{
		common.Log.Error(fmt.Sprintf("通过用户名查找管理员:%v",err))
		return false
	}else{
		return true
	}
}
//通过id查找管理员
func (this *Admin)IdNameGet(id int)bool{
	ok,err:=common.DbEngine.Where("admin_id=?",id).Get(this)
	if !ok{
		common.Log.Error(fmt.Sprintf("通过id查找管理员:%v",err))
		return false
	}else{
		return true
	}
}
//通过ID和用户名查找管理员
func (this *Admin)IdUserNameGet(id int,username string)bool{
	ok,err:= common.DbEngine.Where("admin_id=? AND username=?",id,username).Get(this)
	if !ok{
		common.Log.Error(fmt.Sprintf("通过ID和用户名查找管理员:%v",err))
		return false
	}else{
		return true
	}
}
//更新登录信息
func (this *Admin)IdUpdate(id int)bool{
	rows,err := common.DbEngine.Where("admin_id=?",id).Update(this)
	if rows>0 && err==nil{
		return true
	}else{
		common.Log.Error(fmt.Sprintf("更新登录信息:%v",err))
		return  false
	}
}