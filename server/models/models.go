package models

import (
	"fmt"
	"github.com/go-xorm/xorm"
	"server/common"
)

type Models struct {

}

//删除所有表
func (this *Models) DeleteAllTable() error {
	sql := fmt.Sprintf("select concat(table_name) as table_name from information_schema.TABLES where table_schema='%v'", common.DbIni.String("db"))
	res, err := common.DbEngine.Query(sql)
	if err == nil {
		session := common.DbEngine.NewSession()
		defer session.Close()
		for _, strByte := range res {
			if err = session.DropTable(string(strByte["table_name"])); err != nil {
				_ = session.Rollback()
				return err
			}
		}
		_ = session.Rollback()
		return nil
	}
	return err
}

func (this *Models) Get() CurdResult {
	return CurdResult{}
}

func (this *Models) Add() CurdResult {
	return CurdResult{}
}
func (this *Models) Delete() CurdResult {
	return CurdResult{}
}
func (this *Models) List() (interface{}, CurdResult) {
	return nil, CurdResult{}
}
func (this *Models) Edit() CurdResult {
	return CurdResult{}
}
func (this *Models) PageList(pageData *common.PaginateData) CurdResult {
	return CurdResult{}
}

func (this *Models)TableName()string{
	return ""
}

func First(model IModels,where func(db *xorm.Session)) CurdResult {
	db:= common.DbEngine.Table(model.TableName())
	where(db)
	if ok, err := db.Get(model); ok && err == nil {
		return CurdResult{
			Err: nil,
			//Msg: "获取数据成功",
		}
	} else {
		common.Logs.Error("✖ 查询一条数据失败，%v", err)
		return CurdResult{
			Err: err,
			Msg: "获取数据失败",
		}
	}
}
func Insert(model IModels,where func(db *xorm.Session)) CurdResult {
	db:= common.DbEngine.Table(model.TableName())
	where(db)
	if row, err := db.Insert(model); row > 0 && err == nil {
		return CurdResult{
			Err: nil,
			Msg: "添加成功",
		}
	} else {
		common.Logs.Error("✖ 添加失败，%v", err)
		return CurdResult{
			Err: err,
			Msg: "添加失败",
		}
	}
}
func Delete(model IModels,where func(db *xorm.Session)) CurdResult {
	db:= common.DbEngine.Table(model.TableName())
	where(db)
	if row, err := db.Delete(model); err == nil && row > 0 {
		return CurdResult{
			Err: nil,
			Msg: "删除成功",
		}
	} else {
		common.Logs.Error("✖ 删除失败，%v", err)
		return CurdResult{
			Err: err,
			Msg: "删除失败",
		}
	}
}
func Update(model IModels,where func(db *xorm.Session)) CurdResult {
	db:= common.DbEngine.Table(model.TableName())
	where(db)
	if row, err := db.Update(model); row > 0 && err == nil {
		return CurdResult{
			Err: nil,
			Msg: "修改成功",
		}
	} else {
		common.Logs.Error("✖ 修改失败，%v", err)
		return CurdResult{
			Err: err,
			Msg: "修改失败",
		}
	}
}
func Find(model IModels,find func(db *xorm.Session) error) CurdResult {
	db := common.DbEngine.Table(model.TableName())
	err := find(db)
	fmt.Println(err)
	if err == nil {
		return CurdResult{
			Err: nil,
			//Msg: "获取数据成功",
		}
	} else {
		common.Logs.Error("✖ 查询列表数据失败，%v", err)
		return CurdResult{
			Err: err,
			Msg: "获取数据失败",
		}
	}
}
func PageFind(model IModels,pageData *common.PaginateData, where func(db *xorm.Session), find func(db *xorm.Session) error) CurdResult {
	db := common.DbEngine.Table(model.TableName())
	defer db.Close()
	where(db)
	rows, err := db.Count(model)
	if err != nil {
		common.Logs.Error("✖ 查询(分页)总条数失败，%v", err)
		return CurdResult{
			Err: err,
			Msg: "获取数据失败",
		}
	}
	db= common.DbEngine.Table(model.TableName())
	where(db)
	pageData.Paginate.CalcPaginate(rows)
	db.Limit(pageData.Paginate.Limit, pageData.Paginate.Start)
	err = find(db)
	if err == nil {
		return CurdResult{
			Err: nil,
			//Msg: "获取数据成功",
		}
	} else {
		common.Logs.Error("✖ 查询(分页)数据失败，%v", err)
		return CurdResult{
			Err: err,
			Msg: "获取数据失败",
		}
	}
}
