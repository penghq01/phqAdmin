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
	"server/common"
	"server/models"
	"strconv"
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

var (
	//不需要签名的路由
	noSignRouter map[string]bool = map[string]bool{
		"/admin-api/files/upload/img": true,
	}
)

func (this *Base) Prepare() {
	this.Uri = this.Ctx.Request.RequestURI
	this.AuthToken = this.Ctx.Input.Header("auth-token")
	if err := json.Unmarshal(this.Ctx.Input.RequestBody, &this.Params); err != nil {
		common.Logs.Error("参数解析错误=>%v", err)
	}
	if !noSignRouter[this.Uri] {
		ok := common.CheckParams(this.Ctx.Input.Header("sign"), this.Ctx.Input.RequestBody)
		if !ok {
			this.ServeError("非法数据", "")
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
	err, img:=this.UploadFile(false, "Excel", key, AllowExtMap,  false)
	return err,img.Src
}

//上传文件
func (this *Base) UploadFile(saveDateBases bool, fileType string, key string, allowExtMap map[string]bool,isUploadFileName bool) (error,models.Files) {
	resFile := models.Files{}
	classId, err := this.GetInt("class_id", 0)
	if err != nil {
		classId = 0
	}
	file, fileHeader, _ := this.GetFile(key)
	defer file.Close()
	if fileHeader.Size > (30 * 1024 * 1024) {
		return errors.New(fileType + "太大了"),resFile
	}
	ext := path.Ext(fileHeader.Filename)
	//验证后缀名是否符合要求
	if _, ok := allowExtMap[ext]; !ok {
		return errors.New(fileType + "格式不正确"),resFile
	}
	//创建目录
	resPath:=filepath.Join(common.UploadSavePath,"upload",time.Now().Format("2006/01/02/"))
	uploadDir:=filepath.Join(common.FileUploadDir,resPath)
	err = os.MkdirAll(uploadDir, 0666)
	if err != nil {
		return errors.New("上传失败（100）"),resFile
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
	resPath=filepath.Join("/",resPath,"/",fileName)
	resPath=strings.Replace(resPath, "\\", "/", -1)
	fpath :=filepath.Join(uploadDir , "/", fileName)
	err = this.SaveToFile(key, fpath)
	if err != nil {
		return errors.New("上传失败（101）"),resFile
	}
	resFile.ClassId = classId
	resFile.AddTime = time.Now().Unix()
	resFile.Src = resPath
	resFile.Label = fileHeader.Filename
	if saveDateBases {
		if err := resFile.Add(); err.Err == nil {
			return nil,resFile
		}
		if err := os.Remove(fpath); err != nil {
			common.Logs.Error("删除文件失败：%v", fpath)
		}
		return errors.New("上传失败"),resFile
	} else {
		return nil,resFile
	}
}



func (this *Base) jsonReturn(code int, msg interface{}, data interface{}) {
	this.Data["json"] = map[string]interface{}{"code": code, "msg": msg, "data": data}
	this.ServeJSON(true)
	this.StopRun()
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
