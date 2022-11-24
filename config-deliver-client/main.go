package main

import (
	"github.com/gcslaoli/config-deliver/config-deliver-client/internal/cmd"
	"github.com/gogf/gf/v2/os/gctx"
)

func main() {
	cmd.Main.Run(gctx.New())
}
