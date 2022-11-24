# config-deliver

## 项目介绍

工作中经常会遇到需要将配置文件分发到各个服务器的情况，这个项目就是为了解决这个问题而诞生的。目前本项目在作者的工作中主要用于分发域名证书、以及为 traefik 提供 http provider 的配置文件。

ConfigDeliver 采用客户端/服务端模式，服务端开启一个 HTTP 服务，客户端通过 HTTP 协议将配置文件下载到本地。

服务端通过配置文件中的 map 映射关系，将一个字符串匹配到一个服务端目录。

客户端请求服务端时,通过 url 中携带`id`参数，服务端根据`id`参数匹配到对应的目录，返回目录下文件的 json 列表。然后客户端再根据 json 列表中的文件名，下载文件到本地。 下载过程中，客户端会根据服务端返回的文件的 md5 值，判断本地文件是否需要更新。

## Docker 部署

### 服务端

docker-compose.yml 文件如下：

```yaml
version: "3"
services:
  config-deliver-server:
    image: gcslaoli/config-deliver-server:latest
    restart: always
    ports:
      - 8000:8000
    volumes:
      - ./config.yaml:/app/config.yaml
```

config.yaml 文件如下：

```yaml
server:
  address: ":8000"

dirmap:
  5472E3F6-37DE-B9A0-899C-39838E8C1336: ./
```

### 客户端

docker-compose.yml 文件如下：

```yaml
version: "3"
services:
  config-deliver-client:
    image: gcslaoli/config-deliver-client:latest
    restart: always
    volumes:
      - ./config.yaml:/app/config.yaml
```

config.yaml 文件如下：

```yaml
apiServer: http://localhost:8000/getconfig # api server address
tasks:
  - name: "5472E3F6-37DE-B9A0-899C-39838E8C1336" # 任务名称
    file: "*" # 文件名, * 表示所有文件
    corn: "@every 1m" # corn表达式
    localDir: "./temp/test" # 本地目录
    isRunOnStart: true # 是否启动时执行一次
```

## DockerHub

- [config-deliver-server](https://hub.docker.com/r/gcslaoli/config-deliver-server)
- [config-deliver-client](https://hub.docker.com/r/gcslaoli/config-deliver-client)

## 版本号规则

版本号规则为`v1.0.0`，其中`v`表示版本号，`1`表示主版本号，`0`表示次版本号，`0`表示修订版本号。

DockerHub 中的镜像版本号为`1.0.0`，其中`1`表示主版本号，`0`表示次版本号，`0`表示修订版本号。每次更新镜像时，会将镜像的版本号更新为最新的版本号。
