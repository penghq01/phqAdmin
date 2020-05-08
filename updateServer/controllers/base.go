package controllers

import (
	"encoding/json"
	"errors"
	"github.com/astaxie/beego"
	"os"
	"path/filepath"
	"strings"
	"updateServer/common"
)

type Base struct {
	beego.Controller
	Sign      string                 //前端传来的参数签名
	AuthToken string                 //token
	Params    map[string]interface{} //前端传来的参数
	Uri       string                 //访问uri
	isUserLogin bool
}

func (this *Base) Prepare() {
	this.Uri = this.Ctx.Request.URL.Path
	this.AuthToken = this.Ctx.Input.Header("auth-token")
	RequestBody := this.Ctx.Input.RequestBody
	if len(RequestBody) > 0 {
		if err := json.Unmarshal(this.Ctx.Input.RequestBody, &this.Params); err != nil {
			common.Logs.Error("参数解析错误=>%v\n", err)
		}
	}
	if this.Uri!="/update/api/login"{
		this.CheckAuthToken() //根据Token判断是否登录
		if !this.isUserLogin{
			this.ServeLOGIN("您还没有登录，请登录后访问","")
		}
	}
}

//根据Token判断是否登录
func (this *Base) CheckAuthToken() {
	if this.AuthToken == "" {
		this.isUserLogin = false
	} else {
		ok, _ := common.CheckToken(this.AuthToken, func(id int, username string) {
			if id==1 && username=="root"{
				this.isUserLogin = true
			}else{
				this.isUserLogin = true
			}
		})
		if !ok {
			this.isUserLogin = false
		}
	}
}

//解析数据
func (this *Base) AnalyseJson(obj interface{}) {
	err := json.Unmarshal(this.Ctx.Input.RequestBody, obj)
	if err != nil {
		this.ServeError("参数解析失败,"+err.Error(), "")
	}
}

//获取参数，key为参数名称
func (this *Base) Input(key string) interface{} {
	if key == "" {
		return this.Params
	}
	return this.Params[key]
}

//上传文件
func (this *Base) UploadFile(uploadDir string) (error,string) {
	file, fileHeader, _ := this.GetFile("file_name")
	defer file.Close()
	//创建目录
	err := os.MkdirAll(uploadDir, 0666)
	if err != nil {
		return errors.New("上传失败,创建目录错误："+err.Error()), ""
	}
	fileName :=fileHeader.Filename
	uploadDir = strings.Replace(uploadDir, "\\", "/", -1)
	fpath := filepath.Join(uploadDir,fileName)

	err = this.SaveToFile("file_name", fpath)
	if err != nil {
		return errors.New("上传失败,保存文件错误："+err.Error()), ""
	}
	return nil,fileName
}

func (this *Base) jsonReturn(code int, msg interface{}, data interface{}) {
	Data:=map[string]interface{}{"code": code, "msg": msg, "data": data}
	this.ResultJson(Data)
}
func (this *Base) ServeSuccess(msg interface{}, data interface{}) {
	this.jsonReturn(common.HTTP_SUCCESS, msg, data)
}
func (this *Base) ServeError(msg interface{}, data interface{}) {
	this.jsonReturn(common.HTTP_ERROR, msg, data)
}
func (this *Base) ServeLOGIN(msg interface{}, data interface{}) {
	this.jsonReturn(common.HTTP_LOGIN, msg, data)
}
func (this *Base) ServeRELOGIN(msg interface{}, data interface{}) {
	this.jsonReturn(common.HTTP_RELOGIN, msg, data)
}
func (this *Base) ServeNOAUTH(msg interface{}, data interface{}) {
	this.jsonReturn(common.HTTP_NOAUTH, msg, data)
}
func  (this *Base)ResultJson(data interface{}){
	this.Data["json"] = data
	this.ServeJSON(true)
	this.StopRun()
}

func  (this *Base)ResultXml(data interface{}){
	this.Data["xml"] = data
	this.ServeXML()
	this.StopRun()
}