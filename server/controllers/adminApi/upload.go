package adminApi

import (
	"crypto/md5"
	"fmt"
	"math/rand"
	"os"
	"path"
	"time"
)

type Upload struct {
	AdminBase
}

func (this *Upload) Prepare() {
	this.AdminBase.Prepare()
}

func (this *Upload) UploadImage(){
	f,fh,_:=this.GetFile("upload_img")
	defer f.Close()
	if fh.Size >(30*1024*1024){
		this.ServeError("图片太大了","")
	}
	ext:=path.Ext(fh.Filename)
	//验证后缀名是否符合要求
	var AllowExtMap map[string]bool = map[string]bool{
		".jpg":true,
		".jpeg":true,
		".png":true,
		".gif":true,
		".bmp":true,
	}
	if _,ok:=AllowExtMap[ext];!ok{
		this.ServeError("图片格式不正确","")
	}
	//创建目录
	uploadDir := "static/upload/" + time.Now().Format("2006/01/02/")
	err := os.MkdirAll( uploadDir , 777)
	if err != nil {
		this.ServeError("上传失败（100）","")
	}
	//构造文件名称
	rand.Seed(time.Now().UnixNano())
	randNum := fmt.Sprintf("%d", rand.Intn(9999)+1000 )
	hashName := md5.Sum( []byte( time.Now().Format("2006_01_02_15_04_05_") + randNum ) )

	fileName := fmt.Sprintf("%x",hashName) + ext
	fpath := uploadDir + fileName
	err = this.SaveToFile("upload_img", fpath)
	if err != nil {
		this.ServeError("上传失败（101）","")
	}
	this.ServeSuccess("上传成功",fpath)
}