package region

import (
	"errors"
	"server/src/app/models"
	"server/src/common"
	"xorm.io/xorm"
)

//村委会、社区
type Region struct {
	models.Models `xorm:"-"`
	Code          string `json:"code" xorm:"varchar(24) pk notnull unique"`           //行政区划代码
	Name          string `json:"name" xorm:"varchar(128) notnull"`                    //行政区划名称
	ParentCode    string `json:"parent_code" xorm:"varchar(24) notnull default('0')"` //所属上一级区划代码
	Sort          int    `json:"sort" xorm:"int notnull default(0)"`                  //排序
}

//获取表名
func (this *Region) TableName() string {
	return "region"
}
func (Region) GetSlice() interface{} {
	return new([]Region)
}

//验证数据
func (this *Region) Valid() error {
	ok, msg := this.BaseVaild.Required(this.Code, "行政区划代码")
	if !ok {
		return errors.New(msg)
	}
	ok, msg = this.BaseVaild.Required(this.Name, "行政区划名称")
	if !ok {
		return errors.New(msg)
	}
	return nil
}

//添加
func (this *Region) Add() error {
	err := this.Valid()
	if err != nil {
		return err
	}
	ok, err := common.DbEngine.Exist(&Region{Code: this.Code})
	if err != nil {
		return err
	}
	if ok {
		return errors.New("行政区划代码已经存在")
	}
	return models.Insert(this)
}

//删除
func (this *Region) Delete() error {
	if this.Code == "" {
		return errors.New("行政区划代码不能为空")
	}
	ok, err := common.DbEngine.Exist(&Region{ParentCode: this.Code})
	if err != nil {
		return err
	}
	if ok {
		return errors.New("行政区划存在下级行政区划，不能删除")
	}
	return models.Remove(this, func(db *xorm.Session) {
		db.Where("code = ?", this.Code)
	})
}

//修改
func (this *Region) Edit() error {
	err := this.Valid()
	if err != nil {
		return err
	}
	return models.Update(this, func(db *xorm.Session) {
		db.Where("code = ?", this.Code)
	})
}

//查询列表
func (this *Region) List(list *interface{}) error {
	return models.Find(this, list, func(db *xorm.Session) {
		db.Asc("sort").Asc("code")
		if this.Name != "" {
			db.Where("name link ?", "%"+this.Name+"%")
		}
		if this.ParentCode != "" {
			db.Where("parent_code = ?", this.ParentCode)
		} else {
			db.Where("parent_code = 0")
		}
	})
}

//查询分页列表
func (this *Region) PageList(pageData *common.PaginateData) error {
	return models.PageFind(this, pageData, func(db *xorm.Session) {
		db.Asc("sort").Asc("code")
		if this.Name != "" {
			db.Where("name link ?", "%"+this.Name+"%")
		}
		if this.ParentCode != "" {
			db.Where("parent_code = ?", this.ParentCode)
		} else {
			db.Where("parent_code = 0")
		}
	}, func(db *xorm.Session) {})
}
