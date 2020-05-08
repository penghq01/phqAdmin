package main

import (
	"fmt"
	"github.com/astaxie/beego"
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
func main() {
	common.AppRunDir = getCurrentDirectory()
	fmt.Printf("▶ 当前运行目录：%v\n", common.AppRunDir)
	common.HtmlDir=beego.AppConfig.String("html_dir")
	common.ServerDir=beego.AppConfig.String("server_dir")
	rand.Seed(time.Now().UnixNano()) //初始化随机数种子
	routers.InitRoute()
	beego.Run()
}
