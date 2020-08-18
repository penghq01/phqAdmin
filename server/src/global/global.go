package global

import (
	"server/src/app/models/mDefault"
)

var (
	LoginAdminMap    map[int]mDefault.Admin //登录的管理员内存缓存
)

func init() {
	LoginAdminMap = make(map[int]mDefault.Admin )
}
