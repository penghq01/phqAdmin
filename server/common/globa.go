package common

import (
	"github.com/astaxie/beego/config"
	"github.com/astaxie/beego/logs"
	"github.com/go-xorm/xorm"
)

var (
	AppRunDir        string          // 程序运行目录
	SqlPathDir       string          //sql存放目录
	RunModeDev       bool            //开发模式
	RunModeProd      bool            //生产模式
	Logs             *logs.BeeLogger //日志写出
	EncryptionString string          //密码加密字串
	TokenKeyString   string          //Token加密字串
	TokenExpiresAt   int64           //token过期时间（秒）
	ConfigIni        config.Configer //config文件读取
	DbIni            config.Configer //db文件读取
	DbEngine         *xorm.Engine    //Orm引擎
	RouterList       []RouterInfo    //路由列表
)

type RouterInfo struct {
	Path string `json:"path"`
	Name string `json:"name"`
}

//分页结构体
type Paginate struct {
	Page       int64 `json:"page"`        //页码
	PageSize   int64 `json:"page_size"`   //每页条数
	Limit      int   `json:"limit"`       //获取天数
	Start      int   `json:"start"`       // 从第几条开始获取
	TotalCount int64 `json:"total_count"` //总记录页数
	TotalPage  int64 `json:"total_page"`  //总页数
}

//返回分页的数据
type PaginateData struct {
	Data     interface{} `json:"data"`     //分页时返回的数据
	Paginate Paginate    `json:"paginate"` //分页信息
}
