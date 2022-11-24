#!/bin/bash
# Usage: release-server.sh <version>
set -e

# Check if version is specified
if [ -z "$1" ]; then
    echo "Usage: release-server.sh <version>"
    exit 1
fi 

# Check if version is valid
if ! [[ "$1" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "Invalid version: $1, should be in format x.y.z"
    exit 1
fi

# 获取version
version=$1

# 获取 major.minor.patch
major=$(echo $version | cut -d. -f1)
minor=$(echo $version | cut -d. -f2)
patch=$(echo $version | cut -d. -f3)

# Check if version is already released
if git tag | grep -q "config-deliver-client/v$version"; then
    echo "Version config-deliver-client/v$version is already released"
    exit 1
fi

# Create tag
git tag -a "config-deliver-client/v$version" -m "config-deliver-client/v$version"

# Push tag
git push origin "config-deliver-client/v$version"




# 检测是否登录docker hub
docker login

# 编译并发布镜像
cd config-deliver-client
docker buildx build --platform linux/amd64,linux/arm64 \
    -t gcslaoli/config-deliver-client:latest \
    -t gcslaoli/config-deliver-client:$major \
    -t gcslaoli/config-deliver-client:$major.$minor \
    -t gcslaoli/config-deliver-client:$major.$minor.$patch \
    --push .