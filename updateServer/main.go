package main

import (
	"fmt"
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/logs"
	"math/rand"
	"os"
	"path/filepath"
	"updateServer/common"
	"updateServer/routers"
	"time"
)
/*
获取程序运行路径
*/
func getCurrentDirectory() string {
	dir, err := filepath.Abs(filepath.Dir(os.Args[0]))
	if err != nil {
		fmt.Println("取运行目录失败")
	}
	return dir
}
//初始化日志
func initLogs() {
	//✖ ▶ ✔
	common.Logs = logs.NewLogger(10000) // 创建一个日志记录器，参数为缓冲区的大小
	runmode := beego.AppConfig.String("runmode")
	if runmode == "dev" {
		//开发模式
		err := common.Logs.SetLogger("console", "") // 设置日志记录方式：控制台记录
		if err != nil {
			common.Logs.Error("✖ 设置日志记录方式：【控制台记录】，设置失败，%v", err)
		}
		common.Logs.SetLevel(logs.LevelDebug) // 设置日志写入缓冲区的等级：Debug级别（最低级别，所以所有log都会输入到缓冲区）
		common.Logs.EnableFuncCallDepth(true) // 输出log时能显示输出文件名和行号（非必须）
		common.Logs.Info("▶ 当前日志模式为：控制台记录")
	} else {
		//生产模式
		// 设置配置文件
		jsonConfig := `{"filename" : "./logs/ServerRunLogs.log","maxlines" : 5000,"maxsize"  : 20480}`
		err := common.Logs.SetLogger("file", jsonConfig) // 设置日志记录方式：本地文件记录
		if err != nil {
			common.Logs.Error("✖ 设置日志记录方式：【本地文件记录】，设置失败，%v", err)
		}
		common.Logs.SetLevel(logs.LevelDebug) // 设置日志写入缓冲区的等级
		common.Logs.EnableFuncCallDepth(true) // 输出log时能显示输出文件名和行号（非必须）
		common.Logs.Info("▶ 当前日志模式为：本地文件记录")
	}
}
func main() {
	initLogs()
	common.AppRunDir = getCurrentDirectory()
	common.Logs.Info("▶ 当前运行目录：%v\n", common.AppRunDir)
	common.HtmlDir=beego.AppConfig.String("html_dir")
	common.ServerDir=beego.AppConfig.String("server_dir")
	rand.Seed(time.Now().UnixNano()) //初始化随机数种子
	routers.InitRoute()
	beego.Run()
}
