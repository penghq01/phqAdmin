package models

import "phqAdmin/server/common"

//文件分类
type FilesClass struct {
	Id    int    `json:"id" xorm:"autoincr"`
	Pid   int    `json:"pid"`
	Label string `json:"label"`
}

type FilesClassVaild struct {
	BaseVaild
	Id    bool
	Label bool
}

func (this *FilesClassVaild) Valid(obj *FilesClass) (bool, string) {
	if this.Id {
		if ok, msg := this.Required(obj.Id, "ID"); !ok {
			return false, msg
		}
	}
	if this.Label {
		if ok, msg := this.Required(obj.Label, "标题"); !ok {
			return false, msg
		}
		if ok, msg := this.MaxSize(obj.Label, 15, "标题"); !ok {
			return false, msg
		}
	}
	return true, ""
}

func (this *FilesClass) List()(interface{},bool,string) {
	fileClass := make([]FilesClass, 0)
	err := common.DbEngine.Find(&fileClass)
	if err != nil {
		return "",false,""
	}
	return fileClass,true,""
}
func (this *FilesClass) Add() (bool, string) {
	vd := FilesClassVaild{
		Label: true,
	}
	if ok, msg := vd.Valid(this); !ok {
		return false, msg
	}
	if row, err := common.DbEngine.Insert(this); row > 0 && err == nil {
		return true, "添加成功"
	}
	return false, "添加失败"
}
func (this *FilesClass) Edit() (bool, string) {
	vd := FilesClassVaild{
		Id:    true,
		Label: true,
	}
	if ok, msg := vd.Valid(this); !ok {
		return false, msg
	}
	if row, err := common.DbEngine.Where("id=?", this.Id).Cols("pid,label").Update(this); row > 0 && err == nil {
		return true, "修改成功"
	}
	return false, "修改失败"
}
func (this *FilesClass) Delete() (bool, string) {
	vd := FilesClassVaild{
		Id: true,
	}
	if ok, msg := vd.Valid(this); !ok {
		return false, msg
	}
	row, err := common.DbEngine.Where("class_id=?", this.Id).Count(new(Files))
	if err != nil {
		return false, "删除失败"
	}
	if row > 0 {
		return false, "该分类下存在图片不能删除"
	}
	row, err = common.DbEngine.Where("pid=?", this.Id).Count(new(FilesClass))
	if err != nil {
		return false, "删除失败"
	}
	if row > 0 {
		return false, "该分类下存在子分类不能删除"
	}
	if row, err = common.DbEngine.Where("id=?", this.Id).Delete(this); row > 0 && err == nil {
		return true, "删除成功"
	}
	return false, "删除失败"
}
func (this *FilesClass)PageList(paginate common.Paginate,pageData *common.PaginateData)(bool,string) {
	return false,""
}