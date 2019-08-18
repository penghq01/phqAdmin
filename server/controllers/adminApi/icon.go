package adminApi

import (
	"phqAdmin/server/common"
	"phqAdmin/server/models"
	"phqAdmin/server/models/valid"
)

type Icon struct {
	AdminBase
}
func (this *Icon)Prepare()  {
	this.AdminBase.Prepare()
}
func (this *Icon)List(){
	this.GetPageParam()
	icon:=make([]models.Icon,0)
	rows,err:=this.Db.Desc("id").Count(new(models.Icon))
	if rows<=0 || err != nil{
		this.ServeError("","")
	}
	this.Paginate.CalcPaginate(int(rows))
    err=this.Db.Desc("id").Limit(this.Paginate.Limit,this.Paginate.Start).Find(&icon)
    if err!=nil{
    	this.ServeError("","")

	}
	data:=common.PaginateData{
		Data:icon,
		Paginate:this.Paginate,
	}
	this.ServeSuccess("",data)
}
func (this *Icon)Add(){
     icon:=new(models.Icon)
     this.AnalyseJson(icon)
     vd:= valid.Icon{
     	Icon:true,
	 }
    if ok,err:=vd.Valid(icon);!ok{
    	this.ServeError(err,"")
	}
   if row,err:=this.Db.Insert(icon);row>0&&err==nil{
   	 this.ServeSuccess("添加成功",icon)
   }
   this.ServeError("添加失败","")
}
func (this *Icon)Del(){
	icon:=new(models.Icon)
	this.AnalyseJson(icon)
	vd:= valid.Icon{
		Id:true,
	}
	if ok,err:=vd.Valid(icon);!ok{
		this.ServeError(err,"")
	}
	if row,err:=this.Db.Where("id=?",icon.Id).Delete(icon);row>0&&err==nil{
		this.ServeSuccess("删除成功","")
	}
	this.ServeError("删除失败","")
}
