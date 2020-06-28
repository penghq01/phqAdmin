package controllers

import (
	"crypto/md5"
	"encoding/json"
	"errors"
	"fmt"
	"github.com/astaxie/beego"
	"math/rand"
	"os"
	"path"
	"path/filepath"
	"server/src/auth"
	"server/src/app/models/mDefault"
	"server/src/common"
	"strconv"
	"strings"
	"time"
)

type Base struct {
	beego.Controller
	Sign      string                 //前端传来的参数签名
	AuthToken string                 //token
	Params    map[string]interface{} //前端传来的参数
	Uri       string                 //访问uri
	Paginate  common.Paginate        //分页数据
}

func (this *Base) Prepare() {
	this.Uri = this.Ctx.Request.URL.Path
	this.AuthToken = this.Ctx.Input.Header("auth-token")
	RequestBody := this.Ctx.Input.RequestBody
	if len(RequestBody) > 0 {
		if err := json.Unmarshal(this.Ctx.Input.RequestBody, &this.Params); err != nil {
			common.Logs.Error("参数解析错误=>%v", err)
		}
	}
	this.CheckSign() //判断数据签名是否正确
}

//判断数据签名是否正确
func (this *Base) CheckSign() {
	if this.UriIsSign() {
		ok := common.CheckParams(this.Ctx.Input.Header("sign"), this.Ctx.Input.RequestBody)
		if !ok {
			this.ServeError("非法数据：数据签名不正确！", "")
		}
	}
}

//判断当前Uri是否需要签名
func (this *Base) UriIsSign() bool {
	noSignRouter := auth.GetNoSignDataApi()
	_, ok := noSignRouter[this.Uri]
	if ok {
		return false
	} else {
		uri := this.UriReplacePage(this.Uri)
		_, ok = noSignRouter[uri]
		return !ok
	}
}

//拆分访问URL包后两位替换未/:page_size/:page
func (this *Base) UriReplacePage(uri string) string {
	uriArr := strings.Split(uri, "/")
	arrLen := len(uriArr)
	if arrLen < 3 {
		return uri
	}
	uriArr[arrLen-1] = ":page"
	uriArr[arrLen-2] = ":page_size"
	return strings.Join(uriArr, "/")
}

//解析数据
func (this *Base) AnalyseJson(obj interface{}) {
	err := json.Unmarshal(this.Ctx.Input.RequestBody, obj)
	if err != nil {
		this.ServeError("参数解析失败,"+err.Error(), "")
	}
}

//获取分页前端传来的数据
func (this *Base) GetPageParam() {
	var err error
	params := this.Ctx.Input.Params()
	page := params[":page"]
	pageSize := params[":page_size"]
	//fmt.Println("page=",page,"pageszie=",pageSize)
	this.Paginate.Page, err = strconv.ParseInt(page, 10, 32)
	if err != nil {
		this.ServeError(fmt.Sprintf("页码转换错误=>%v", err), "")
		common.Logs.Error("页码转换错误=>%v", err)
	}
	this.Paginate.PageSize, err = strconv.ParseInt(pageSize, 10, 32)
	if err != nil {
		this.ServeError(fmt.Sprintf("每页条数转换错误=>%v", err), "")
		common.Logs.Error("每页条数转换错误=>%v", err)
	}
}

//获取参数，key为参数名称
func (this *Base) Input(key string) interface{} {
	if key == "" {
		return this.Params
	}
	return this.Params[key]
}

//上传图片
func (this *Base) UploadImg(key string) {
	var AllowExtMap map[string]bool = map[string]bool{
		".jpg":  true,
		".jpeg": true,
		".png":  true,
		".gif":  true,
		".bmp":  true,
	}
	err, img := this.UploadFile(true, "图片", key, AllowExtMap, false)
	if err == nil {
		this.ServeSuccess("上传成功", img)
	} else {
		this.ServeSuccess(err.Error(), "")
	}
}

//上传excel
func (this *Base) UploadExcel(key string) (err error, path string) {
	var AllowExtMap map[string]bool = map[string]bool{
		".xlsx": true,
	}
	err, img := this.UploadFile(false, "Excel", key, AllowExtMap, false)
	return err, img.Src
}

//上传文件
func (this *Base) UploadFile(saveDateBases bool, fileType string, key string, allowExtMap map[string]bool, isUploadFileName bool) (error, mDefault.Files) {
	resFile := mDefault.Files{}
	classId, err := this.GetInt("class_id", 0)
	if err != nil {
		classId = 0
	}
	file, fileHeader, _ := this.GetFile(key)
	defer file.Close()
	if fileHeader.Size > (30 * 1024 * 1024) {
		return errors.New(fileType + "太大了"), resFile
	}
	ext := path.Ext(fileHeader.Filename)
	//验证后缀名是否符合要求
	if _, ok := allowExtMap[ext]; !ok {
		return errors.New(fileType + "格式不正确"), resFile
	}
	//创建目录
	resPath := filepath.Join(common.UploadSavePath, "upload", time.Now().Format("2006/01/02/"))
	uploadDir := filepath.Join(common.FileUploadDir, resPath)
	err = os.MkdirAll(uploadDir, 0666)
	if err != nil {
		return errors.New("上传失败（100）"), resFile
	}
	fileName := ""
	if !isUploadFileName {
		//构造文件名称
		randNum := fmt.Sprintf("%d", rand.Intn(9999)+1000)
		hashName := md5.Sum([]byte(time.Now().Format("2006_01_02_15_04_05_") + randNum))
		fileName = fmt.Sprintf("%x", hashName) + ext
	} else {
		fileName = fileHeader.Filename
	}
	resPath = filepath.Join("/", resPath, "/", fileName)
	resPath = strings.Replace(resPath, "\\", "/", -1)
	fpath := filepath.Join(uploadDir, "/", fileName)
	err = this.SaveToFile(key, fpath)
	if err != nil {
		return errors.New("上传失败（101）"), resFile
	}
	resFile.ClassId = classId
	resFile.AddTime = time.Now().Unix()
	resFile.Src = resPath
	resFile.Label = fileHeader.Filename
	if saveDateBases {
		if err := resFile.Add(); err == nil {
			return nil, resFile
		}
		if err := os.Remove(fpath); err != nil {
			common.Logs.Error("删除文件失败：%v", fpath)
		}
		return errors.New("上传失败"), resFile
	} else {
		return nil, resFile
	}
}


func (this *Base) jsonReturn(code int, msg interface{}, data interface{}) {
	Data:=map[string]interface{}{"code": code, "msg": msg, "data": data}
	this.ResultJson(Data)
}
func (this *Base) ServeSuccess(msg string, data interface{},args ...interface{}) {
	this.jsonReturn(common.HTTP_SUCCESS, fmt.Sprintf(msg,args...), data)
}
func (this *Base) ServeError(msg string, data interface{},args ...interface{}) {
	this.jsonReturn(common.HTTP_ERROR,fmt.Sprintf(msg,args...), data)
}
func (this *Base) ServeLOGIN(msg string, data interface{},args ...interface{}) {
	this.jsonReturn(common.HTTP_LOGIN, fmt.Sprintf(msg,args...), data)
}

func (this *Base) ServeRELOGIN(msg string, data interface{},args ...interface{}) {
	this.jsonReturn(common.HTTP_RELOGIN, fmt.Sprintf(msg,args...), data)
}

func (this *Base) ServeNOAUTH(msg string, data interface{},args ...interface{}) {
	this.jsonReturn(common.HTTP_NOAUTH, fmt.Sprintf(msg,args...), data)
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
