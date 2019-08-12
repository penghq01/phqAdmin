package models

//后台管理员对应角色表
type AdminAndRole struct{
	Id int          `json:"id"`              //后台管理员对应角色表ID
	AdminId int     `json:"admin_id"`       // 管理员表ID
	AdminRoleId int `json:"admin_role_id"` // 角色表ID
}