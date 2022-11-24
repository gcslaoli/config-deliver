#!/bin/bash

set -e

# 检测是否登录docker hub
docker login

# 编译并发布镜像
cd config-deliver-server
docker buildx build --platform linux/amd64,linux/arm64 -t gcslaoli/config-deliver-server:latest --push .