package adminApi

import (
	"fmt"
	"phqAdmin/server/common"
	Auth2 "phqAdmin/server/common/Auth"
	"phqAdmin/server/controllers"
	"phqAdmin/server/models"
)

type AdminBase struct {
	controllers.Base
	LoginUser *models.Admin //当前登录用户
	ActionModel models.IModels //当前访问的控制所操作模型
}

//初始化
func (this *AdminBase) Prepare() {
	this.Base.Prepare()
	this.CheckAuth()//判断是否有权限访问
}

func (this *AdminBase)CheckAuth(){

	if !Auth2.AdminNoLoginController[this.Uri] {
		if this.AuthToken == "" {
			this.ServeLOGIN("请登录后访问", "")
		}
		ok, _ := common.CheckToken(this.AuthToken, func(id int, username string) {
			var user *models.Admin = new(models.Admin)
			ok := user.IdUserNameGet(id, username)
			if !ok {
				this.ServeRELOGIN("管理员信息错误，请重登录登录", "")
			}
			this.LoginUser = user
		})
		if !ok {
			this.ServeRELOGIN("登录过期，重登录登录", "")
		}
		if !Auth2.AdminLoginController[this.Uri]{
			fmt.Println(this.LoginUser)
		}
	}
}

//上传图片
func (this *AdminBase) UploadImage() {
	this.UploadImg("upload_img")
}
//添加操作
func (this *AdminBase)Add(){
	this.AnalyseJson(this.ActionModel)
	ok,msg:=this.ActionModel.Add();
	if ok{
		this.ServeSuccess(msg,this.ActionModel)
	}
	this.ServeError(msg,"")
}
//获取列表
func (this *AdminBase)List(){
	list,ok,msg:=this.ActionModel.List();
	if ok{
		this.ServeSuccess(msg,list)
	}
	this.ServeError(msg,"")
}
//获取带分页的列表
func (this *AdminBase)PageList(){
	this.AnalyseJson(this.ActionModel)
	this.GetPageParam()
	pd:=new(common.PaginateData)
	ok,msg:=this.ActionModel.PageList(this.Paginate,pd);
	if ok{
		this.ServeSuccess(msg,pd)
	}
	this.ServeError(msg,"")
}
//删除
func (this *AdminBase)Del(){
	this.AnalyseJson(this.ActionModel)
	ok,msg:=this.ActionModel.Delete();
	if ok{
		this.ServeSuccess(msg,"")
	}
	this.ServeError(msg,"")
}
//修改
func (this *AdminBase)Edit(){
	this.AnalyseJson(this.ActionModel)
	ok,msg:=this.ActionModel.Edit();
	if ok{
		this.ServeSuccess(msg,this.ActionModel)
	}
	this.ServeError(msg,"")
}