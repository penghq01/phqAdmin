package models

import (
	"fmt"
	"server/common"
)

//后台管理员表
type Admin struct {
	Models `xorm:"-"`
	AdminId   int    `json:"admin_id" xorm:"int(11) pk notnull autoincr"` //后台管理员表ID
	Username  string `json:"username" xorm:"varchar(60) notnull unique"`                 //账号
	Password  string `json:"password" xorm:"varchar(128) notnull"`                 //密码
	Role      string `json:"role" xorm:"text"`                     //角色权限
	LoginTime int64  `json:"login_time" xorm:"int(11) notnull default(0)"`               //上次登录时间
	LoginIp   string `json:"login_ip" xorm:"varchar(100)"`                 //上次登录IP
}

//管理员数据校验
type AdminValid struct {
	BaseVaild
	AdminId  bool
	Username bool
	Password bool
}

func (this *AdminValid) Valid(obj *Admin) (bool, string) {
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

//通过用户名查找管理员
func (this *Admin) UserNameGet(username string) bool {
	ok, err := common.DbEngine.Where("username=?", username).Get(this)
	if !ok {
		common.Logs.Error("通过用户名查找管理员:%v", err)
		return false
	} else {
		return true
	}
}

//通过id查找管理员
func (this *Admin) IdNameGet(id int) bool {
	ok, err := common.DbEngine.Where("admin_id=?", id).Get(this)
	if !ok {
		common.Logs.Error(fmt.Sprintf("通过id查找管理员:%v", err))
		return false
	} else {
		return true
	}
}

//通过ID和用户名查找管理员
func (this *Admin) IdUserNameGet(id int, username string) bool {
	ok, err := common.DbEngine.Where("admin_id=? AND username=?", id, username).Get(this)
	if !ok {
		common.Logs.Error("通过ID和用户名查找管理员:%v", err)
		return false
	} else {
		return true
	}
}

//更新登录信息
func (this *Admin) IdUpdate(id int) bool {
	rows, err := common.DbEngine.Where("admin_id=?", id).Update(this)
	if rows > 0 && err == nil {
		return true
	} else {
		common.Logs.Error("更新登录信息:%v", err)
		return false
	}
}

func (this *Admin) Add() (bool, string) {
	va := AdminValid{
		Username: true,
		Password: true,
	}
	isOk, msg := va.Valid(this)
	if !isOk {
		return false, msg
	}
	ok, _ := common.DbEngine.Where("username=?", this.Username).Exist(new(Admin))
	if ok {
		return false, "管理员账号已经存在"
	}
	this.Password = common.PassWordEncryption(this.Password)
	rows, err := common.DbEngine.Insert(this)
	if rows > 0 && err == nil {
		this.Password = ""
		return true, "添加管理员成功"
	}
	return false, "添加管理员失败"
}
func (this *Admin) Delete() (bool, string) {
	va := AdminValid{
		AdminId: true,
	}
	ok, msg := va.Valid(this)
	if !ok {
		return false, msg
	}
	if this.AdminId == 1 {
		return false, "您没有权限删除该账号"
	}
	rows, err := common.DbEngine.Where("admin_id=?", this.AdminId).Delete(this)
	if rows > 0 && err == nil {
		return true, "删除管理员成功"
	}
	return false, "删除失败"
}
func (this *Admin) Edit() (bool, string) {
	if this.AdminId == 1 {
		return false, "您没有权限编辑该账号"
	}
	va := AdminValid{
		AdminId:  true,
		Username: true,
	}
	ok, msg := va.Valid(this)
	if !ok {
		return false, msg
	}
	if this.Password != "" {
		this.Password = common.PassWordEncryption(this.Password)
	}
	rows, err := common.DbEngine.Where("admin_id=?", this.AdminId).Update(this)
	if rows > 0 && err == nil {
		return true, "修改成功"
	}
	return false, "修改失败"
}
func (this *Admin) List() (interface{}, bool, string) {
	list := make([]Admin, 0)
	err := common.DbEngine.Where("admin_id>?", 1).Omit("password").Find(&list)
	if err != nil {
		return "", false, ""
	} else {
		return list, true, ""
	}
}
func (this *Admin) PageList(paginate common.Paginate, pageData *common.PaginateData) (bool, string) {
	return false, ""
}
