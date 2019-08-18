package adminApi

import (
	"phqAdmin/server/models"
	"phqAdmin/server/models/valid"
)

type Auth struct {
	AdminBase
}
func (this *Auth)Prepare()  {
	this.AdminBase.Prepare()
}

func (this *Auth)Add()  {
	auth:=new(models.Auth)
	this.AnalyseJson(auth)
	vd:=valid.Auth{
		Title:true,
		AuthType:true,
		IsShow:true,
	}
	if ok,msg:=vd.Valid(auth);!ok{
		this.ServeError(msg,"")
	}
	if row,err:=this.Db.Insert(auth);row>0 && err==nil{
		this.ServeSuccess("添加成功",auth)
	}
	this.ServeError("添加失败","")
}

func (this *Auth)Edit()  {
	auth:=new(models.Auth)
	this.AnalyseJson(auth)
	vd:=valid.Auth{
		Id:true,
		Title:true,
	}
	if ok,msg:=vd.Valid(auth);!ok{
		this.ServeError(msg,"")
	}
	if row,err:=this.Db.Where("id=?",auth.Id).Cols("title,icon,srouter,crouter,auth,visit,auth_type,is_show,sort").Update(auth);row>0 && err==nil{
		this.ServeSuccess("修改成功","")
	}
 this.ServeError("修改失败","")
}

func (this *Auth)Del()  {
	auth:=new(models.Auth)
	this.AnalyseJson(auth)
	vd:=valid.Auth{
		Id:true,
	}
	if ok,msg:=vd.Valid(auth);!ok{
		this.ServeError(msg,"")
	}
	 row,err:=this.Db.Where("pid=?",auth.Id).Count(new(models.Auth))
	 if err!=nil{
		 this.ServeError("删除失败","")
	 }
	 if row>0{
		 this.ServeError("存在子路由不能删除","")
	 }
	if row,err:=this.Db.Where("id=?",auth.Id).Delete(auth);row>0 && err==nil{
		this.ServeSuccess("删除成功","")
	}
	this.ServeError("删除失败","")
}

func (this *Auth)List()  {
	auth:=make([]models.Auth,0)
	err:=this.Db.Asc("sort").Find(&auth)
	if err!=nil{
		this.ServeError(err,"")
	}
	this.ServeSuccess("",auth)
}