package adminApi

import (
	"server/src/app/models/mDefault"
)

type FileClass struct {
	AdminBase
}

func (this *FileClass) Prepare() {
	this.ActionModel = new(mDefault.FilesClass)
	this.AdminBase.Prepare()
}
