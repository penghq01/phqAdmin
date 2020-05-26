package adminApi

import (
	"server/src/app/models/mDefault"
	"server/src/common"
)

type User struct {
	AdminBase
}

func (this *User) Prepare() {
	this.AdminBase.Prepare()
}

func (this *User) List() {
	this.GetPageParam()
	userList := make([]mDefault.Users, 0)
	serach := new(mDefault.Users)
	this.AnalyseJson(serach)
	session := common.DbEngine.Desc("user_id")
	session1 := common.DbEngine.Desc("user_id")
	if serach.Nickname != "" {
		session.Where("nickname like ?", "%"+serach.Nickname+"%")
		session1.Where("nickname like ?", "%"+serach.Nickname+"%")
	}
	if serach.Mobile != "" {
		session.And("mobile=?", serach.Mobile)
		session1.And("mobile=?", serach.Mobile)
	}
	rows, err := session.Count(new(mDefault.Users))
	if rows <= 0 || err != nil {
		this.ServeError("", "")
	}
	this.Paginate.CalcPaginate(rows)
	if err := session1.Omit("password").Limit(this.Paginate.Limit, this.Paginate.Start).Find(&userList); err == nil {
		data := common.PaginateData{
			Data:     userList,
			Paginate: this.Paginate,
		}
		this.ServeSuccess("", data)
	}
	this.ServeError("", "")
}
