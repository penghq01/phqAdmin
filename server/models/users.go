package models

//用户表
type Users struct {
	Models    `xorm:"-"`
	UserId    int64   `json:"user_id" xorm:"bigint pk notnull unique autoincr"` //id
	Mobile    string  `json:"mobile" xorm:"varchar(11)"`                        //手机
	Money     float64 `json:"money" xorm:"decimal(11,2) notnull default(0.00)"` //用户余额（分）
	Points    int     `json:"points" xorm:"int(11) notnull default(0)"`         //用户积分
	Password  string  `json:"password" xorm:"varchar(128)"`                     //登录密码
	Nickname  string  `json:"nickname" xorm:"varchar(60)"`                      //昵称
	Sex       int8    `json:"sex" xorm:"tinyint(1) default(0)"`                 //性别
	AvatarUrl string  `json:"avatar_url" xorm:"varchar(512)"`                   //头像
	Province  string  `json:"province" xorm:"varchar(30)"`                      //省份
	City      string  `json:"city" xorm:"varchar(30)"`                          //城市
	XcxOpenid string  `json:"xcx_openid" xorm:"varchar(100)"`                   //小程序openid
	GzhOpenid string  `json:"gzh_openid" xorm:"varchar(100)"`                   //公众号openid
	Unionid   string  `json:"unionid" xorm:"varchar(100)"`                      //微信开放平台unionid
	Longitude float64 `json:"longitude" xorm:"double(11,8)"`                    //经度
	Latitude  float64 `json:"latitude" xorm:"double(11,8)"`                     //纬度
	RegTime   int     `json:"reg_time" xorm:"int(11) notnull default(0)"`       //登录时间
	LoginTime int     `json:"login_time" xorm:"int(11) notnull default(0)"`     //上次登录时间
	LoginRand string  `json:"login_rand" xorm:"varchar(256)"`                   //登录随机字串
}
func (this *Users)TableName()string{
	return "users"
}