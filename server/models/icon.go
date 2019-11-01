package models

import "phqAdmin/server/common"

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

func (this *Icon) List()(interface{},bool,string) {
	return nil, false, ""
}
func (this *Icon) Add()(bool,string){
	vd := IconValid{
		Icon: true,
	}
	if ok, msg := vd.Valid(this); !ok {
		return false, msg
	}
	if row, err := common.DbEngine.Insert(this); row > 0 && err == nil {
		return true, "添加成功"
	}
	return false, "添加失败"
}
func (this *Icon)Delete()(bool,string) {
	vd := IconValid{
		Id: true,
	}
	if ok, msg := vd.Valid(this); !ok {
		return false, msg
	}
	if row, err := common.DbEngine.Where("id=?", this.Id).Delete(this); row > 0 && err == nil {
		return true, "删除成功"
	}
	return false, "删除失败"
}
func (this *Icon)Edit()(bool,string){return false,""}
func (this *Icon)PageList(paginate common.Paginate,pageData *common.PaginateData)(bool,string){
	icon := make([]Icon, 0)
	rows, err := common.DbEngine.Desc("id").Count(new(Icon))
	if rows <= 0 || err != nil {
		return false, err.Error()
	}
	paginate.CalcPaginate(rows)
	err =common.DbEngine.Desc("id").Limit(paginate.Limit, paginate.Start).Find(&icon)
	if err != nil {
		return false, err.Error()
	}
	pageData.Data=icon
	pageData.Paginate=paginate
	return true, ""
}