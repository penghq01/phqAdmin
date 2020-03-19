package models

//用户充值记录表
type UsersPayLog struct {
	Models        `xorm:"-"`
	Id            int64   `json:"id" xorm:"bigint pk notnull unique autoincr"`      //记录ID
	PaySn         string  `json:"pay_sn" xorm:"varchar(100)"`                       // 充值订单号
	TransactionId string  `json:"transaction_id" xorm:"varchar(100)"`               //充值返回单号
	UserId        int64   `json:"user_id" xorm:"bigint notnull default(0)"`         //用户id
	Price         float64 `json:"price" xorm:"decimal(11,2) notnull default(0.00)"` //充值金额（分）
	AddTime       int     `json:"add_time" xorm:"int(11) notnull default(0)"`       //充值时间
}

func (this *UsersPayLog) TableName() string {
	return "users_pay_log"
}

type UsersPayLogTable struct {
	UsersPayLog `xorm:"extends"`
	Nickname    string `json:"nickname"`
	AvatarUrl   string `json:"avatar_url"` //头像
	Mobile      string `json:"mobile"`     //手机
}

func (this *UsersPayLogTable) TableName() string {
	return "users_pay_log"
}
