package models

import "phqAdmin/server/common"

type Models struct {

}

func (this *Models)Add()(bool,string){
	return false,""
}
func (this *Models)Delete()(bool,string){
	return false,""
}
func (this *Models)List()(interface{},bool,string){
	return nil,false,""
}
func (this *Models)Edit()(bool,string){
	return false,""
}
func (this *Models)PageList(paginate common.Paginate,pageData *common.PaginateData)(bool,string){
	return false,""
}
