package mDefault

import (
	"errors"
	"github.com/go-xorm/xorm"
	"server/src/app/models"
	"server/src/common"
)

//图标管理
type Icon struct {
	models.Models `xorm:"extends"`
	Id            int    `json:"id" xorm:"bigint pk notnull unique autoincr"` //图标id
	Title         string `json:"title" xorm:"varchar(60)"`                     //图标名称
	Icon          string `json:"icon" xorm:"varchar(100)"`                     //图标
}

func (Icon) TableName() string {
	return "icon"
}
func(Icon)GetSlice()interface{}{
	return new([]Icon)
}
//图标数据校验
type IconValid struct {
	models.BaseVaild
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


func (this *Icon) Add() error {
	vd := IconValid{
		Icon: true,
	}
	if ok, msg := vd.Valid(this); !ok {
		return errors.New(msg)
	}
	return models.Insert(this)
}
func (this *Icon) Delete() error {
	vd := IconValid{
		Id: true,
	}
	if ok, msg := vd.Valid(this); !ok {
		return errors.New(msg)
	}
	return models.Remove(this, func(db *xorm.Session) {
		db.Where("id=?", this.Id)
	})
}
func (this *Icon) PageList(pageData *common.PaginateData) error {
	return models.PageFind(this, pageData, func(db *xorm.Session) {
		db.Desc("id")
	}, func(db *xorm.Session){})
}
