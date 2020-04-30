package excel

import (
	"encoding/json"
	"errors"
	"io/ioutil"
	"os"
	"server/common"
)

type Excel struct {
	IsRun         bool          //是否正在导入
	DbTableName   string        //要导入的表
	ExcelFilePath string        //excel文件路径
	TotalNum      int           //总单数据行数
	ImportNum     int           //已经导入数量
	SkipNum       int           //跳过导入的数据
	ErrMsg        string        //错误信息
	ExcelTemplate excelTemplate //模板
}

//模板
type excelTemplate struct {
	TableName string      `json:"table_name"` //要导入的数据库表
	SheetName string      `json:"sheet_name"` //excel工作表名称
	FieldDesc []fieldDesc `json:"field_desc"` //字段描述
}

//字段描述
type fieldDesc struct {
	FileNickName   string            `json:"file_nick_name"`   //字段别名
	FieldName      string            `json:"field_name"`       //字段名称
	Unique         bool              `json:"unique"`           //是否判断该字段是否存在，存在就不插入
	CellIndex      int               `json:"cell_index"`       //对应Excel单元格索引 从左到右 0开始
	FiledType      string            `json:"filed_type"`       //当前字段的基本类型 如 string ,int,int64,float32,等
	DateTimeLayout string            `json:"date_time_layout"` //时间类型模板 如 2006-01-02 15:04:05
	ActionFunc     map[string]interface{} `json:"action_func"`      //为json格式需要转换的数据，如 性别，0，未知 1是男，2是女
}

//初始化
func (this *Excel) Init(templatePath string) error {
	tem, err := ioutil.ReadFile(templatePath)
	if err != nil {
		return errors.New("读取模板文件失败，" + err.Error())
	}
	err = json.Unmarshal(tem,&this.ExcelTemplate)
	if err != nil {
		return errors.New("解析模板文件失败，" + err.Error())
	}
	return nil
}

//导入完成后，初始化数据
func (this *Excel) InitData() {
	this.IsRun = false
	this.TotalNum = 0
	this.ImportNum = 0
	this.SkipNum = 0
	//删除上传的excel文件
	err:= os.Remove(this.ExcelFilePath)
	if err!=nil{
		common.Logs.Error("删除导入的Excel文件失败，错误：%v，文件路径：%v",err,this.ExcelFilePath)
	}
}

func (this *Excel) GetResult() interface{} {
	return map[string]interface{}{
		"is_run":     this.IsRun,
		"total_num":  this.TotalNum,
		"import_num": this.ImportNum,
		"skip_num":   this.SkipNum,
		"err_msg":    this.ErrMsg,
	}
}
