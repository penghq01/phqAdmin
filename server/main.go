package main

import (
	"phqAdmin/server/common"
	_ "phqAdmin/server/init"
	_ "phqAdmin/server/routers"
	"fmt"
	"github.com/astaxie/beego"
)

func main() {
	defer func() {
		if err:=common.DbEngine.Close();err!=nil{
			common.Log.Error(fmt.Sprintf("关闭数据库连接失败，%v",err));
		}
	}()
	beego.Run()
}

