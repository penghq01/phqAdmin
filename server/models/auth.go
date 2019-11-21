package models

import "phqAdmin/server/common"

//权限表
type Auth struct {
	Id       int    `json:"id" xorm:"autoincr"` //id
	Pid      int    `json:"pid"`                //父id
	Title    string `json:"title"`              //标题
	Icon     string `json:"icon"`               //图标
	Crouter  string `json:"crouter"`            //前端路由
	Auth     string `json:"auth"`               //权限
	Visit    int8   `json:"visit"`              //访问权限 0公开，1登录，2权限，3,系统管理员
	AuthType int8   `json:"auth_type"`          //路由类型 0菜单 1分类
	IsShow   int8   `json:"is_show"`            //是否显示
	Sort     int    `json:"sort"`               //排序
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

func (this *Auth) Add()(bool,string) {
	vd := AuthValid{
		Title:    true,
		AuthType: true,
		IsShow:   true,
	}
	if ok, msg := vd.Valid(this); !ok {
		return false,msg
	}
	if this.Crouter!=""{
		if row,err:=common.DbEngine.Where("crouter=?",this.Crouter).Count(new(Auth));row>0 && err==nil{
			return false,"前端界面已经存在"
		}
	}
	if row, err := common.DbEngine.Insert(this); row > 0 && err == nil {
		return true,"添加成功"
	}
	return false,"添加失败"
}

func (this *Auth) Edit()(bool,string) {
	vd := AuthValid{
		Id:    true,
		Title: true,
	}
	if ok, msg := vd.Valid(this); !ok {
		return false,msg
	}
	if this.Crouter!=""{
		if row,err:=common.DbEngine.Where("crouter=?",this.Crouter).Where("id <> ?",this.Id).Count(new(Auth));row>0 && err==nil{
			return false,"前端界面已经存在"
		}
	}
	if row, err := common.DbEngine.Where("id=?", this.Id).Cols("title,icon,srouter,crouter,auth,visit,auth_type,is_show,sort").Update(this); row > 0 && err == nil {
		return true,"修改成功"
	}
	return false,"修改失败"
}

func (this *Auth) Delete()(bool,string) {
	vd := AuthValid{
		Id: true,
	}
	if ok, msg := vd.Valid(this); !ok {
		return false,msg
	}
	if this.Id==1 || this.Id==0{
		return false,"该分类不能删除"
	}
	row, err := common.DbEngine.Where("pid=?", this.Id).Count(new(Auth))
	if err != nil {
		return false,"删除失败"
	}
	if row > 0 {
		return false,"存在子路由不能删除"
	}
	if row, err := common.DbEngine.Where("id=?", this.Id).Delete(this); row > 0 && err == nil {
		return true,"删除成功"
	}
	return false,"删除失败"
}

func (this *Auth) List() (interface{},bool,string){
	auth := make([]Auth, 0)
	s:=common.DbEngine.Asc("sort")
	err := s.Find(&auth)
	if err != nil {
		return "",false,""
	}
	return auth,true,""
}

func (this *Auth)PageList(paginate common.Paginate,pageData *common.PaginateData)(bool,string){
	return false,""
}