package mDefault

import (
	"errors"
	"server/src/app/models"
	"server/src/common"
	"xorm.io/xorm"
)

//api列表
type Api struct {
	models.Models  `xorm:"-"`
	Id             int    `json:"id" xorm:"int(11) pk notnull unique autoincr"` //id
	Title          string `json:"title" xorm:"varchar(128)"`                    //标题
	Name           string `json:"name" xorm:"varchar(50)"`                      //名称
	Router         string `json:"router" xorm:"notnull unique varchar(255)"`    //数据接口路由
	Visit          int8   `json:"visit" xorm:"tinyint(1) notnull default(0)"`   //访问权限 0公开，1登录，2权限，3,系统管理员
	Sign           int8   `json:"sign" xorm:"tinyint(1) notnull default(1)"`    //是否需要签名 0不用，1需要
	Struct         string `json:"struct" xorm:"varchar(128)"`                   //结构体名称
	MappingMethods string `json:"mapping_methods" xorm:"varchar(55)"`           //映射的方法
	IsShow         int8   `json:"is_show" xorm:"tinyint(1) notnull default(1)"` //是否显示
	Sort           int    `json:"sort" xorm:"int notnull default(0)"`           //排序
}

func (Api) TableName() string {
	return "api"
}
func (Api) GetSlice() interface{} {
	return new([]Api)
}

type ApiValid struct {
	Id             bool
	Title          bool
	Router         bool
	Visit          bool
	Struct         bool
	MappingMethods bool
}

func (this *Api) Valid(obj ApiValid) (bool, string) {
	if obj.Id {
		if ok, msg := this.Required(this.Id, "ID"); !ok {
			return false, msg
		}
	}
	if obj.Router {
		if ok, msg := this.Required(this.Router, "数据接口路由"); !ok {
			return false, msg
		}
	}
	if obj.Title {
		if ok, msg := this.Required(this.Title, "标题"); !ok {
			return false, msg
		}
	}
	if obj.Visit {
		if ok, msg := this.Range(this.Visit, 0, 3, "访问权限"); !ok {
			return false, msg
		}
	}
	if obj.Struct {
		if ok, msg := this.Required(this.Struct, "结构体名称"); !ok {
			return false, msg
		}
	}
	if obj.MappingMethods {
		if ok, msg := this.Required(this.MappingMethods, "映射的方法"); !ok {
			return false, msg
		}
	}
	return true, ""
}

func (this *Api) Add() error {
	vd := ApiValid{
		Title:  true,
		Router: true,
		Visit:  true,
	}
	if ok, msg := this.Valid(vd); !ok {
		return errors.New(msg)
	}
	ok, err := common.DbEngine.Where("router=? OR `name`=?", this.Router, this.Name).Exist(new(Api))
	if err == nil {
		if ok {
			return errors.New("数据接口路由或名称，已经存在")
		} else {
			return models.Insert(this)
		}
	} else {
		return err
	}
}
func (this *Api) Edit() error {
	vd := ApiValid{
		Id:     true,
		Title:  true,
		Router: true,
		Visit:  true}
	if ok, msg := this.Valid(vd); !ok {
		return errors.New(msg)
	}
	return models.Update(this, func(db *xorm.Session) {
		db.Where("id=?", this.Id).AllCols()
	})
}
func (this *Api) Delete() error {
	vd := ApiValid{
		Id: true,
	}
	if ok, msg := this.Valid(vd); !ok {
		return errors.New(msg)
	}
	return models.Remove(this, func(db *xorm.Session) {
		db.Where("id=?", this.Id)
	})
}
func (this *Api) List(data *interface{}) error {
	return models.Find(this, data, func(db *xorm.Session) {
		db.Desc("sort").Desc("id")
		db.Where("visit = 2 AND is_show = 1")
	})
}
func (this *Api) PageList(pageData *common.PaginateData) error {
	return models.PageFind(this, pageData, func(db *xorm.Session) {
		db.Desc("sort").Desc("id")
	}, func(db *xorm.Session) {})
}
