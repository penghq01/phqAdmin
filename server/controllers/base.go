package controllers

import (
	"phqAdmin/server/common"
	"encoding/json"
	"fmt"
	"github.com/astaxie/beego"
	"github.com/go-xorm/xorm"
	"strconv"
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

func (this *Base) Prepare() {
	this.Db = common.DbEngine
	this.Uri = this.Ctx.Request.RequestURI
	this.AuthToken = this.Ctx.Input.Header("auth-token")
	if err := json.Unmarshal(this.Ctx.Input.RequestBody, &this.Params); err != nil {
		common.Log.Error(fmt.Sprintf("参数解析错误=>%v", err))
	}
	ok := common.CheckParams(this.Ctx.Input.Header("sign"), this.Ctx.Input.RequestBody)
	if !ok {
		this.ServeError("非法数据", "")
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
