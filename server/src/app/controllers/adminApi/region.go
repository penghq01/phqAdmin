package adminApi

import (
	"server/src/app/models/region"
)

//行政区划
type Region struct {
	AdminBase
}
func (this *Region) Prepare() {
	this.ActionModel = new(region.Region)
	this.AdminBase.Prepare()
}