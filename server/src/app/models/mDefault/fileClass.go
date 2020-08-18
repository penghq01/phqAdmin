package mDefault

import (
	"errors"
	"server/src/app/models"
	"server/src/common"
	"xorm.io/xorm"
)

//文件分类
type FilesClass struct {
	models.Models `xorm:"-"`
	Id            int    `json:"id" xorm:"int(11) pk notnull unique autoincr"`
	Pid           int    `json:"pid" xorm:"int(11) notnull default(0)"`
	Label         string `json:"label" xorm:"varchar(255)"`
}

func (FilesClass) TableName() string {
	return "files_class"
}
func (FilesClass) GetSlice() interface{} {
	return new([]FilesClass)
}

type FilesClassVaild struct {
	models.BaseVaild
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

func (this *FilesClass) List(data *interface{}) error {
	return models.Find(this, data, func(db *xorm.Session) {})
}
func (this *FilesClass) Add() error {
	vd := FilesClassVaild{
		Label: true,
	}
	if ok, msg := vd.Valid(this); !ok {
		return errors.New(msg)
	}
	return models.Insert(this)
}
func (this *FilesClass) Edit() error {
	vd := FilesClassVaild{
		Id:    true,
		Label: true,
	}
	if ok, msg := vd.Valid(this); !ok {
		return errors.New(msg)
	}
	return models.Update(this, func(db *xorm.Session) {
		db.Where("id=?", this.Id).Cols("pid,label")
	})
}
func (this *FilesClass) Delete() error {
	vd := FilesClassVaild{
		Id: true,
	}
	if ok, msg := vd.Valid(this); !ok {
		return errors.New(msg)
	}
	row, err := common.DbEngine.Where("class_id=?", this.Id).Count(new(Files))
	if err != nil {
		return err
	}
	if row > 0 {
		return errors.New("该分类下存在图片不能删除")
	}
	row, err = common.DbEngine.Where("pid=?", this.Id).Count(new(FilesClass))
	if err != nil {
		return err
	}
	if row > 0 {
		return errors.New("该分类下存在子分类不能删除")
	}
	return models.Remove(this, func(db *xorm.Session) {
		db.Where("id=?", this.Id)
	})
}
