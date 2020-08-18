package models

import (
	"server/src/common"
	"xorm.io/xorm"
)

const (
	INNER      = "INNER"
	LEFT_OUTER = "LEFT OUTER"
	CROSS      = "CROSS"
)

type Models struct {
	BaseVaild `xorm:"-"`
}

//获取表名
func (this *Models) TableName() string {
	return ""
}

//添加
func (this *Models) Add() error {
	return nil
}

//删除
func (this *Models) Delete() error {
	return nil
}

//修改
func (this *Models) Edit() error {
	return nil
}

//查询列表
func (this *Models) List(list *interface{}) error {
	return nil
}

//查询分页列表
func (this *Models) PageList(pageData *common.PaginateData) error {
	return nil
}

//获取一条数据
func (this *Models) Get() error {
	return nil
}

func First(model IModels, where func(db *xorm.Session)) error {
	db := common.DbEngine.Table(model.TableName())
	where(db)
	if ok, err := db.Get(model); ok && err == nil {
		return nil
	} else {
		common.Logs.Error("✖ 查询一条数据失败，%v", err)
		return err
	}
}
func Insert(model IModels) error {
	db := common.DbEngine.Table(model.TableName())
	if row, err := db.Insert(model); row > 0 && err == nil {
		return nil
	} else {
		common.Logs.Error("✖ 添加失败，%v", err)
		return err
	}
}
func Remove(model IModels, where func(db *xorm.Session)) error {
	db := common.DbEngine.Table(model.TableName())
	where(db)
	if row, err := db.Delete(model); err == nil && row > 0 {
		return nil
	} else {
		common.Logs.Error("✖ 删除失败，%v", err)
		return err
	}
}
func Update(model IModels, where func(db *xorm.Session)) error {
	db := common.DbEngine.Table(model.TableName())
	where(db)
	if row, err := db.Update(model); row > 0 && err == nil {
		return nil
	} else {
		common.Logs.Error("✖ 修改失败，%v", err)
		return err
	}
}
func Find(model IModels, data *interface{}, find func(db *xorm.Session)) error {
	db := common.DbEngine.Table(model.TableName())
	find(db)
	list := model.GetSlice()
	err := db.Find(list)
	if err == nil {
		*data = list
		return nil
	} else {
		common.Logs.Error("✖ 查询列表数据失败，%v", err)
		return err
	}
}
func PageFind(model IModels, pageData *common.PaginateData, where func(db *xorm.Session), find func(db *xorm.Session)) error {
	db := common.DbEngine.Table(model.TableName())
	where(db)
	rows, err := db.Count()
	if err != nil {
		common.Logs.Error("✖ 查询(分页)总条数失败，%v", err)
		return err
	}
	db = common.DbEngine.Table(model.TableName())
	where(db)
	pageData.Paginate.CalcPaginate(rows)
	db.Limit(pageData.Paginate.Limit, pageData.Paginate.Start)
	find(db)
	list := model.GetSlice()
	err = db.Find(list)
	if err == nil {
		pageData.Data = list
		return nil
	} else {
		common.Logs.Error("✖ 查询(分页)数据失败，%v", err)
		return err
	}
}
