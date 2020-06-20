package boot

import (
	"fmt"
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/config"
	"github.com/astaxie/beego/logs"
	_ "github.com/go-sql-driver/mysql"
	"github.com/go-xorm/xorm"
	_ "github.com/mattn/go-sqlite3"
	"io/ioutil"
	"math/rand"
	"os"
	"path/filepath"
	"server/src/app/models/region"
	"server/src/auth"
	"server/src/app/models/mDefault"
	"server/src/common"
	"time"
	"xorm.io/core"
)

/*
获取程序运行路径
*/
func getCurrentDirectory() string {
	dir, err := filepath.Abs(filepath.Dir(os.Args[0]))
	if err != nil {
		common.Logs.Info("取运行目录失败")
	}
	return dir
}

//初始化日志
func logsInit() {
	//✖ ▶ ✔
	common.Logs = logs.NewLogger(10000) // 创建一个日志记录器，参数为缓冲区的大小
	runmode := beego.AppConfig.String("runmode")
	if runmode == "dev" {
		common.RunModeDev = true
	}
	if runmode == "prod" {
		common.RunModeProd = true
	}
	if runmode == "dev" {
		//开发模式
		err := common.Logs.SetLogger("console", "") // 设置日志记录方式：控制台记录
		if err != nil {
			common.Logs.Error("✖ 设置日志记录方式：【控制台记录】，设置失败，%v", err)
		}
		common.Logs.Info("▶ 当前日志模式为：控制台记录")
	} else {
		//生产模式
		// 设置配置文件
		jsonConfig := `{"filename" : "./logs/ServiceRunLogs.log","maxlines" : 5000,"maxsize"  : 20480}`
		err := common.Logs.SetLogger("file", jsonConfig) // 设置日志记录方式：本地文件记录
		if err != nil {
			common.Logs.Error("✖ 设置日志记录方式：【本地文件记录】，设置失败，%v", err)
		}
		common.Logs.Info("▶ 当前日志模式为：本地文件记录")
	}
	common.Logs.SetLevel(logs.LevelDebug) // 设置日志写入缓冲区的等级
	common.Logs.EnableFuncCallDepth(true) // 输出log时能显示输出文件名和行号（非必须）
	common.Logs.Async()                   //为了提升性能, 可以设置异步输出
}
func ServerInit() {
	logsInit()
	common.Logs.Info("▶ 初始化中……")
	common.AppRunDir = getCurrentDirectory()
	common.Logs.Info("▶ 当前运行目录：%v", common.AppRunDir)
	//✖ ▶ ✔
	rand.Seed(time.Now().UnixNano()) //初始化随机数种子
	//获取文件上传目录
	common.FileUploadDir = beego.AppConfig.String("file_upload_dir")
	if common.FileUploadDir == "" {
		common.FileUploadDir = common.AppRunDir
	}
	common.UploadSavePath = beego.AppConfig.String("upload_save_path")
	if common.UploadSavePath == "" {
		common.UploadSavePath = "/static/"
	}
	common.Logs.Info("▶ 文件上传目录：%v", filepath.FromSlash(common.FileUploadDir+common.UploadSavePath))
	var err error
	common.ConfigIni, err = config.NewConfig("ini", "conf/config.conf")
	if err != nil {
		common.Logs.Error("✖ 读取[config.conf]配置文件失败，%v", err)
	}
	common.DbIni, err = config.NewConfig("ini", "conf/db.conf")
	if err != nil {
		common.Logs.Error("✖ 读取[db.conf]配置文件失败，%v", err)
	}
	common.EncryptionString = common.ConfigIni.String("EncryptionStr") //获取密码加密字串
	if common.EncryptionString == "" {
		common.Logs.Error("✖ 获取密码加密字串失败")
	}
	common.TokenKeyString = common.ConfigIni.String("TokenKey") //获取Token加密字串
	if common.TokenKeyString == "" {
		common.Logs.Error("✖ 获取Token加密字串失败")
	}
	common.TokenExpiresAt = 60 * 60 * 24 * 7
	tokenEx, err := common.ConfigIni.Int64("TokenExp") //获取Token过期时间
	if err == nil {
		common.TokenExpiresAt = tokenEx
	} else {
		common.Logs.Error("✖ Token过期时间读取失败，%v", err)
	}
	common.SqlBakPathDir = filepath.Join(common.AppRunDir, common.DbIni.String("back_dir"))
	common.DbMode = common.DbIni.String("db_mode")
	sqlPath := ""
	if common.DbMode == "0" {
		//使用MySql数据库
		common.Logs.Info("▶ 当前数据库为：MySql")
		common.DbEngine, err = xorm.NewEngine("mysql", fmt.Sprintf("%v:%v@(%v:%v)/%v?charset=%v", common.DbIni.String("user"), common.DbIni.String("pass"), common.DbIni.String("host"), common.DbIni.String("port"), common.DbIni.String("db"), common.DbIni.String("charset")))
		if err != nil {
			common.Logs.Error("✖ 连接MySql数据库失败，%v", err)
		}
		sqlPath = filepath.Join(common.AppRunDir, "/conf/mysql")
	}
	if common.DbMode == "1" {
		//SQLite3
		common.Logs.Info("▶ 当前数据库为：SQLite3")
		dbDir := common.DbIni.String("db_dir")
		common.DbDir = filepath.Join(common.AppRunDir, dbDir)
		ok, err := common.PathExists(common.DbDir)
		if !ok {
			err = os.MkdirAll(common.DbDir, 0666)
			if err != nil {
				common.Logs.Error("创建数据目录失败,%v", err)
			}
		}
		dbPath := filepath.Join(common.DbDir, common.DbIni.String("db_file_name")) + ".sqlite"
		common.SqliteFilePath = dbPath
		common.DbEngine, err = xorm.NewEngine("sqlite3", dbPath)
		if err != nil {
			common.Logs.Error("✖ 连接SQLite3数据库失败，%v", err)
		}
		sqlPath = filepath.Join(common.AppRunDir, "/conf/sqlite")
	}

	common.Logs.Info("▶ 同步数据库……")
	err = common.DbEngine.Sync2(new(region.Province),new(region.City),new(region.Area),new(region.Street),new(region.Village),new(mDefault.Admin), new(mDefault.Auth), new(mDefault.FilesClass), new(mDefault.Files), new(mDefault.Icon), new(mDefault.Role), new(mDefault.Users), new(mDefault.Api))
	if err != nil {
		common.Logs.Error("✖ 同步数据库失败，%v", err)
	} else {
		common.Logs.Info("✔ 同步数据库完成")
	}
	TableSqlPaths, err := ioutil.ReadDir(sqlPath)
	if err == nil {
		for _, table := range TableSqlPaths {
			if !table.IsDir() {
				sqlName := table.Name()
				ext := filepath.Ext(sqlName)
				if ext == ".sql" {
				}
				strEnd := len(sqlName) - len(ext)
				tableName := sqlName[:strEnd]
				empty, err := common.DbEngine.IsTableEmpty(tableName)
				//fmt.Println("判断表["+tableName+"]是否为空",empty,err)
				if err == nil {
					if empty {
						common.Logs.Info("▶ 初始化表[%v]……", tableName)
						sqlPath := filepath.Join(sqlPath, sqlName)
						if _, err := common.DbEngine.ImportFile(sqlPath); err == nil {
							common.Logs.Info("✔ 表[%v]初始化完成", tableName)
						} else {
							common.Logs.Error("✖ 表[%v]初始化失败，%v", tableName, err)
						}
					}
				} else {
					common.Logs.Error("✖ 判断表[%v]是否为空，错误：%v", tableName, err)
				}
			}
		}
	} else {
		common.Logs.Error("✖ 获取初始化数据表列表失败，%v", err)
	}
	if common.RunModeDev {
		common.Logs.Info("▶ 当前运行模式为：开发模式")
		common.DbEngine.ShowSQL(true)                     //则会在控制台打印出生成的SQL语句；
		common.DbEngine.Logger().SetLevel(core.LOG_DEBUG) //则会在控制台打印调试及以上的信息
		common.Logs.Info("✔ 启用SQL语句输出")
	}
	if common.RunModeProd {
		common.Logs.Info("▶ 当前运行模式为：生产模式")
	}
	common.Logs.Info("▶ 开始初始化管理权限")
	auth.IntiAuth()
	common.Logs.Info("✔ 初始化完成◕‿◕")
}
