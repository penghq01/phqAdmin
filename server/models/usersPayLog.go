package models

//用户充值记录表
type UsersPayLog struct {
	Id int64             `json:"id"`  //记录ID
	PaySn string         `json:"pay_sn"` // 充值订单号
	TransactionId string `json:"transaction_id"` //充值返回单号
 	UserId int64         `json:"user_id"` //用户id
	Price float64        `json:"price"`   //充值金额（分）
	AddTime int          `json:"add_time"` //充值时间
}
type UsersPayLogTable struct {
     UsersPayLog `xorm:"extends"`
     Nickname string `json:"nickname"`
	 AvatarUrl string  `json:"avatar_url"`//头像
	 Mobile string     `json:"mobile"`    //手机
}
func (UsersPayLogTable) TableName() string {
	return "users_pay_log"
}
