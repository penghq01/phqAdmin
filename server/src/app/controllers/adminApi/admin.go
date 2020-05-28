package adminApi

import (
	"bytes"
	"fmt"
	"github.com/go-xorm/xorm"
	"io/ioutil"
	"os"
	"os/exec"
	"path"
	"path/filepath"
	"runtime"
	"server/src/auth"
	"server/src/app/models"
	"server/src/app/models/mDefault"
	"server/src/common"
	"time"
)

type Admin struct {
	AdminBase
}

func (this *Admin) Prepare() {
	this.ActionModel = new(mDefault.Admin)
	this.AdminBase.Prepare()
}

//删除
func (this *Admin) Del() {
	model := new(mDefault.Admin)
	this.AnalyseJson(model)
	if model.AdminId == 1 {
		this.ServeError("您没有权限删除该管理员", "")
	}
	if model.AdminId==2{
		this.ServeError("您没有权限删除该管理员", "")
	}
	if model.AdminId == this.LoginUser.AdminId {
		this.ServeError("您没有权限删除自己", "")
	}
	res := model.Delete()
	if res.Err == nil {
		this.ServeSuccess(res.Msg, "")
	}
	this.ServeError(res.Msg, "")
}

//修改
func (this *Admin) Edit() {
	model := new(mDefault.Admin)
	this.AnalyseJson(model)
	if model.AdminId == 1 {
		this.ServeError("您没有权限修改该管理员", "")
	}
	if model.AdminId == 2 && this.LoginUser.AdminId>1{
		this.ServeError("您没有权限修改该管理员", "")
	}
	if model.AdminId == this.LoginUser.AdminId {
		this.ServeError("您没有权限修改自己", "")
	}
	res := model.Edit()
	if res.Err == nil {
		this.ServeSuccess(res.Msg, model)
	}
	this.ServeError(res.Msg, "")
}

//列表
func (this *Admin) List() {
	list := make([]mDefault.Admin, 0)
	err := models.Find(new(mDefault.Admin), func(db *xorm.Session) error {
		db.Where("admin_id <> ?", this.LoginUser.AdminId)
		if this.LoginUser.AdminId == 1 {
			db.Where("admin_id > 1")
		} else if this.LoginUser.AdminId > 1 {
			db.Where("admin_id > 2")
		}
		return db.Omit("password").Find(&list)
	})
	if err.Err == nil {
		this.ServeSuccess("", list)
	}
	this.ServeError(err.Msg, "")
}

func (this *Admin) Info() {
	user := this.LoginUser
	user.Password = ""
	this.ServeSuccess("", user)
}
func (this *Admin) EditPass() {
	old := this.Params["old"].(string)
	newPass := this.Params["new"].(string)
	old = common.PassWordEncryption(old)
	newPass = common.PassWordEncryption(newPass)
	if old != this.LoginUser.Password {
		this.ServeError("旧密码不正确", "")
	}
	user := mDefault.Admin{
		Password: newPass,
	}
	if row, err := common.DbEngine.Where("admin_id=?", this.LoginUser.AdminId).Update(user); row > 0 && err == nil {
		this.ServeSuccess("密码修改成功", "")
	}
	this.ServeError("密码修改失败", "")
}

//获取前端导航列表
func (this *Admin) AuthList() {
	this.ServeSuccess("", auth.GetLoginAdminRoute(this.LoginUser))
}

//获取可操作的权限列表（控制UI显示隐藏）
func (this *Admin) ActionAuthList() {
	this.ServeSuccess("", auth.GetLoginAdminUIDataApi(this.LoginUser))
}

//获取备份文件列表
func (this *Admin) ListSql() {
	list := make([]map[string]interface{}, 0)
	ok, err := common.PathExists(common.SqlBakPathDir)
	if err == nil && ok {
		files, err := ioutil.ReadDir(common.SqlBakPathDir)
		if err == nil {
			for key, file := range files {
				ext := path.Ext(file.Name())
				isAdd := false
				if common.DbMode == "0" && ext == ".sql" {
					isAdd = true
				} else if common.DbMode == "1" && ext == ".bak" {
					isAdd = true
				}
				if isAdd {
					list = append(list, map[string]interface{}{
						"key":       key,
						"file_name": file.Name(),
						"file_size": file.Size(),
					})
				}
			}
		}
	}
	this.ServeSuccess("", list)
}

//恢复数据备份
func (this *Admin) ImportSqL() {
	name := common.ToString(this.Input("file_name"))
	dbFilePath := filepath.Join(common.SqlBakPathDir, name)
	ok, _ := common.PathExists(dbFilePath)
	if !ok {
		this.ServeError("数据恢复失败,要恢复的备份文件不存在", "")
	}
	extStr := path.Ext(dbFilePath)
	if common.DbMode == "1" {
		if extStr != ".bak" {
			this.ServeError("数据恢复失败，该文件为mysql数据备份文件，当前使用数据为sqlit3", "")
		}
		err := common.DbEngine.Close()
		if err != nil {
			this.ServeError("数据恢复失败，关闭数据库失败："+err.Error(), "")
		}
		newName := time.Now().Format("2006-01-02-15-04-05") + filepath.Ext(common.SqliteFilePath)

		err = os.Rename(common.SqliteFilePath, filepath.Join(common.DbDir, newName))
		if err != nil {
			this.ServeError("数据恢复失败，请重新启动服务，命名文件失败："+err.Error(), "")
		}
		num, err := common.CopyFile(common.SqliteFilePath, dbFilePath)
		if err == nil && num > 0 {
			common.DbEngine, err = xorm.NewEngine("sqlite3", common.SqliteFilePath)
			if err == nil {
				this.ServeSuccess("数据恢复成功", "")
			} else {
				common.Logs.Error("数据恢复失败：连接SQLite3数据库失败，请重新启动服务，%v", err)
			}
		} else {
			this.ServeSuccess("数据恢复失败，请重新启动服务", "")
		}
	} else if common.DbMode == "0" {
		if extStr != ".sql" {
			this.ServeError("数据恢复失败，该文件为sqlit3数据备份文件，当前使用数据为mysql", "")
		}

		sqlFile, err := os.Open(dbFilePath)
		if err != nil {
			this.ServeError("数据恢复失败，读取数据库备份文件失败"+err.Error(), "")
		}
		defer func() {
			_ = sqlFile.Close()
		}()
		args := []string{
			fmt.Sprintf("-h%v", common.DbIni.String("host")),
			fmt.Sprintf("-u%v", common.DbIni.String("user")),
			fmt.Sprintf("-P%v", common.DbIni.String("port")),
			fmt.Sprintf("-p%v", common.DbIni.String("pass")),
			common.DbIni.String("db"),
		}
		toolPath := "conf/tool/mysqldump.exe"
		if runtime.GOOS == "linux" {
			toolPath = "conf/tool/mysqldump"
		}
		cmd := exec.Command(filepath.Join(common.AppRunDir, toolPath), args...)
		var out bytes.Buffer
		cmd.Stdin = sqlFile
		cmd.Stdout = &out
		cmd.Stderr = os.Stderr
		err = cmd.Run()
		if err == nil {
			this.ServeSuccess("数据恢复成功", "")
		} else {
			this.ServeError("数据恢复失败:"+err.Error(), "")
		}

	}
}

//备份数据库数据
func (this *Admin) ExportSqL() {
	if common.DbMode == "1" {
		name := fmt.Sprintf("%v-backups.bak", time.Now().Format("2006-01-02-15-04-05"))
		filePath := filepath.Join(common.SqlBakPathDir, name)
		ok, err := common.PathExists(common.SqliteFilePath)
		if !ok {
			this.ServeError("数据备份失败,数据库文件不存在", "")
		}
		num, err := common.CopyFile(filePath, common.SqliteFilePath)
		if err == nil {
			res := map[string]interface{}{
				"key":       time.Now().UnixNano(),
				"file_name": name,
				"file_size": num,
			}
			this.ServeSuccess("数据备份成功", res)
		} else {
			this.ServeError("创建备份数据文件失败："+err.Error(), "")
		}
	} else if common.DbMode == "0" {
		name := fmt.Sprintf("%v-backups.sql", time.Now().Format("2006-01-02-15-04-05"))
		ok, err := common.PathExists(common.SqlBakPathDir)
		if !ok {
			err = os.MkdirAll(common.SqlBakPathDir, 0666)
			if err != nil {
				this.ServeError("创建备份目录失败，"+err.Error(), "")
			}
		}
		filePath := filepath.Join(common.SqlBakPathDir, name)
		sqlFile, err := os.Create(filePath)
		if err != nil {
			this.ServeError("创建备份文件失败，"+err.Error(), "")
		}
		defer func() {
			_ = sqlFile.Close()
		}()
		args := []string{
			fmt.Sprintf("-h%v", common.DbIni.String("host")),
			fmt.Sprintf("-u%v", common.DbIni.String("user")),
			fmt.Sprintf("-P%v", common.DbIni.String("port")),
			fmt.Sprintf("-p%v", common.DbIni.String("pass")),
			"--add-drop-table",
			common.DbIni.String("db"),
		}

		toolPath := "conf/tool/mysqldump.exe"
		if runtime.GOOS == "linux" {
			toolPath = "conf/tool/mysqldump"
		}

		cmd := exec.Command(filepath.Join(common.AppRunDir, toolPath), args...)
		cmd.Stdout = sqlFile
		cmd.Stderr = os.Stderr
		err = cmd.Run()
		if err != nil {
			this.ServeError("数据备份失败，"+err.Error(), "")
		}

		fileInfo, err := os.Stat(filePath)
		var fileSize int64 = 0
		if err == nil {
			fileSize = fileInfo.Size()
		}

		res := map[string]interface{}{
			"key":       time.Now().UnixNano(),
			"file_name": name,
			"file_size": fileSize,
		}

		this.ServeSuccess("数据备份成功", res)
	}
}

//删除备份
func (this *Admin) DelSqL() {
	name := common.ToString(this.Input("file_name"))
	filePath := filepath.Join(common.SqlBakPathDir, name)
	ok, err := common.PathExists(filePath)
	if err == nil && ok {
		if err := os.Remove(filePath); err == nil {
			this.ServeSuccess("删除成功", "")
		}
	}
	this.ServeError("删除失败", "")
}

//备份下载
func (this *Admin) DownloadSql() {
	name := common.ToString(this.Input("file_name"))
	dbFilePath := filepath.Join(common.SqlBakPathDir, name)
	ok, _ := common.PathExists(dbFilePath)
	if !ok {
		this.ServeError("备份下载失败,备份文件不存在", "")
	}
	this.Ctx.Output.Download(dbFilePath, name)
}
