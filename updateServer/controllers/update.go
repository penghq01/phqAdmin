package controllers

import (
	"archive/zip"
	"bytes"
	"golang.org/x/text/encoding/simplifiedchinese"
	"golang.org/x/text/transform"
	"io"
	"io/ioutil"
	"os"
	"os/exec"
	"path/filepath"
	"sort"
	"time"
	"updateServer/common"
)

type Update struct {
	Base
	SelectDir string //当前选择路径
	FileName string //当前操作文件名称
}

func (this *Update) Prepare() {
	this.Base.Prepare()
	this.FileName = common.ToString(this.Input("file_name"))
	this.SelectDir = filepath.Join(common.ToString(this.Input("dir_path")),"\\")
}
//获取路径
func (this *Update) Dir(){
	this.ServeSuccess("", map[string]interface{}{
		"html_dir":common.HtmlDir,
		"server_dir": common.ServerDir,
		"upload_dir": filepath.Join(common.AppRunDir, "upload"),
	})
}
//上传文件
func (this *Update) Upload() {
	this.SelectDir=filepath.Join(common.ToString(this.GetString("dir_path")),"\\")
	err,fileName:=this.UploadFile(this.SelectDir)
	if err!=nil{
		this.ServeError(err.Error(),"")
	}
	filePath:=filepath.Join(this.SelectDir,fileName)
	fileInfo, err := os.Stat(filePath)
	var fileSize int64=0
	if err == nil {
		fileSize=fileInfo.Size()
	}
	this.ServeSuccess("", map[string]interface{}{
		"key":       time.Now().Unix(),
		"is_dir":false,
		"file_name": fileName,
		"file_size": fileSize,
	})
}
//获取列表
func (this *Update) List() {
	list := make([]map[string]interface{}, 0)
	dirList := make(map[string]map[string]interface{})
	fileList:= make(map[string]map[string]interface{}, 0)
	var dirSortArr,fileSortArr []string
	ok, err := common.PathExists(this.SelectDir)
	if err == nil && ok {
		files, err := ioutil.ReadDir(this.SelectDir)
		if err == nil {
			for key, file := range files {
				if file.IsDir(){
					dirList[file.Name()]=map[string]interface{}{
						"key":       key,
						"is_dir":file.IsDir(),
						"file_name": file.Name(),
						"file_size": file.Size(),
					}
					dirSortArr=append(dirSortArr,file.Name())
				}else{
					fileList[file.Name()]=map[string]interface{}{
						"key":       key,
						"is_dir":file.IsDir(),
						"file_name": file.Name(),
						"file_size": file.Size(),
					}
					fileSortArr=append(fileSortArr,file.Name())
				}

			}
		}
	}
	sort.Strings(dirSortArr)
	sort.Strings(fileSortArr)
	for _,name:=range dirSortArr {
		list=append(list,dirList[name])
	}
	for _,name:=range fileSortArr {
		list=append(list,fileList[name])
	}
	this.ServeSuccess("", list)
}
//删除文件
func (this *Update) Del() {
	filePath := filepath.Join(this.SelectDir, this.FileName)
	ok, err := common.PathExists(filePath)
	if err == nil && ok {
		if err := os.RemoveAll(filePath); err == nil {
			this.ServeSuccess("删除成功", "")
		}else{
			this.ServeError("删除失败", "")
		}
	}else{
		this.ServeError("删除失败,文件不存在", "")
	}
}
//下载文件
func (this *Update) Download() {
	dbFilePath := filepath.Join(this.SelectDir, this.FileName)
	ok, _ := common.PathExists(dbFilePath)
	if !ok {
		this.ServeError("文件下载失败,文件不存在", "")
	}
	this.Ctx.Output.Download(dbFilePath, this.FileName)
}
//解压文件
func (this *Update) DeCompress() {
	dbFilePath := filepath.Join(this.SelectDir, this.FileName)
	ok, _ := common.PathExists(dbFilePath)
	if !ok {
		this.ServeError("文件解压失败,文件不存在", "")
	}
	reader, err := zip.OpenReader(dbFilePath)
	if err == nil {
		defer reader.Close()
		for _, file := range reader.File {
			if !file.FileInfo().IsDir() {
				rc, err := file.Open()
				if err != nil {
					this.ServeError("打开文件失败，错误："+err.Error(), "")
				}
				defer rc.Close()
				i:= bytes.NewReader([]byte(file.Name));
				decoder := transform.NewReader(i, simplifiedchinese.GB18030.NewDecoder())
				name,err:= ioutil.ReadAll(decoder)
				if err!=nil{
					this.ServeError("获取文件名称，错误："+err.Error(), "")
				}
				filename := filepath.Join(this.SelectDir,string(name))
				err = os.MkdirAll(filepath.Dir(filename), 0755)
				if err != nil {
					this.ServeError("创建目录失败，错误："+err.Error(), "")
				}
				w, err := os.Create(filename)
				if err != nil {
					this.ServeError("创建文件失败，错误："+err.Error(), "")
				}
				defer w.Close()
				_, err = io.Copy(w, rc)
				if err != nil {
					this.ServeError("复制文件失败，错误："+err.Error(), "")
				}
				w.Close()
				rc.Close()
			}
		}
		this.ServeSuccess("解压成功", "")
	}else{
		this.ServeError("打开压缩文件失败，错误："+err.Error(), "")
	}
}

//执行文件
func (this *Update) Run() {
	params:= struct {
		RunDir string `json:"run_dir"`
		RunFile string `json:"run_file"`
		Args []string `json:"args"`
	}{}
	this.AnalyseJson(&params)
	if params.RunFile==""{
		this.ServeError("请输入要执行的文件", "")
	}
	FilePath := filepath.Join(params.RunDir, params.RunFile)
	if params.RunDir!="" && params.RunFile!=""{
		ok, _ := common.PathExists(FilePath)
		if !ok {
			this.ServeError("执行文件失败,文件不存在，文件："+FilePath, "")
		}
	}
	cmd := exec.Command(FilePath,params.Args...)
	var out bytes.Buffer
	cmd.Stdout = &out
	cmd.Stderr = os.Stderr
	err:=cmd.Run()
	if err == nil {
		cmdRes:=out.String()
		isUTF8:=common.ValidUTF8(out.Bytes())
		if isUTF8{
		}else{
			cmdRes=common.ConvertByte2String(out.Bytes(),"GB18030")
		}
		this.ServeSuccess("执行成功",cmdRes)
	} else {
		this.ServeError("执行文件失败:"+err.Error(), "")
	}
}