package adminApi

import (
	"phqAdmin/server/models"
)

type Files struct {
	AdminBase
}

func (this *Files) Prepare() {
	this.AdminBase.Prepare()
}

func (this *Files) UploadImage(){
	 this.UploadImg("upload_img")
}

func (this *Files)ListClass(){
	 flieClass := make([]models.FilesClass, 0)
	 if err:=new(models.FilesClass).ClassList(&flieClass);err!=nil{
	 	this.ServeError("","");
	 }
	 this.ServeSuccess("",flieClass)
}
func (this *Files)AddFileClass(){
	fileClass:=new(models.FilesClass)
	this.AnalyseJson(fileClass)
	ok,msg:=fileClass.AddClass()
	if ok{
		this.ServeSuccess(msg,fileClass)
	}
	this.ServeError(msg,"")
}
func (this *Files)EditFileClass(){
	fileClass:=new(models.FilesClass)
	this.AnalyseJson(fileClass)
	ok,msg:=fileClass.EditClass()
	if ok{
		this.ServeSuccess(msg,fileClass)
	}
	this.ServeError(msg,"")
}
func (this *Files)DelClass(){
	fileClass:=new(models.FilesClass)
	this.AnalyseJson(fileClass)
	ok,msg:=fileClass.DeleteClass()
	if ok{
		this.ServeSuccess(msg,fileClass)
	}
	this.ServeError(msg,"")
}