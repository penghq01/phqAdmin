package models

//权限表
type Auth struct {
	Id       int    `json:"id" xorm:"autoincr"` //id
	Pid      int    `json:"pid"`                //父id
	Title    string `json:"title"`              //标题
	Icon     string `json:"icon"`               //图标
	Crouter  string `json:"crouter"`            //前端路由
	Srouter  string `json:"srouter"`            //后端路由
	Auth     string `json:"auth"`               //权限
	Visit    int8   `json:"visit"`              //访问权限 0公开，1登录，2权限，3,超级管理员
	AuthType int8   `json:"auth_type"`          //路由类型 0菜单 1数据（按钮）
	IsShow   int8   `json:"is_show"`            //是否显示
	Sort     int    `json:"sort"`               //排序
}
