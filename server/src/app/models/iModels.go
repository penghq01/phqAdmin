package models

import (
	"server/src/common"
)

type IModels interface {
	Add() error                                   //添加
	Delete() error                                //删除
	Edit() error                                  //修改
	Get() error                                   //获取一条数据
	List(data *interface{}) error                 //查询列表
	PageList(pageData *common.PaginateData) error //查询分页列表
	TableName() string                            //获取表名
	GetSlice() interface{}                        //获取对应模型的切片指针
}
