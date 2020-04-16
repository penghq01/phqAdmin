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
	"server/acc"
	"server/common"
	"server/models"
	"time"
)

type Admin struct {
	AdminBase
}

func (this *Admin) Prepare() {
	this.ActionModel = new(models.Admin)
	this.AdminBase.Prepare()
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
	user := models.Admin{
		Password: newPass,
	}
	if row, err := common.DbEngine.Where("admin_id=?", this.LoginUser.AdminId).Update(user); row > 0 && err == nil {
		this.ServeSuccess("密码修改成功", "")
	}
	this.ServeError("密码修改失败", "")
}

//获取前端导航列表
func (this *Admin) AuthList() {
	this.ServeSuccess("", acc.GetLoginAdminRoute(this.LoginUser))
}

//获取可操作的权限列表（控制UI显示隐藏）
func (this *Admin) ActionAuthList() {
	this.ServeSuccess("", acc.GetLoginAdminUIDataApi(this.LoginUser))
}

//获取备份文件列表
func (this *Admin) ListSql() {
	list := make([]map[string]interface{}, 0)
	ok, err := common.PathExists(common.SqlBakPathDir)
	if err == nil && ok {
		files, err := ioutil.ReadDir(common.SqlBakPathDir)
		if err == nil {
			for key, file := range files {
				ext:=path.Ext(file.Name())
				isAdd:=false
				if common.DbMode == "0" && ext==".sql"{
					isAdd=true
				}else if common.DbMode == "1" && ext==".bak"{
					isAdd=true
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
	ok, _:= common.PathExists(dbFilePath)
	if !ok {
		this.ServeError("数据恢复失败,要恢复的备份文件不存在", "")
	}
	extStr:=path.Ext(dbFilePath)
	if common.DbMode == "1" {
		if extStr!=".bak"{
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
	} else if common.DbMode == "0"{
		if extStr!=".sql"{
			this.ServeError("数据恢复失败，该文件为sqlit3数据备份文件，当前使用数据为mysql", "")
		}
		_,err:=common.DbEngine.ImportFile(dbFilePath)
		if err == nil{
			this.ServeSuccess("数据恢复成功", "")
		}else{
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
		filePath := filepath.Join( common.SqlBakPathDir, name)
		args := []string{
			fmt.Sprintf("-h%v",common.DbIni.String("host")),
			fmt.Sprintf("-u%v",common.DbIni.String("user")),
			fmt.Sprintf("-P%v",common.DbIni.String("port")),
			fmt.Sprintf("-p%v",common.DbIni.String("pass")),
			"--add-drop-table",
			common.DbIni.String("db"),
		}
		cmd := exec.Command(filepath.Join(common.AppRunDir, "conf/tool/mysqldump.exe"), args...)
		var out bytes.Buffer
		cmd.Stdout = &out
		cmd.Stderr = os.Stderr
		err = cmd.Start()
		if err != nil {
			this.ServeError("[0100]备份失败，"+err.Error(), "")
		}
		err = cmd.Wait()
		if err != nil {
			this.ServeError("[0101]备份失败，"+err.Error(), "")
		}
		f, err := os.Create(filePath)
		if err != nil {
			this.ServeError("创建备份文件失败，"+err.Error(), "")
		}
		defer func() {
			_ = f.Close()
		}()
		num, err := f.Write(out.Bytes())
		if err != nil {
			this.ServeError("写入备份内容失败，"+err.Error(), "")
		}
		res := map[string]interface{}{
			"key":       time.Now().UnixNano(),
			"file_name": name,
			"file_size": num,
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
