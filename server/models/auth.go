package models

//权限表
type Auth struct{
	Id int          `json:"id" xorm:"autoincr"`        //id
	Pid int         `json:"pid"`       //父id
	Title string    `json:"title"`     //标题
	Icon string     `json:"icon"`      //图标
	Croute string   `json:"croute"`    //前端路由
	Sroute string   `json:"sroute"`    //后端路由
	AuthType int8   `json:"auth_type"` //路由类型 0菜单 1操作（按钮）
	IsShow int8     `json:"is_show"`   //是否显示
	Sort int        `json:"sort"`       //排序
}

