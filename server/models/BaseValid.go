package models

import (
	"fmt"
	"github.com/astaxie/beego/validation"
)

type BaseVaild struct {
	valid validation.Validation
}

//不为空，即各个类型要求不为其零值
//felid 检测的字段
func (this *BaseVaild) Required(field interface{}, msgName string) (bool, string) {
	res := this.valid.Required(field, "")
	if !res.Ok {
		return false, fmt.Sprintf("%v不能为空", msgName)
	}
	return true, ""
}

//最小值，有效类型：int，其他类型都将不能通过验证
//felid 检测的字段
func (this *BaseVaild) Min(field interface{}, min int, msgName string) (bool, string) {
	res := this.valid.Min(field, min, "")
	if !res.Ok {
		return false, fmt.Sprintf("%v不能小于%v", msgName, min)
	}
	return true, ""
}

//最大值，有效类型：int，其他类型都将不能通过验证
//felid 检测的字段
func (this *BaseVaild) Max(field interface{}, max int, msgName string) (bool, string) {
	res := this.valid.Max(field, max, "")
	if !res.Ok {
		return false, fmt.Sprintf("%v不能大于%v", msgName, max)
	}
	return true, ""
}

//最大值，数值的范围，有效类型：int，他类型都将不能通过验证
//felid 检测的字段
func (this *BaseVaild) Range(field interface{}, min int, max int, msgName string) (bool, string) {
	res := this.valid.Range(field, min, max, "")
	if !res.Ok {
		return false, fmt.Sprintf("%v必须大于等于%v，小于等于%v", msgName, min, max)
	}
	return true, ""
}

//最小长度，有效类型：string slice，其他类型都将不能通过验证
//felid 检测的字段
func (this *BaseVaild) MinSize(field interface{}, len int, msgName string) (bool, string) {
	res := this.valid.MinSize(field, len, "")
	if !res.Ok {
		return false, fmt.Sprintf("%v最少%v字符", msgName, len)
	}
	return true, ""
}

//最大长度，有效类型：string slice，其他类型都将不能通过验证
//felid 检测的字段
func (this *BaseVaild) MaxSize(field interface{}, len int, msgName string) (bool, string) {
	res := this.valid.MaxSize(field, len, "")
	if !res.Ok {
		return false, fmt.Sprintf("%v最多%v字符", msgName, len)
	}
	return true, ""
}

//字符长度范围，有效类型：string slice，其他类型都将不能通过验证
//felid 检测的字段
func (this *BaseVaild) RangeSize(field interface{}, min int, max int, msgName string) (bool, string) {
	res := this.valid.MinSize(field, min, "")
	res2 := this.valid.MaxSize(field, max, "")
	if res.Ok && res2.Ok {
		return true, ""
	}
	return false, fmt.Sprintf("%v只能大于等于%v字符，小于等于%v字符", msgName, min, max)
}

//指定长度，有效类型：string slice，其他类型都将不能通过验证
//felid 检测的字段
func (this *BaseVaild) Length(field interface{}, len int, msgName string) (bool, string) {
	res := this.valid.Length(field, len, "")
	if !res.Ok {
		return false, fmt.Sprintf("%v必须是%v字符", msgName, len)
	}
	return true, ""
}

//alpha字符，有效类型：string，其他类型都将不能通过验证
//felid 检测的字段
func (this *BaseVaild) Alpha(field interface{}, msgName string) (bool, string) {
	res := this.valid.Alpha(field, "")
	if !res.Ok {
		return false, fmt.Sprintf("%v只能是alpha字符", msgName)
	}
	return true, ""
}

//数字，有效类型：string，其他类型都将不能通过验证
//felid 检测的字段
func (this *BaseVaild) Numeric(field interface{}, msgName string) (bool, string) {
	res := this.valid.Numeric(field, "")
	if !res.Ok {
		return false, fmt.Sprintf("%v只能是数字", msgName)
	}
	return true, ""
}

// alpha字符或数字，有效类型：string，其他类型都将不能通过验证
//felid 检测的字段
func (this *BaseVaild) AlphaNumeric(field interface{}, msgName string) (bool, string) {
	res := this.valid.AlphaNumeric(field, "")
	if !res.Ok {
		return false, fmt.Sprintf("%v只能是alpha字符或数字", msgName)
	}
	return true, ""
}

//  手机号，有效类型：string，其他类型都将不能通过验证
//felid 检测的字段
func (this *BaseVaild) Mobile(field interface{}) (bool, string) {
	res := this.valid.Mobile(field, "")
	if !res.Ok {
		return false, fmt.Sprintf("手机号不合法")
	}
	return true, ""
}

// Tel 固定电话号，有效类型：string，其他类型都将不能通过验证
//felid 检测的字段
func (this *BaseVaild) Tel(field interface{}) (bool, string) {
	res := this.valid.Tel(field, "")
	if !res.Ok {
		return false, fmt.Sprintf("固定电话号不合法")
	}
	return true, ""
}

// Phone 手机号或固定电话号，有效类型：string，其他类型都将不能通过验证
//felid 检测的字段
func (this *BaseVaild) Phone(field interface{}) (bool, string) {
	res := this.valid.Phone(field, "")
	if !res.Ok {
		return false, fmt.Sprintf("手机号或固定电话号不合法")
	}
	return true, ""
}
