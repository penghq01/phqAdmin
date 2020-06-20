package region

//村委会、社区
type Village struct {
	Code         string `json:"code" xorm:"varchar(24) pk notnull unique"`      //行政区划代码
	Name         string `json:"name" xorm:"varchar(128) notnull"`               //行政区划名称
	StreetCode   string `json:"street_code" xorm:"varchar(24) notnull index"`   //所属街道、镇区划代码
	AreaCode     string `json:"area_code" xorm:"varchar(24) notnull index"`     //所属区、县区划代码
	CityCode     string `json:"city_code" xorm:"varchar(24) notnull index"`     //所属市区划代码
	ProvinceCode string `json:"province_code" xorm:"varchar(24) notnull index"` //所属省区划代码
}
