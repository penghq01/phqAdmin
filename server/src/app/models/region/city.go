package region

//市
type City struct {
	Code         string `json:"code" xorm:"varchar(24) pk notnull unique"`      //行政区划代码
	Name         string `json:"name" xorm:"varchar(128) notnull"`               //行政区划名称
	ProvinceCode string `json:"province_code" xorm:"varchar(24) notnull index"` //所属省区划代码
}
