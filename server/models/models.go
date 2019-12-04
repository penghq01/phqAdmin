package models

import (
	"fmt"
	"phqAdmin/server/common"
)

type Models struct {

}
//清空所有表的数据
func (this *Models) DeleteAllTableData()bool{
	sql:=fmt.Sprintf("select concat('truncate table ',table_name) as sqlstr from information_schema.TABLES where table_schema='%v'",common.DbIni.String("db"))
	res,err:=common.DbEngine.Query(sql)
	if err==nil{
		for _,strByte:=range res{
			_,_=common.DbEngine.Query(string(strByte["sqlstr"]))
		}
		return true
	}
	return false
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
