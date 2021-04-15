### 定义

## 安装

### 启动
systemctl start docker

如果失败，使用 `journalctl -xe` 或者 `dockerd` 查看问题

问题：`exec: "mkfs.ext4": executable file not found in $PATH` 安装 `yum install e4fsprogs`

问题：`System has not been booted with systemd as init system`

`docker run -tid --name centos_1 --privileged=true centos:latest /sbin/init` 启动容器


###  kill container(脚本)
```
count=`ps -aux |grep docker |grep -v 'grep\|dockerd\|docker-containerd --config' | awk '{print $2}' |wc -l`
echo $count
if [ $count -gt 0 ]; then
   ps -aux |grep docker |grep -v 'grep\|dockerd\|docker-containerd --config' | awk '{print $2}'|xargs sudo kill -9
   sleep 2
   echo 'kill all container';
else
    echo 'no container';
fi

```

### docker-compose.yml 说明
```
services:
    web:
        image: centos:7.2.1511
        ports:
            - 8080:8080
        stdin_open: true
        tty: true
```

### 基本命令
```
启动：
docker-compose up -d

查看：
docker ps -a

进入容器
docker exec -it name /bin/bash

保存xxx:imageid容器到镜像
docker commit xxx test:latest

使用当前目录的dockerfile文件创建 test:v0.0.1 镜像
docker build -t test:v0.0.1 .

打标签
docker tag test:v0.0.1 test:v0.0.2
默认使用latest
docker tag test test:v0.0.2

image 打包
docker save test:v0.0.2 -o test.tar

导入image
docker load < test.tar

```

### dockerfile

- 基础镜像的选项
  - 选择官方镜像库里的基础镜像
  - 选择轻量级的镜像做底包(推荐alpine,distroless)
- 构建镜像时,多使用易于理解该镜像标签(docker build -t "alpine:goBase")
  `基于alpine创建的包含go环境的基础镜像`
- 构建出来的镜像是在基础镜像上一层一层叠加而成,在构建过程中会缓存一些中间镜像
  - 如果想基于dockerfile创建两个不同的镜像,尽量将相同指令的部分,放在前面,差异的放在后面
- add 和copy 尽量使用copy,add 会添加一些额外的操作,比如一个压缩包,add 会自动解压
- 多个dockerfile如果处理不同的文件,分开copy 不需要批量的copy,可以保证每个步骤的build缓存只在对应的文件改变时才无效
- 尽量使用 volume 来挂载文件,而不是用add 和copy
- cmd 和entrypoint
  - entrypoint 一般用与固定不变的命令和参数,容器运行时 不修改
  - cmd 在运行容器时,一般可以指定参数来覆盖掉dockerfile里的命令
- 不推荐在dockerfile中做端口映射,只需要暴露端口就可以,运行容器时通过-p参数来映射,这样避免一台主机上只能运行一个容器
- run 命令尽量的少,多一个run 就多一层镜像
- 安装完软件后,删除安装包,减小镜像体积
  ```
    RUN apt-get update \
    && apt-get install -y \
    automake \
    && rm -rf /var/lib/apt/lists/*

    RUN apk add --no-cache --update \
    curl bash tzdata \
    && rm -rf /var/cache/apk/*
  ```
- 通过ENV 设置的变量,后面的run指令就可以使用该环境变量

```

FROM centos

ARG RESTY_YUM_REPO="https://openresty.org/package/centos/openresty.repo"
LABEL resty_yum_repo="${RESTY_YUM_REPO}"

RUN yum install -y openssl
RUN openssl req -nodes -new -x509 -keyout /etc/pki/tls/private/private.pem -out /etc/pki/tls/certs/cert.csr -days 3650 -subj "/C=CN/ST=Beijing/L=Beijing/O=Yunshan/OU=R&D/CN=www.yunshan.net.cn"

RUN echo -e "* soft nofile 65536\n* hard nofile 65536" >> /etc/security/limits.conf

RUN yum install -y yum-utils \
    && yum-config-manager --add-repo ${RESTY_YUM_REPO} \
    && yum install -y \
    bind-utils \
    vim \
    lsof \
    gcc \
    openssl \
    gettext \
    gzip \
    make \
    openresty openresty-opm openresty-resty

RUN mkdir -p /var/log/openresty

COPY --from=nexus.x.lan:5000/df-web-core:5.6.2 /var/www/lcweb/public /var/www/lcweb/public/

COPY ./conf /usr/local/openresty/nginx/conf/
COPY ./lib /usr/local/openresty/nginx/lib/
COPY ./lua /usr/local/openresty/nginx/lua/

CMD ["/usr/bin/openresty", "-g", "daemon off;"]
```