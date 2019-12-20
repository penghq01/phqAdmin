package models

import (
	"errors"
	"server/common"
)

//后台管理员角色表
type Role struct {
	Id       int    `json:"id" xorm:"autoincr"`   //角色表ID
	RoleName string `json:"role_name"` //角色名称
	AuthList string `json:"auth_list"` //权限列表
	RoleDesc string `json:"role_desc"` //角色描述
}

type RoleValid struct {
	BaseVaild
	Id       bool
	RoleName bool
	RoleDesc bool
}

func (this *RoleValid) Valid(obj *Role)error{
	if this.Id {
		if ok, msg := this.Required(obj.Id, "ID"); !ok {
			return errors.New(msg)
		}
	}
	if this.RoleName {
		if ok, msg := this.Required(obj.RoleName, "角色名称"); !ok {
			return errors.New(msg)
		}
		if ok, msg := this.MaxSize(obj.RoleName,15,"角色名称"); !ok {
			return errors.New(msg)
		}
	}
	if this.RoleDesc {
		if ok, msg := this.MaxSize(obj.RoleDesc, 150, "角色描述"); !ok {
			return errors.New(msg)
		}
	}
	return nil
}

func (this *Role)Add()(bool,string){
    v:=RoleValid{
		RoleName:  true,
		RoleDesc:  true,
	}
    if err:=v.Valid(this);err!=nil{
    	return false,err.Error()
	}
	row,err:=common.DbEngine.Insert(this)
    if row>0 && err==nil{
    	return true,"添加成功"
	}
    return false,"添加失败"
}

func (this *Role)Delete()(bool,string){
	v:=RoleValid{
		Id:true,
	}
	if err:=v.Valid(this);err!=nil{
		return false,err.Error()
	}
	if row,err:=common.DbEngine.Where("id=?",this.Id).Delete(this);row>0 && err==nil{
		return true,"删除成功"
	}
	return false,"删除失败"
}

func (this *Role)Edit()(bool,string){
	v:=RoleValid{
		Id:true,
		RoleName:  true,
		RoleDesc:  true,
	}
	if err:=v.Valid(this);err!=nil{
		return false,err.Error()
	}
	if row,err:=common.DbEngine.Where("id=?",this.Id).Update(this);row>0 && err==nil{
		return true,"修改成功"
	}
	return false,"修改失败"
}

func (this *Role)List()(interface{},bool,string){
	list:=make([]Role,0)
	err:=common.DbEngine.Find(&list)
	if err==nil{
		return list,true,""
	}
	return "",false,"获取数据失败"
}

func (this *Role)PageList(paginate common.Paginate,pageData *common.PaginateData)(bool,string) {
	return false,""
}