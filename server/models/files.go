package models

import (
	"os"
	"server/common"
)

//文件
type Files struct {
	Models `xorm:"-"`
	Id      int64  `json:"id" xorm:"bigint pk notnull unique autoincr"`
	ClassId int    `json:"class_id" xorm:"int(11) notnull  default(0)"` //所属分类文件id
	Label   string `json:"label" xorm:"varchar(255)"`    //名称
	SendNum int    `json:"send_num" xorm:"int(11)  default(0)"` //使用数量
	Src     string `json:"src" xorm:"varchar(512)"`      //文件地址
	AddTime int64  `json:"add_time" xorm:"int(11) notnull default(0)"` //上传时间
}
type FilesVaild struct {
	BaseVaild
	Id    bool
	Label bool //名称
	Src   bool //文件地址
}

func (this *FilesVaild) Valid(obj *Files) (bool, string) {
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
	if this.Src {
		if ok, msg := this.Required(obj.Src, "地址"); !ok {
			return false, msg
		}
	}
	return true, ""
}

func (this *Files) Add() (bool, string) {
	if row, err := common.DbEngine.Insert(this); row > 0 && err == nil {
		return true, "添加成功"
	}
	return false, "添加失败"
}
func (this *Files) PageList(paginate common.Paginate, pageData *common.PaginateData) (bool, string) {
	session := common.DbEngine.Desc("add_time")
	session1 := common.DbEngine.Desc("add_time")
	if this.ClassId > 0 {
		session.Where("class_id=?", this.ClassId)
		session1.Where("class_id=?", this.ClassId)
	}
	rows, err := session.Count(new(Files))
	if rows <= 0 || err != nil {
		return false, ""
	}
	paginate.CalcPaginate(rows)
	files := make([]Files, 0)
	if err := session1.Limit(paginate.Limit, paginate.Start).Find(&files); err == nil {
		pageData.Data = files
		pageData.Paginate = paginate

		return true, ""
	}
	return false, ""
}
func (this *Files) Delete() (bool, string) {
	session := common.DbEngine.NewSession()
	defer session.Close()
	err := session.Begin()
	if err != nil {
		return false, "删除失败"
	}
	if ok, err := session.Where("id=?", this.Id).Get(this); !ok || err != nil {
		return false, "图片不存在"
	}
	if row, err := session.Where("id=?", this.Id).Delete(this); row > 0 && err == nil {
		var delOK bool = true
		if _, err := os.Stat(this.Src); err == nil {
			if err := os.Remove(this.Src); err != nil {
				delOK = false
			}
		}
		if delOK {
			_ = session.Commit()
			return true, "删除成功"
		}
	}
	_ = session.Rollback()
	return false, "删除失败"
}
func (this *Files) Edit() (bool, string) {
	return false, ""
}
func (this *Files) List() (interface{}, bool, string) {
	return "", false, ""
}
