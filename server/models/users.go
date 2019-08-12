package models

//用户表
type Users struct {
	UserId int64      `json:"user_id"`   //id
	Mobile string     `json:"mobile"`    //手机
	Money float64     `json:"money" xorm:"Decimal"`     //用户余额（分）
	Points int        `json:"points"`    //用户积分
	Password string   `json:"password"`  //登录密码
	Nickname string   `json:"nickname"`  //昵称
	Sex int8          `json:"sex"`        //性别
	AvatarUrl string  `json:"avatar_url"`//头像
	Province string   `json:"province"`  //省份
	City string       `json:"city"`       //城市
	XcxOpenid string  `json:"xcx_openid"`//小程序openid
	GzhOpenid string  `json:"gzh_openid"`//公众号openid
	Unionid string    `json:"unionid"`   //微信开放平台unionid
	Longitude float64 `json:"longitude"` //经度
	Latitude float64  `json:"latitude"`  //纬度
	RegTime int       `json:"reg_time"`  //登录时间
	LoginTime int     `json:"login_time"`//上次登录时间
	LoginRand string  `json:"login_rand"`//登录随机字串
}