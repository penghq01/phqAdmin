package main

import (
	"fmt"
	"github.com/astaxie/beego"
	"os"
	"path/filepath"
	"phqAdmin/server/common"
	_ "phqAdmin/server/init"
	_ "phqAdmin/server/routers"
	"strings"
)
/*
获取程序运行路径
*/
func getCurrentDirectory() string {
	dir, err := filepath.Abs(filepath.Dir(os.Args[0]))
	if err != nil {
		common.Log.Info("取运行目录失败")
	}
	return strings.Replace(dir, "\\", "/", -1)
}
func main() {
	common.AppRunDir=getCurrentDirectory()
	common.SqlPathDir=filepath.Join(common.AppRunDir,"sql-bak")
	defer func() {
		if err := common.DbEngine.Close(); err != nil {
			common.Log.Error(fmt.Sprintf("关闭数据库连接失败，%v", err))
		}
		common.Log.Error("关闭数据库连接成功")
	}()
	common.Log.Info("服务启动成功")
	beego.Run()
}
