package common

import "github.com/astaxie/beego/logs"

var (
	AppRunDir string          // 程序运行目录
	HtmlDir   string          //html所在路径
	ServerDir string          //server所在路径
	Logs      *logs.BeeLogger //日志写出
)
