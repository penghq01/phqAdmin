package models

import (
	"errors"
	"github.com/go-xorm/xorm"
	"server/common"
)

//权限表
type Auth struct {
	Models   `xorm:"-"`
	Id       int    `json:"id" xorm:"int(11) pk notnull unique autoincr"`   //id
	Pid      int    `json:"pid" xorm:"int(11) notnull default(0)"`          //父id
	Title    string `json:"title" xorm:"varchar(30)"`                       //标题
	Icon     string `json:"icon" xorm:"varchar(255)"`                       //图标
	Crouter  string `json:"crouter" xorm:"varchar(255)"`                    //前端路由
	Auth     string `json:"auth" xorm:"text"`                               //权限
	Visit    int8   `json:"visit" xorm:"tinyint(1) notnull default(0)"`     //访问权限 0公开，1登录，2权限，3,系统管理员
	AuthType int8   `json:"auth_type" xorm:"tinyint(1) notnull default(0)"` //路由类型 0菜单 1分类
	IsShow   int8   `json:"is_show" xorm:"tinyint(1) notnull default(0)"`   //是否显示
	Sort     int    `json:"sort" xorm:"int(11) notnull default(0)"`         //排序
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
	AuthType bool //路由类型 0菜单，1分类
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
	if this.Crouter != "" {
		if row, err := common.DbEngine.Where("crouter=?", this.Crouter).Count(new(Auth)); row > 0 && err == nil {
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
	if this.Crouter != "" {
		if row, err := common.DbEngine.Where("crouter=?", this.Crouter).Where("id <> ?", this.Id).Count(new(Auth)); row > 0 && err == nil {
			return CurdResult{
				Err: errors.New(""),
				Msg: "前端界面已经存在",
			}
		}
	}

	return Update(this, func(db *xorm.Session) {
		db.Where("id=?", this.Id).Cols("title,icon,srouter,crouter,auth,visit,auth_type,is_show,sort")
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
	if this.Id == 1 || this.Id == 0 {
		return CurdResult{
			Err: errors.New(""),
			Msg: "该分类不能删除",
		}
	}
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
		return db.Find(&auth)
	})
	return auth, err
}
