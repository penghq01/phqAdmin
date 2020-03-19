package models

import (
	"errors"
	"github.com/go-xorm/xorm"
	"server/common"
)

//图标管理
type Icon struct {
	Models `xorm:"-"`
	Id     int    `json:"id" xorm:"int(11) pk notnull unique autoincr"` //图标id
	Title  string `json:"title" xorm:"varchar(60)"`                     //图标名称
	Icon   string `json:"icon" xorm:"varchar(100)"`                     //图标
}

func (this *Icon) TableName() string {
	return "icon"
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

func (this *Icon) Add() CurdResult {
	vd := IconValid{
		Icon: true,
	}
	if ok, msg := vd.Valid(this); !ok {
		return CurdResult{
			Err: errors.New(msg),
			Msg: msg,
		}
	}
	return Insert(this)
}

func (this *Icon) Delete() CurdResult {
	vd := IconValid{
		Id: true,
	}
	if ok, msg := vd.Valid(this); !ok {
		return CurdResult{
			Err: errors.New(msg),
			Msg: msg,
		}
	}
	return Remove(this, func(db *xorm.Session) {
		db.Where("id=?", this.Id)
	})
}
func (this *Icon) PageList(pageData *common.PaginateData) CurdResult {
	return PageFind(this, pageData, func(db *xorm.Session) {
		db.Desc("id")
	}, func(db *xorm.Session) error {
		icon := make([]Icon, 0)
		err := db.Find(&icon)
		pageData.Data = icon
		return err
	})
}
