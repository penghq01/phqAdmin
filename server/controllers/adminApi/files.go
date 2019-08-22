package adminApi

import (
	"phqAdmin/server/common"
	"phqAdmin/server/models"
)

type Files struct {
	AdminBase
}

func (this *Files) Prepare() {
	this.AdminBase.Prepare()
}

func (this *Files) UploadImage() {
	this.UploadImg("upload_img")
}

func (this *Files) ListClass() {
	flieClass := make([]models.FilesClass, 0)
	if err := new(models.FilesClass).ClassList(&flieClass); err != nil {
		this.ServeError("", "")
	}
	this.ServeSuccess("", flieClass)
}
func (this *Files) AddFileClass() {
	fileClass := new(models.FilesClass)
	this.AnalyseJson(fileClass)
	ok, msg := fileClass.AddClass()
	if ok {
		this.ServeSuccess(msg, fileClass)
	}
	this.ServeError(msg, "")
}
func (this *Files) EditFileClass() {
	fileClass := new(models.FilesClass)
	this.AnalyseJson(fileClass)
	ok, msg := fileClass.EditClass()
	if ok {
		this.ServeSuccess(msg, fileClass)
	}
	this.ServeError(msg, "")
}
func (this *Files) DelClass() {
	fileClass := new(models.FilesClass)
	this.AnalyseJson(fileClass)
	ok, msg := fileClass.DeleteClass()
	if ok {
		this.ServeSuccess(msg, fileClass)
	}
	this.ServeError(msg, "")
}

func (this *Files) List(){
	this.GetPageParam()
	f:=new(models.Files)
	this.AnalyseJson(f)
	data := new(common.PaginateData)
	ok,msg:=f.List(this.Paginate,data)
	if ok{
	   this.ServeSuccess("",data)
	}
	this.ServeError(msg,"")
}

func (this *Files) Delete(){
      f:=new(models.Files)
	  this.AnalyseJson(f)
	ok,msg:=f.Delete()
	if ok{
		this.ServeSuccess(msg,"")
	}
	this.ServeError(msg,"")
}
