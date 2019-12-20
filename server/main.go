package main

import (
	"github.com/astaxie/beego"
	"os"
	"path/filepath"
	"server/common"
	_ "server/init"
	_ "server/routers"
	"strings"
)
/*
获取程序运行路径
*/
func getCurrentDirectory() string {
	dir, err := filepath.Abs(filepath.Dir(os.Args[0]))
	if err != nil {
		common.Logs.Info("取运行目录失败")
	}
	return strings.Replace(dir, "\\", "/", -1)
}
func main() {
	//✖ ▶ ✔
	common.AppRunDir=getCurrentDirectory()
	common.SqlPathDir=filepath.Join(common.AppRunDir,"sql-bak")
	defer func() {
		if err := common.DbEngine.Close(); err != nil {
			common.Logs.Error("关闭数据库连接失败，%v", err)
		}
		common.Logs.Error("关闭数据库连接成功")

		if common.RunModeProd {
			common.Logs.Flush() // 将日志从缓冲区读出，写入到文件
		}

		common.Logs.Close()
	}()
	beego.Run()
}
