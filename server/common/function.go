package common

import (
	"crypto/md5"
	"encoding/base64"
	"encoding/hex"
	"fmt"
	"github.com/dgrijalva/jwt-go"
	"math"
	"strconv"
	"strings"
	"time"
)

//MD5加密
func Md5String(str string) string {
	m := md5.New()
	m.Write([]byte(str))
	return hex.EncodeToString(m.Sum(nil))
}

//计算分页数据totalCount总记录条数
func (this *Paginate) CalcPaginate(totalCount int) {
	if this.Page <= 0 {
		this.Page = 1
	}
	if this.PageSize <= 0 {
		this.PageSize = 10
	}
	this.Limit = this.PageSize
	this.Start = (this.Page - 1) * this.PageSize
	this.TotalCount = totalCount
	this.TotalPage = int(math.Ceil(float64(totalCount) / float64(this.PageSize)))
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
		Log.Error(fmt.Sprintf("生成Token错误：%v", err))
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
		Log.Error(fmt.Sprintf("Token验证错误：%v", err))
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
