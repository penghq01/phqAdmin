package models

//图标管理
type Icon struct {
	Id    int    `json:"id" xorm:"autoincr"` //图标id
	Title string `json:"title"`              //图标名称
	Icon  string `json:"icon"`               //图标
}
//图标数据校验
type IconValid struct {
	BaseVaild
	Id    bool
	Title bool
	Icon  bool
}

func (this *IconValid) Valid(obj *Icon) (bool, string) {
	if this.Id {
		if ok, msg := this.Required(obj.Id, "ID"); !ok {
			return false, msg
		}
	}
	if this.Icon {
		if ok, msg := this.Required(obj.Icon, "图标样式"); !ok {
			return false, msg
		}

	}
	return true, ""
}