package models

import (
	"os"
	"phqAdmin/server/common"
)

//文件分类
type FilesClass struct {
	Id    int    `json:"id" xorm:"autoincr"`
	Pid   int    `json:"pid"`
	Label string `json:"label"`
}
type FilesClassVaild struct {
	BaseVaild
	Id    bool
	Label bool
}

//文件
type Files struct {
	Id      int64  `json:"id" xorm:"autoincr"`
	ClassId int    `json:"class_id"` //所属分类文件id
	Label   string `json:"label"`    //名称
	SendNum int    `json:"send_num"` //使用数量
	Src     string `json:"src"`      //文件地址
	AddTime int64    `json:"add_time"` //上传时间
}
type FilesVaild struct {
	BaseVaild
	Id    bool
	Label bool //名称
	Src   bool //文件地址
}

func (this *FilesClassVaild) Valid(obj *FilesClass) (bool, string) {
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
	return true, ""
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

func (this *FilesClass) ClassList(list *[]FilesClass) error {
	return common.DbEngine.Find(list)
}

func (this *FilesClass) AddClass() (bool, string) {
	vd := FilesClassVaild{
		Label: true,
	}
	if ok, msg := vd.Valid(this); !ok {
		return false, msg
	}
	if row, err := common.DbEngine.Insert(this); row > 0 && err == nil {
		return true, "添加成功"
	}
	return false, "添加失败"
}
func (this *FilesClass) EditClass() (bool, string) {
	vd := FilesClassVaild{
		Id:    true,
		Label: true,
	}
	if ok, msg := vd.Valid(this); !ok {
		return false, msg
	}
	if row, err := common.DbEngine.Where("id=?", this.Id).Cols("pid,label").Update(this); row > 0 && err == nil {
		return true, "修改成功"
	}
	return false, "修改失败"
}
func (this *FilesClass) DeleteClass() (bool, string) {
	vd := FilesClassVaild{
		Id: true,
	}
	if ok, msg := vd.Valid(this); !ok {
		return false, msg
	}
	row, err := common.DbEngine.Where("class_id=?", this.Id).Count(new(Files))
	if err != nil {
		return false, "删除失败"
	}
	if row > 0 {
		return false, "该分类下存在图片不能删除"
	}
	row, err = common.DbEngine.Where("pid=?", this.Id).Count(new(FilesClass))
	if err != nil {
		return false, "删除失败"
	}
	if row > 0 {
		return false, "该分类下存在子分类不能删除"
	}
	if row, err = common.DbEngine.Where("id=?", this.Id).Delete(this); row > 0 && err == nil {
		return true, "删除成功"
	}
	return false, "删除失败"
}

func (this *Files)Add()(bool, string){
	if row, err := common.DbEngine.Insert(this); row > 0 && err == nil {
		return true, "添加成功"
	}
	return false, "添加失败"
}
func (this *Files)List(paginate common.Paginate,pageData *common.PaginateData)(bool,string){
	session := common.DbEngine.Desc("add_time")
	session1 := common.DbEngine.Desc("add_time")
	if this.ClassId>0 {
		session.Where("class_id=?",this.ClassId)
		session1.Where("class_id=?",this.ClassId)
	}
	rows, err := session.Count(new(Files))
	if rows <= 0 || err != nil {
		return false,""
	}
	paginate.CalcPaginate(int(rows))
	files:=make([]Files,0)
	if err := session1.Limit(paginate.Limit, paginate.Start).Find(&files); err == nil {
			pageData.Data=files
			pageData.Paginate=paginate

		return true,""
	}
	return false,""
}
func (this *Files)Delete()(bool,string){
	session:=common.DbEngine.NewSession()
	defer session.Close()
	err:=session.Begin()
	if err!=nil{
		return false,"删除失败"
	}
	 if ok,err:=session.Where("id=?",this.Id).Get(this);!ok || err!=nil{
		 return false,"图片不存在"
	 }
	if row,err:=session.Where("id=?",this.Id).Delete(this);row>0 && err==nil{
        if err:=os.Remove(this.Src);err==nil{
        	_=session.Commit()
        	return true,"删除成功"
		}
	}
	_=session.Rollback()
	return false,"删除失败"
}