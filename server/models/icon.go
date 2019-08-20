package models

//图标管理
type Icon struct {
	Id    int    `json:"id" xorm:"autoincr"` //图标id
	Title string `json:"title"`              //图标名称
	Icon  string `json:"icon"`               //图标
}
