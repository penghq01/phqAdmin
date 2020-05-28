package mDefault

import (
	"errors"
	"github.com/go-xorm/xorm"
	"os"
	"path/filepath"
	"server/src/app/models"
	"server/src/common"
)

//文件
type Files struct {
	models.Models `xorm:"-"`
	Id            int64  `json:"id" xorm:"bigint pk notnull unique autoincr"`
	ClassId       int    `json:"class_id" xorm:"int(11) notnull  default(0)"` //所属分类文件id
	Label         string `json:"label" xorm:"varchar(255)"`                   //名称
	SendNum       int    `json:"send_num" xorm:"int(11)  default(0)"`         //使用数量
	Src           string `json:"src" xorm:"varchar(512)"`                     //文件地址
	AddTime       int64  `json:"add_time" xorm:"int(11) notnull default(0)"`  //上传时间
}

func (Files) TableName() string {
	return "files"
}
func(Files)GetSlice()interface{}{
	return new([]Files)
}
type FilesVaild struct {
	models.BaseVaild
	Id    bool
	Label bool //名称
	Src   bool //文件地址
}

func (this *FilesVaild) Valid(obj *Files) (bool, string) {
	if this.Id {
		if ok, msg := this.Required(obj.Id, "ID"); !ok {
			return false, msg
		}
	}
	if this.Label {
		if ok, msg := this.Required(obj.Label, "标题"); !ok {
			return false, msg
		}
		if ok, msg := this.MaxSize(obj.Label, 15, "标题"); !ok {
			return false, msg
		}
	}
	if this.Src {
		if ok, msg := this.Required(obj.Src, "地址"); !ok {
			return false, msg
		}
	}
	return true, ""
}
func (this *Files) Add() error {
	return models.Insert(this)
}
func (this *Files) PageList(pageData *common.PaginateData)error {
	return models.PageFind(this, pageData, func(db *xorm.Session) {
		db.Desc("add_time")
		if this.ClassId > 0 {
			db.Where("class_id=?", this.ClassId)
		}
	}, func(db *xorm.Session){})
}
func (this *Files) Delete() error {
	session := common.DbEngine.NewSession()
	defer session.Close()
	err := session.Begin()
	if err != nil {
		return errors.New("删除失败")
	}
	if ok, err := session.Where("id=?", this.Id).Get(this); !ok || err != nil {
		return errors.New("图片不存在")
	}
	if row, err := session.Where("id=?", this.Id).Delete(this); row > 0 && err == nil {
		var delOK bool = true
		imgPath := filepath.Join(common.FileUploadDir, this.Src)
		if _, err := os.Stat(imgPath); err == nil {
			if err := os.Remove(imgPath); err != nil {
				delOK = false
			}
		}
		if delOK {
			_ = session.Commit()
			return nil
		}
	}
	_ = session.Rollback()
	return err
}
