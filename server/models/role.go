package models

//后台管理员角色表
type Role struct{
	Id int          `json:"role_id"`    //角色表ID
	Pid int         `json:"pid"`         //父ID
	RoleName string `json:"role_name"`  //角色名称
	AuthList string `json:"auth_list"`  //权限列表
	RoleDesc string `json:"role_desc"`  //角色描述
}