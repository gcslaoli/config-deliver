package controller

import (
	"runtime"

	"github.com/gogf/gf/v2/frame/g"
)

var (
	Index = cIndex{}
)

type cIndex struct{}

type IndexReq struct {
	g.Meta `path:"/" tags:"Index" method:"get" summary:"Index"`
}

type IndexRes struct {
	GOOS    string `json:"goos"`
	GOARCH  string `json:"goarch"`
	Version string `json:"version"`
}

func (c *cIndex) Index(ctx g.Ctx, req *IndexReq) (res *IndexRes, err error) {
	g.Log().Debugf(ctx, "received request: %+v", req)
	// 获取当前操作系统类型
	res = &IndexRes{
		GOOS:    runtime.GOOS,
		GOARCH:  runtime.GOARCH,
		Version: runtime.Version(),
	}
	return
}
