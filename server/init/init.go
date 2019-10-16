package init

import (
	"fmt"
	"github.com/astaxie/beego/config"
	"github.com/astaxie/beego/logs"
	_ "github.com/go-sql-driver/mysql"
	"github.com/go-xorm/xorm"
	"phqAdmin/server/common"
)

func init() {
	ServerInit()
}
func ServerInit() {
	fmt.Println("----------------启动初始化----------------")
	common.Log = logs.NewLogger()
	var err error
	//设置日志写出文件
	err = common.Log.SetLogger(logs.AdapterFile, `{"filename":"ServerRunLog.log"}`)
	if err != nil {
		common.Log.Error(fmt.Sprintf("设置日志写出文件失败，%v", err))
	}
	common.ConfigIni, err = config.NewConfig("ini", "conf/config.conf")
	if err != nil {
		common.Log.Error(fmt.Sprintf("读取[config.conf]配置文件失败，%v", err))
	}
	common.DbIni, err = config.NewConfig("ini", "conf/db.conf")
	if err != nil {
		common.Log.Error(fmt.Sprintf("读取[db.conf]配置文件失败，%v", err))
	}
	common.EncryptionString = common.ConfigIni.String("EncryptionStr") //获取密码加密字串
	if common.EncryptionString == "" {
		common.Log.Error("获取密码加密字串失败")
	}
	common.TokenKeyString = common.ConfigIni.String("TokenKey") //获取Token加密字串
	if common.TokenKeyString == "" {
		common.Log.Error("获取Token加密字串")
	}
	common.TokenExpiresAt = 60 * 60 * 24 * 7
	tokenEx, err := common.ConfigIni.Int64("TokenExp") //获取Token过期时间
	if err == nil {
		common.TokenExpiresAt = tokenEx
	} else {
		common.Log.Error(fmt.Sprintf("Token过期时间读取失败，%v", err))
	}
	common.DbEngine, err = xorm.NewEngine("mysql", fmt.Sprintf("%v:%v@(%v:%v)/%v?charset=%v", common.DbIni.String("user"), common.DbIni.String("pass"), common.DbIni.String("host"), common.DbIni.String("port"), common.DbIni.String("db"), common.DbIni.String("charset")))
	if err != nil {
		common.Log.Error(fmt.Sprintf("连接数据库失败，%v", err))
	}
	common.Log.Error("数据库连接成功")
	//common.DbEngine.ShowSQL(true)                     //则会在控制台打印出生成的SQL语句；
	//common.DbEngine.Logger().SetLevel(core.LOG_DEBUG) //则会在控制台打印调试及以上的信息
	fmt.Println("----------------初始化完成----------------")
}
