package models

import "server/common"

type IModels interface {
	Add() (bool, string)
	Delete() (bool, string)
	List() (interface{}, bool, string)
	Edit() (bool, string)
	PageList(paginate common.Paginate, pageData *common.PaginateData) (bool, string)
}
