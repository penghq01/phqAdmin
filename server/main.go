package main

import (
	"github.com/astaxie/beego"
	"server/src/boot"
	"server/src/common"
	"server/src/routers"
)

func main() {
	boot.ServerInit()
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
	routers.InitRoute()
	beego.Run()
}
