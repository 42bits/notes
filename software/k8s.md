### k8s(kubernetes)

### 是什么

一个容器集群管理工具,可以实现容器的自动化部署,自动扩容和维护

也是应用管理工具. `创建集群,部署应用,发布应用,扩展应用,更新应用`


### 和docker compose 区别
dockercompose 用来管理容器,只能管理当前主机上的容器

k8s  跨主机的容器管理平台,


### master主要组件
> kube-apiserver
```
操作资源的唯一入口,提供多种服务(认证,授权,访问控制,api注册和发现)
```
> etcd
```
保存有整个集群的状态
```
> kube-controller-manager
```
维护集群的状态,故障检测,自动扩容和滚动更新
```
> kube-scheduler
```
资源的调度,主要负责将pod按照预定的策略调度到相应的节点上
```



### node 主要组件
> kubelet
```
维护容器的生命周期,也同时负责volume 和network的管理
```
> kube-proxy
```
为servcie提供cluster内部的服务发现和负载均衡
```
> docker
```
image管理和pod以及container的运行
```

### 对象基础
```
导出资源描述1
kubectl get <resource-type> <resource>  --export -o yaml  > xxxx.yaml

kubectl get deployment kel-demo --export -o yaml > kel-demo.yaml

模拟命令执行2
kubectl run myapp --image=nginx:1.15 --dry-run -o yaml
```

> 例子 deployment.yaml
```
apiVersion: extensions/v1beta1 # 接口版本

kind: Deployment    #资源类型
metadata:                   #元数据
    name:nginx-deployment   #名称,必须有
    namespace: default      # 名字空间
    labels:                 # 标签
        app:nginx
spec:                           #deployment规格说明,必须有
    replicas:1                   # 启动的pod数量,默认1
    strategy:
        rollingupdate:          #滚动升级时配置
            maxSurge:1          #滚动升级时启动的pod个数
            maxUnavailable:1    #滚动升级时允许的失败pod个数
        type:RollingUpdate
    selector:
        matchLabels:
            run:nginx-test
     template:                      #模板,必须有
        metadata:                   #pod 的元数据,labels必须有
            labels:
                run:nginx-test      #模板名称
        spec:                                       # pod规格说明,必须有
            containers:                             #容器,可以有多少
            - name:nginx                            #container名称
              image:nginx:1.14                      # image 名称
              imagePullPolicy:IfNotPresent          #镜像获取策略 always,never,ifnotpresent
              port:
              - containerPort:80                    #容器暴露的端口
        resouces:{}                                 #容器的一些资源配置,一般是cpu和memory
        env:                                        #环境变量,容器内部的应用可以使用
        - name:LOCAL_KEY
          value:value
        volumeMounts:                               #挂载目录
        - name:log-cache
          mount:/tmp/log
        - name:sdb
          mount:/data/test
        - name:nfs-client-root
          mount:/mnt/nfs
        - name:ex-volume-config                     #将ConfigMap的log-script,backup-script分别挂载到/etc/config目录下的一个相对路径path/to/...下，如果存在同名文件，直接覆盖
          mount:/etc/conf
        - name:rbd-pvc
    volume:
    - name:log-cache
      emptyDir:{}                                   #有效期和pod一致,pod被删除,该挂载也会被删除
    - name:sdb
      hostPath:                                     #使用node上的文件系统,挂载到pod里,有效期和pod一致,pod被删除,该挂载系统里的文件不会被删除
        path:/any/path/it/will/be/replaced
    - name:ex-volume-config                         # 该挂载每一个key的value挂载在指定的目录下,是相对目录
      configMap:
        name:ex-volumt-config
        items;
        - key:log-script
          path:path/to/log-script
        - key:backup-script
          path:path/to/backup/script
    - name:nfs-client-root                          #网络文件系统
      nfs:
        server:10.24.2.44
        path:/opt/public
    - name: rbd-pvc                                 #挂载pvc磁盘
      persistentVolumeClaim:
        claimName:rbd-pvc1

```
> name

> nameSpaces
```
规范:[a-z0-9]([-a-z0-9]*[a-z0-9])?

可以使用namespace 创建多个虚拟集群,默认default,kube-system

kubectl create namespace test-ns

cat my-ns.yaml
apiVersion:v1
kind: Namespace
metadata:
    name:test-ns

kubectl create -f my-ns.yaml

kubectl delete namespace  test-ns

删除ns会删除属于该ns的所有资源
默认的ns不能被删除

kubectl get ns

node和persistentVolumes 不再ns中,events是否存在取决于 产生events的对象
其他大部分在ns中

```
> labels和selectors
```
规范参考ns

标签:
一对key/value 关联到对象上,标签的使用倾向于能够标识对象的特点
对用于有意义,对系统是没有意义的,

标签选择器:
通过选择器,可以方便的标识出一组对象

选择器种类;
1:平等
2:集合


```
> annotations

> volume

> nodes

### k8s对象

> pod

> replicaSet

> deployment

> replicationController

> stateFulSet

> ingress

> service

### k8s cluster(创建集群)
- 一个master (kubectl init 创建master)
- 多个node (kubectl join xxx 创建一个node 加入集群)
- master:调度和控制集群的资源
- node: 运行容器的节点

```
查看cluster 信息
kubectl cluster-info

查看节点信息
kubectl get nodes -o wide
```

### 部署应用
```
kubectl run kel --image=nginx:1.14 --port=80
查看是否部署
kubectl get pods -o wide
kubectl get deployments/kel
```
### 发布应用
```
kubectl expose deployment kei --type="NodePort" --port=80 --targetPort=80
查看是否发布
kubectl get svc/kel
kubectl get svc -l run=kel `-l run=kel 表示选择label 为run=kel`
kubectl get pods -l run=kel
kubectl describe services/kel
```

### 扩容和缩容(添加或减少pod)
```
kubectl scale deployments/kel --replicas=2 `pod设置为2个`
kubectl get pods  -o wide

kubectl scale deployments/kel --replicas=1
kubectl get pods -o wide
```

### 更新
```
kubectl set image deployments/kel kel=nginx:1.15
kubectl rollout undo deployments/kel
```
