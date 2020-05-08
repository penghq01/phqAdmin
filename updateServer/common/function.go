package common

import (
	"crypto/md5"
	"encoding/hex"
	"errors"
	"fmt"
	"github.com/dgrijalva/jwt-go"
	"golang.org/x/text/encoding/simplifiedchinese"
	"io"
	"os"
	"path/filepath"
	"strconv"
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

//获取登录密码 penghq**99*9-update
func GetPassWordEncryption() string {
	return PassWordEncryption("fd87b67fe6bd6333ef6115031340e6ea")
}

//密码加密函数
func PassWordEncryption(pass string) string {
	pass = "PHQ" + pass + "ADMIN-UPDATE"
	return Md5String(pass)
}

//生成新的TOKEN
func NewToken() (string, bool) {
	claims := &jwt.StandardClaims{
		NotBefore: int64(time.Now().Unix()),
		ExpiresAt: int64(time.Now().Unix() + 604800),
		Issuer:    "penghq",
		Id:        "1",
		Subject:   "root",
	}
	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)
	ss, err := token.SignedString([]byte("08fbf3602c1400c3a09125c26ee3fc7d8290f5cc500adc9ad8c0cc75adde2d8bb12f0d2b11b02b02f0eecf1094f3eb5e081597fb41756fe696df51ab45bf5114"))
	if err != nil {
		fmt.Printf("生成Token错误：%v\n", err)
		return "", false
	}
	return ss, true
}

// 校验token是否有效
func CheckToken(tokenStr string, callback func(id int, username string)) (bool, string) {
	token, err := jwt.Parse(tokenStr, func(token *jwt.Token) (interface{}, error) {
		return []byte("08fbf3602c1400c3a09125c26ee3fc7d8290f5cc500adc9ad8c0cc75adde2d8bb12f0d2b11b02b02f0eecf1094f3eb5e081597fb41756fe696df51ab45bf5114"), nil
	})
	if err != nil {
		fmt.Printf("Token验证错误：%v\n", err)
		return false, "Token验证失败"
	}
	claim, ok := token.Claims.(jwt.MapClaims)
	if !ok {
		return false, "Token解析失败"
	}
	//验证token，如果token被修改过则为false
	if !token.Valid {
		return false, "Token错误"
	}
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

type Charset string

const (
	UTF8    = Charset("UTF-8")
	GB18030 = Charset("GB18030")
)
//转成UTF-8的编码
func ConvertByte2String(byte []byte, charset Charset) string {
	var str string
	switch charset {
	case GB18030:
		var decodeBytes, _ = simplifiedchinese.GB18030.NewDecoder().Bytes(byte)
		str = string(decodeBytes)
	case UTF8:
		fallthrough
	default:
		str = string(byte)
	}
	return str
}

//判断字符串是否是UTF8
func ValidUTF8(buf []byte) bool{
	nBytes := 0
	for _,b:=range buf{
		if nBytes == 0{
			if (b & 0x80) != 0 {  //与操作之后不为0，说明首位为1
				for (b & 0x80) != 0 {
					b <<= 1 //左移一位
					nBytes++ //记录字符共占几个字节
				}
				if nBytes < 2 || nBytes > 6 { //因为UTF8编码单字符最多不超过6个字节
					return false
				}
				nBytes-- //减掉首字节的一个计数
			}
		}else{ //处理多字节字符
			if b & 0xc0 != 0x80{ //判断多字节后面的字节是否是10开头
				return false
			}
			nBytes--
		}
	}
	return nBytes == 0
}
