# 开发说明

## docker 镜像发布

1. 检查环境

```bash
docker buildx ls
```

如果没有 `builder`，则创建一个

```bash
docker buildx create --name mybuilder
docker buildx use mybuilder
docker buildx inspect --bootstrap
```

如果不支持多架构，则安装

```bash
docker run --privileged --rm tonistiigi/binfmt --install all
```

2. 构建镜像

```bash
docker buildx build --platform linux/amd64,linux/arm64 -t gcslaoli/config-deliver-server:latest --push .
```
