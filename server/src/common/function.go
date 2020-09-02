package common

import (
	"crypto/md5"
	"encoding/base64"
	"encoding/hex"
	"errors"
	"github.com/dgrijalva/jwt-go"
	"io"
	"math"
	"os"
	"path/filepath"
	"strconv"
	"strings"
	"time"
	"unsafe"
)

//MD5加密
func Md5String(str string) string {
	m := md5.New()
	m.Write([]byte(str))
	return hex.EncodeToString(m.Sum(nil))
}

/*
判断文件或文件夹是否存在:
如果返回的错误为nil,说明文件或文件夹存在
如果返回的错误类型使用os.IsNotExist()判断为true,说明文件或文件夹不存在
如果返回的错误为其它类型,则不确定是否在存在
*/
func PathExists(path string) (bool, error) {
	_, err := os.Stat(path)
	if err == nil {
		return true, nil
	}
	if os.IsNotExist(err) {
		return false, nil
	}
	return false, err
}

//计算分页数据totalCount总记录条数
func (this *Paginate) CalcPaginate(totalCount int64) {
	if this.Page <= 0 {
		this.Page = 1
	}
	if this.PageSize <= 0 {
		this.PageSize = 10
	}
	this.Limit = int(this.PageSize)
	this.Start = int((this.Page - 1) * this.PageSize)
	this.TotalCount = totalCount
	this.TotalPage = int64(math.Ceil(float64(totalCount) / float64(this.PageSize)))
}

//密码加密函数
func PassWordEncryption(pass string) string {
	pass = EncryptionString + pass + EncryptionString
	return Md5String(pass)
}

//验证前端参数是否合法
func CheckParams(signs string, RequestBody []byte) bool {
	str := strings.Split(signs, ".")
	signTime := str[1]
	signStr := Md5String(base64.StdEncoding.EncodeToString([]byte(Md5String(signTime)+"."+base64.StdEncoding.EncodeToString(RequestBody)+"."+signTime))) + "." + signTime
	//fmt.Println("SIGN=>",signStr)
	if signStr == signs {
		return true
	} else {
		return false
	}
}

//生成新的TOKEN
func NewToken(id string, username string) (string, bool) {
	claims := &jwt.StandardClaims{
		NotBefore: int64(time.Now().Unix()),
		ExpiresAt: int64(time.Now().Unix() + TokenExpiresAt),
		Issuer:    "penghq",
		Id:        id,
		Subject:   username,
	}
	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)
	ss, err := token.SignedString([]byte(TokenKeyString))
	if err != nil {
		Logs.Error("生成Token错误：%v", err)
		return "", false
	}
	return ss, true
}

// 校验token是否有效
func CheckToken(tokenStr string, callback func(id int, username string)) (bool, string) {
	token, err := jwt.Parse(tokenStr, func(token *jwt.Token) (interface{}, error) {
		return []byte(TokenKeyString), nil
	})
	if err != nil {
		Logs.Error("Token验证错误：%v", err)
		return false, "您的令牌无效，请重新登录"
	}
	claim, ok := token.Claims.(jwt.MapClaims)
	if !ok {
		Logs.Error("Token解析失败")
		return false, "您的令牌无效，请重新登录"
	}
	//验证token，如果token被修改过则为false
	if !token.Valid {
		return false, "您的令牌无效，请重新登录"
	}
	//到期时间
	expStr := ToString(claim["exp"])
	var exp int64
	exp, err = strconv.ParseInt(expStr,10,64)
	if err != nil {
		exp = 0
	}
	if exp < time.Now().Unix(){
		return false, "您的令牌已经过期，请重新登录"
	}
	//id
	idstr := claim["jti"].(string)
	var id int
	id, err = strconv.Atoi(idstr)
	if err != nil {
		id = 0
	}
	callback(id, claim["sub"].(string))
	return true, ""
}

//所有类型转sring
func ToString(data interface{}) string {
	var res string = ""
	switch data.(type) {
	case string:
		res = data.(string)
		break
	case int:
		res = strconv.Itoa(data.(int))
		break
	case int64:
		res = strconv.FormatInt(data.(int64), 10)
		break
	case float32:
		res = strconv.FormatFloat(data.(float64), 'f', -1, 32)
		break
	case float64:
		res = strconv.FormatFloat(data.(float64), 'f', -1, 64)
		break
	case bool:
		res = strconv.FormatBool(data.(bool))
		break
	}
	return res
}

//字符串转Byte
func Str2Bytes(s string) []byte {
	x := (*[2]uintptr)(unsafe.Pointer(&s))
	h := [3]uintptr{x[0], x[1], x[1]}
	return *(*[]byte)(unsafe.Pointer(&h))
}

//Byte转字符串
func Bytes2Str(b []byte) string {
	return *(*string)(unsafe.Pointer(&b))
}

//复制文件，dstName要复制到的地方。srcName要复制的文件
func CopyFile(dstName, srcName string) (written int64, err error) {
	dstDir := filepath.Dir(dstName)
	ok, err := PathExists(dstDir)
	if !ok {
		err = os.MkdirAll(dstDir, 0666)
		if err != nil {
			return 0, errors.New("创建目录失败，" + err.Error())
		}
	}
	src, err := os.Open(srcName)
	if err != nil {
		return 0, errors.New("打开文件失败," + err.Error())
	}
	defer src.Close()

	dst, err := os.Create(dstName)
	if err != nil {
		return 0, errors.New("创建文件失败," + err.Error())
	}
	defer dst.Close()

	return io.Copy(dst, src)
}
