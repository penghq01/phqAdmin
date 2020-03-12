package adminApi

import (
	"fmt"
	"io/ioutil"
	"os"
	"path/filepath"
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
func (this *Admin) AuthList() {
	if ok, resData := this.GetUserAuthMenu(); ok {
		this.ServeSuccess("", resData)
	}
	this.ServeLOGIN("获取菜单失败，请重新登录", "")
}

//sql文件列表
func (this *Admin) ListSql() {
	list := make([]map[string]interface{}, 0)
	ok, err := common.PathExists(common.SqlPathDir)
	if err == nil && ok {
		files, err := ioutil.ReadDir(common.SqlPathDir)
		if err == nil {
			for key, file := range files {
				list = append(list, map[string]interface{}{
					"key":       key,
					"file_name": file.Name(),
					"file_size": file.Size(),
				})
			}
		}
	}
	this.ServeSuccess("", list)
}

//导入sql
func (this *Admin) ImportSqL() {
	name := common.ToString(this.Input("file_name"))
	filePath := filepath.Join(common.SqlPathDir, name)
	ok, err := common.PathExists(filePath)
	if err == nil && ok {
		md := models.Models{}
		err = md.DeleteAllTable()
		if err == nil {
			if result, err := common.DbEngine.ImportFile(filePath); err == nil {
				this.ServeSuccess("数据恢复成功", result)
			} else {
				this.ServeError("数据恢复失败，"+err.Error(), "")
			}
		} else {
			this.ServeError("数据恢复失败，数据可能丢失,"+err.Error(), "")
		}
	} else {
		this.ServeError("数据恢复失败,要恢复的sql文件不存在", "")
	}
}

//导出sql
func (this *Admin) ExportSqL() {
	name := fmt.Sprintf("%v-backups.sql", time.Now().Format("2006-01-02-15-04-05"))
	filePath := filepath.Join(common.SqlPathDir, name)
	ok, err := common.PathExists(common.SqlPathDir)
	if !ok {
		err = os.MkdirAll(common.SqlPathDir, 0666)
		if err != nil {
			this.ServeError("创建备份数据目录失败,"+err.Error(), "")
		}
	}

	file, err := os.Create(filePath)
	defer file.Close()
	if err != nil {
		this.ServeError("创建备份数据文件失败,"+err.Error(), "")
	}
	if err := common.DbEngine.DumpAll(file); err == nil {
		var size int64
		_ = filepath.Walk(filePath, func(path string, f os.FileInfo, err error) error {
			size = f.Size()
			return nil
		})
		res := map[string]interface{}{
			"key":       time.Now().UnixNano(),
			"file_name": name,
			"file_size": size,
		}
		this.ServeSuccess("数据备份成功", res)
	} else {
		this.ServeError("数据备份失败,"+err.Error(), "")
	}

}

//删除sql
func (this *Admin) DelSqL() {
	name := common.ToString(this.Input("file_name"))
	filePath := filepath.Join(common.SqlPathDir, name)
	ok, err := common.PathExists(filePath)
	if err == nil && ok {
		if err := os.Remove(filePath); err == nil {
			this.ServeSuccess("删除成功", "")
		}
	}
	this.ServeError("删除失败", "")
}
