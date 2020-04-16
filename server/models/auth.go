package models

import (
	"errors"
	"github.com/go-xorm/xorm"
	"server/common"
)

//api列表
type Api struct {
	Models         `xorm:"-"`
	Id             int    `json:"id" xorm:"int(11) pk notnull unique autoincr"` //id
	Title          string `json:"title" xorm:"varchar(128)"`                    //标题
	Name           string `json:"name" xorm:"varchar(50)"`                      //名称
	Router         string `json:"router" xorm:"notnull unique varchar(255)"`    //数据接口路由
	Visit          int8   `json:"visit" xorm:"tinyint(1) notnull default(0)"`   //访问权限 0公开，1登录，2权限，3,系统管理员
	Sign           int8   `json:"sign" xorm:"tinyint(1) notnull default(1)"`    //是否需要签名 0不用，1需要
	Struct         string `json:"struct" xorm:"varchar(128)"`                   //结构体名称
	MappingMethods string `json:"mapping_methods" xorm:"varchar(55)"`           //映射的方法
	IsShow   int8 `json:"is_show" xorm:"tinyint(1) notnull default(1)"`   //是否显示
}

func (this *Api) TableName() string {
	return "api"
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

func (this *Api) Add() CurdResult {
	vd := ApiValid{
		Title:          true,
		Router:         true,
		Visit:          true,
	}
	if ok, msg := this.Valid(vd); !ok {
		return CurdResult{
			Err: errors.New(msg),
			Msg: msg,
		}
	}
	ok, err := common.DbEngine.Where("router=? OR `name`=?", this.Router, this.Name).Exist(new(Api))
	if err == nil {
		if ok {
			return CurdResult{
				Err: errors.New("数据接口路由或名称，已经存在"),
				Msg: "数据接口路由或名称，已经存在",
			}
		} else {
			return Insert(this)
		}
	} else {
		return CurdResult{
			Err: err,
			Msg: err.Error(),
		}
	}
}
func (this *Api) Edit() CurdResult {
	vd := ApiValid{
		Id:             true,
		Title:          true,
		Router:         true,
		Visit:          true,	}
	if ok, msg := this.Valid(vd); !ok {
		return CurdResult{
			Err: errors.New(msg),
			Msg: msg,
		}
	}
	return Update(this, func(db *xorm.Session) {
		db.Where("id=?", this.Id).AllCols()
	})
}
func (this *Api) Delete() CurdResult {
	vd := ApiValid{
		Id: true,
	}
	if ok, msg := this.Valid(vd); !ok {
		return CurdResult{
			Err: errors.New(msg),
			Msg: msg,
		}
	}
	return Remove(this, func(db *xorm.Session) {
		db.Where("id=?", this.Id)
	})
}
func (this *Api) List() (interface{}, CurdResult) {
	auth := make([]Api, 0)
	err := Find(this, func(db *xorm.Session) error {
		db.Desc("id")
		db.Where("visit = 2 AND is_show = 1")
		return db.Find(&auth)
	})
	return auth, err
}
func (this *Api) PageList(pageData *common.PaginateData) CurdResult {
	return PageFind(this, pageData, func(db *xorm.Session) {
		db.Desc("id")
	}, func(db *xorm.Session) error {
		list := make([]Api, 0)
		err := db.Find(&list)
		pageData.Data = list
		return err
	})

}

//权限表
type Auth struct {
	Models `xorm:"-"`
	Id     int    `json:"id" xorm:"int(11) pk notnull unique autoincr"` //id
	Pid    int    `json:"pid" xorm:"int(11) notnull default(0)"`        //父id
	Title  string `json:"title" xorm:"varchar(30)"`                     //标题
	Icon   string `json:"icon" xorm:"varchar(255)"`                     //图标
	Router string `json:"router" xorm:"varchar(255)"`                   //前端路由
	//Auth     string `json:"auth" xorm:"text"`                               //权限
	Visit    int8 `json:"visit" xorm:"tinyint(1) notnull default(0)"`     //访问权限 0公开，1登录，2权限，3,系统管理员
	AuthType int8 `json:"auth_type" xorm:"tinyint(1) notnull default(0)"` //路由类型 0导航，1页面
	IsShow   int8 `json:"is_show" xorm:"tinyint(1) notnull default(0)"`   //是否显示
	Sort     int  `json:"sort" xorm:"int(11) notnull default(1)"`         //排序
}

func (this *Auth) TableName() string {
	return "auth"
}

type AuthValid struct {
	BaseVaild
	Id       bool //id
	Title    bool //标题
	Icon     bool //图标
	Visit    bool //访问权限 0公开，1登录，2权限，3,系统管理员
	AuthType bool //路由类型 0导航，1页面
	IsShow   bool //是否显示
}

func (this *AuthValid) Valid(obj *Auth) (bool, string) {
	if this.Id {
		if ok, msg := this.Required(obj.Id, "ID"); !ok {
			return false, msg
		}
	}
	if this.Title {
		if ok, msg := this.Required(obj.Title, "标题"); !ok {
			return false, msg
		}
	}
	if this.Visit {
		if ok, msg := this.Range(obj.Visit, 0, 3, "访问类型"); !ok {
			return false, msg
		}
	}
	if this.AuthType {
		if ok, msg := this.Range(obj.AuthType, 0, 3, "接口类型"); !ok {
			return false, msg
		}
	}
	if this.IsShow {
		if ok, msg := this.Range(obj.IsShow, 0, 1, "显示"); !ok {
			return false, msg
		}
	}
	return true, ""
}

func (this *Auth) Add() CurdResult {
	vd := AuthValid{
		Title:    true,
		AuthType: true,
		IsShow:   true,
	}
	if ok, msg := vd.Valid(this); !ok {
		return CurdResult{
			Err: errors.New(msg),
			Msg: msg,
		}
	}
	if this.Router != "" {
		if row, err := common.DbEngine.Where("router=?", this.Router).Count(new(Auth)); row > 0 && err == nil {
			return CurdResult{
				Err: errors.New(""),
				Msg: "前端界面已经存在",
			}
		}
	}
	return Insert(this)
}

func (this *Auth) Edit() CurdResult {
	vd := AuthValid{
		Id:    true,
		Title: true,
	}
	if ok, msg := vd.Valid(this); !ok {
		return CurdResult{
			Err: errors.New(msg),
			Msg: msg,
		}
	}
	if this.Router != "" {
		if row, err := common.DbEngine.Where("router=?", this.Router).Where("id <> ?", this.Id).Count(new(Auth)); row > 0 && err == nil {
			return CurdResult{
				Err: errors.New(""),
				Msg: "前端界面已经存在",
			}
		}
	}

	return Update(this, func(db *xorm.Session) {
		db.Where("id=?", this.Id).AllCols()
	})
}

func (this *Auth) Delete() CurdResult {
	vd := AuthValid{
		Id: true,
	}
	if ok, msg := vd.Valid(this); !ok {
		return CurdResult{
			Err: errors.New(msg),
			Msg: msg,
		}
	}
	/*if this.Id == 1 || this.Id == 2 {
		return CurdResult{
			Err: errors.New(""),
			Msg: "该分类不能删除",
		}
	}*/
	row, err := common.DbEngine.Where("pid=?", this.Id).Count(new(Auth))
	if err != nil {
		return CurdResult{
			Err: errors.New(""),
			Msg: "删除失败",
		}
	}
	if row > 0 {
		return CurdResult{
			Err: errors.New(""),
			Msg: "存在子路由不能删除",
		}
	}
	return Remove(this, func(db *xorm.Session) {
		db.Where("id=?", this.Id)
	})
}

func (this *Auth) List() (interface{}, CurdResult) {
	auth := make([]Auth, 0)
	err := Find(this, func(db *xorm.Session) error {
		db.Asc("sort").Asc("id")
		return db.Find(&auth)
	})
	return auth, err
}
