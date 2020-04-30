package excel

import (
	"errors"
	"fmt"
	"github.com/360EntSecGroup-Skylar/excelize"
	"server/common"
	"strings"
	"time"
)

//string转任何类型
func (this *Excel) Import() error {
	//打开excel文件
	xlsx, err := excelize.OpenFile(this.ExcelFilePath)
	if err != nil {
		return errors.New(fmt.Sprintf("读取Excel文件失败，%v", err))
	}
	rows := xlsx.GetRows(this.ExcelTemplate.SheetName)
	this.TotalNum = len(rows) - 1
	if this.TotalNum <= 0 {
		return errors.New(fmt.Sprintf("没有获取到数据，%v", err))
	}
	db := common.DbEngine.NewSession()
	defer db.Close()
	for index, row := range rows {
		if index > 0 {
			params := make(map[string]interface{})
			for _, item := range this.ExcelTemplate.FieldDesc {
				switch {
				case item.DateTimeLayout != "":
					if item.FiledType == "int" || item.FiledType == "int64" {
						strTime, err := time.ParseInLocation(item.DateTimeLayout, strings.TrimSpace(row[item.CellIndex]), time.Local)
						if err != nil {
							return errors.New(fmt.Sprintf("日期转换失败，%v", err))
						}
						params[item.FieldName] = strTime.Unix()
					} else {
						params[item.FieldName] = strings.TrimSpace(row[item.CellIndex])
					}
					break
				case len(item.ActionFunc) > 0:
					for key, val := range item.ActionFunc {
						if row[item.CellIndex] == key {
							params[item.FieldName] = val
						}
					}
					break
				default:
					params[item.FieldName] = strings.TrimSpace(row[item.CellIndex])
					break
				}
				if item.Unique {
					db.Where("? = ?", item.FieldName, params[item.FieldName])
				}
			}
			ok, err := db.Table(this.ExcelTemplate.TableName).Exist()
			if err != nil {
				return errors.New("判断是否存在重数据失败，" + err.Error())
			}
			if ok {
				this.SkipNum++
			} else {
				row, err := db.Table(this.ExcelTemplate.TableName).Insert(params)
				if err != nil {
					return errors.New("导入数据失败，" + err.Error())
				}
				if row > 0 {
					this.ImportNum++
				}
			}
		}
	}
	this.ErrMsg = fmt.Sprintf("【导入完成】：共 %v 条数据，跳过导入 %v 条数据，成功导入 %v 条数据", this.TotalNum, this.SkipNum, this.ImportNum)
	return nil
}
