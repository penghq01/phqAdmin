package adminApi

import (
	"phqAdmin/server/common"
	"phqAdmin/server/models"
)

type User struct {
	AdminBase
}

func (this *User) Prepare() {
	this.AdminBase.Prepare()
}

func (this *User) List() {
	this.GetPageParam()
	userList := make([]models.Users, 0)
	serach := new(models.Users)
	this.AnalyseJson(serach)
	session := this.Db.Desc("user_id")
	session1 := this.Db.Desc("user_id")
	if serach.Nickname != "" {
		session.Where("nickname like ?", "%"+serach.Nickname+"%")
		session1.Where("nickname like ?", "%"+serach.Nickname+"%")
	}
	if serach.Mobile != "" {
		session.And("mobile=?", serach.Mobile)
		session1.And("mobile=?", serach.Mobile)
	}
	rows, err := session.Count(new(models.Users))
	if rows <= 0 || err != nil {
		this.ServeError("", "")
	}
	this.Paginate.CalcPaginate(int(rows))
	if err := session1.Omit("password").Limit(this.Paginate.Limit, this.Paginate.Start).Find(&userList); err == nil {
		data := common.PaginateData{
			Data:     userList,
			Paginate: this.Paginate,
		}
		this.ServeSuccess("", data)
	}
	this.ServeError("", "")
}

func (this *User) PayLog() {
	this.GetPageParam()
	upl := make([]models.UsersPayLogTable, 0)
	userId := this.Params["user_id"].(float64)
	sin := this.Db.Desc("id")
	if userId > 0 {
		sin.Where("user_id=?", userId)
	}
	rows, err := sin.Count(new(models.UsersPayLog))
	if rows <= 0 || err != nil {
		this.ServeError("", "")
	}
	this.Paginate.CalcPaginate(int(rows))
	sin1 := this.Db.Desc("users_pay_log.add_time")
	if userId > 0 {
		sin1.Where("users_pay_log.user_id=?", userId)
	}
	err = sin1.Select("users_pay_log.*,users.nickname,users.avatar_url,users.mobile").Join("INNER", "users", "users_pay_log.user_id = users.user_id").Limit(this.Paginate.Limit, this.Paginate.Start).Find(&upl)
	if err != nil {
		this.ServeError("", "")
	}
	data := common.PaginateData{
		Data:     upl,
		Paginate: this.Paginate,
	}
	this.ServeSuccess("", data)
}

func (this *User) TotalMoneyPoints() {
	total, err := this.Db.Sums(new(models.Users), "money", "points")
	if err != nil {
		this.ServeError("查询总金额和总积分失败", "")
	}
	this.ServeSuccess("", total)
}
