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
docker ps
进入容器
docker exec -it name /bin/bash
保存容器
docker commit xxx test:latest
```

