package controllers

import (
	"crypto/md5"
	"encoding/json"
	"fmt"
	"github.com/astaxie/beego"
	"github.com/go-xorm/xorm"
	"math/rand"
	"os"
	"path"
	"phqAdmin/server/common"
	"phqAdmin/server/models"
	"strconv"
	"time"
)

type Base struct {
	beego.Controller
	Sign      string                 //前端传来的参数签名
	AuthToken string                 //token
	Params    map[string]interface{} //前端传来的参数
	Uri       string                 //访问uri
	Db        *xorm.Engine           //Orm引擎
	Paginate  common.Paginate        //分页数据
}

var (
	//不需要签名的路由
	noSignRouter map[string]bool = map[string]bool{
		"/admin-api/files/upload/img": true,
	}
)

func (this *Base) Prepare() {
	this.Db = common.DbEngine
	this.Uri = this.Ctx.Request.RequestURI
	this.AuthToken = this.Ctx.Input.Header("auth-token")
	if err := json.Unmarshal(this.Ctx.Input.RequestBody, &this.Params); err != nil {
		common.Log.Error(fmt.Sprintf("参数解析错误=>%v", err))
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
	//fmt.Println(string(this.Ctx.Input.RequestBody))
	err := json.Unmarshal(this.Ctx.Input.RequestBody, obj)
	if err != nil {
		this.ServeError("参数解析失败", "")
	}
}

//获取分页前端传来的数据
func (this *Base) GetPageParam() {
	var err error
	this.Paginate.Page, err = strconv.Atoi(this.Ctx.Input.Param(":page"))
	if err != nil {
		common.Log.Error(fmt.Sprintf("获取分页[Page]错误=>%v", err))
	}
	this.Paginate.PageSize, err = strconv.Atoi(this.Ctx.Input.Param(":pageszie"))
	if err != nil {
		common.Log.Error(fmt.Sprintf("获取分页[pageszie]错误=>%v", err))
	}
}

//获取参数，key为参数名称
func (this *Base) Input(key string) interface{} {
	if key == "" {
		return this.Params
	}
	return this.Params[key]
}
func (this *Base) UploadImg(key string) {
	var AllowExtMap map[string]bool = map[string]bool{
		".jpg":  true,
		".jpeg": true,
		".png":  true,
		".gif":  true,
		".bmp":  true,
	}
	this.uploadFile("图片", key, AllowExtMap)
}

//上传图片
func (this *Base) uploadFile(fileType string, key string, allowExtMap map[string]bool) {
	classId,err:=this.GetInt("class_id",0)
	if err!=nil{
		classId=0
	}
	file, fileHeader, _ := this.GetFile(key)
	defer file.Close()
	if fileHeader.Size > (30 * 1024 * 1024) {
		this.ServeError(fileType+"太大了", "")
	}
	ext := path.Ext(fileHeader.Filename)
	//验证后缀名是否符合要求
	if _, ok := allowExtMap[ext]; !ok {
		this.ServeError(fileType+"格式不正确", "")
	}
	//创建目录
	uploadDir := "static/upload/" + time.Now().Format("2006/01/02/")
	err = os.MkdirAll(uploadDir, 777)
	if err != nil {
		this.ServeError("上传失败（100）", "")
	}
	//构造文件名称
	rand.Seed(time.Now().UnixNano())
	randNum := fmt.Sprintf("%d", rand.Intn(9999)+1000)
	hashName := md5.Sum([]byte(time.Now().Format("2006_01_02_15_04_05_") + randNum))
	fileName := fmt.Sprintf("%x", hashName) + ext
	fpath := uploadDir + fileName
	err = this.SaveToFile(key, fpath)
	if err != nil {
		this.ServeError("上传失败（101）", "")
	}
	ft:=new(models.Files)
	ft.ClassId=classId;
	ft.AddTime=time.Now().Unix()
	ft.Src=fpath
	ft.Label=fileHeader.Filename
	if ok,_:=ft.Add();ok{
		this.ServeSuccess("上传成功", ft)
	}
	if err:=os.Remove(fpath);err!=nil{
		common.Log.Error(fmt.Sprintf("删除文件失败：%v",fpath));
	}
	this.ServeError("上传失败","")
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
