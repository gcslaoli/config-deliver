# 开发说明

## docker 镜像发布

1. 检查环境

```bash
docker buildx ls
```

如果不支持多架构，则安装

```bash
docker run --privileged --rm tonistiigi/binfmt --install all
```

如果没有 `builder`，则创建一个

```bash
docker buildx create --name mybuilder
docker buildx use mybuilder
docker buildx inspect --bootstrap
```

2. 构建镜像

```bash
./release-server.sh 1.0.0
```

```bash
./release-client.sh 1.0.0
```
