package region

//省
type Province struct {
	Code string `json:"code" xorm:"varchar(24) pk notnull unique"` //行政区划代码
	Name string `json:"name" xorm:"varchar(128) notnull"`          //行政区划名称
}
