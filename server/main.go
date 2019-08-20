package main

import (
	"fmt"
	"github.com/astaxie/beego"
	"phqAdmin/server/common"
	_ "phqAdmin/server/init"
	_ "phqAdmin/server/routers"
)



func main() {
	defer func() {
		if err := common.DbEngine.Close(); err != nil {
			common.Log.Error(fmt.Sprintf("关闭数据库连接失败，%v", err))
		}
	}()
	beego.Run()
}
