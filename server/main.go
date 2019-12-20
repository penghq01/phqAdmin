package main

import (
	"github.com/astaxie/beego"
	"server/common"
	_ "server/init"
	_ "server/routers"
)

func main() {
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
