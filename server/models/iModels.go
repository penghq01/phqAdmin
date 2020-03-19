package models

import "server/common"

type CurdResult struct {
	Err    error
	Msg    string
	Ok     bool
	Status int
}

type IModels interface {
	Get() CurdResult
	Add() CurdResult
	Delete() CurdResult
	Edit() CurdResult
	List() (interface{}, CurdResult)
	PageList(pageData *common.PaginateData) CurdResult
	TableName() string
}
