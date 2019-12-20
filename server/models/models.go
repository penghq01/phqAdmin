package models

import (
	"fmt"
	"server/common"
)

type Models struct {

}
//删除所有表
func (this *Models) DeleteAllTable()error{
	sql:=fmt.Sprintf("select concat(table_name) as table_name from information_schema.TABLES where table_schema='%v'",common.DbIni.String("db"))
	res,err:=common.DbEngine.Query(sql)
	if err==nil{
		session := common.DbEngine.NewSession()
		defer session.Close()
		for _,strByte:=range res{
			if err=session.DropTable(string(strByte["table_name"]));err!=nil{
				_=session.Rollback()
				return err
			}
		}
		_=session.Rollback()
		return nil
	}
	return err
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
