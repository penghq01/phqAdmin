package adminApi


import "phqAdmin/server/models"

type FileClass struct {
	AdminBase
}

func (this *FileClass) Prepare() {
	this.ActionModel=new(models.FilesClass)
	this.AdminBase.Prepare()
}