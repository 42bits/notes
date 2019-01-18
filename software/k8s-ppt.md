[TOC]

# 什么是kubernetes
- 一个容器集群管理系统
- 基于容器的应用部署和维护以及升级
- 负载均衡和服务发现
- 支持跨机房和跨地区的集群调度

# kubernetes主要概念
## master
> 运行有保证kube集群正常工作的主要构件,不对外提供应用服务

## node
> 运行有使集群能对外提供服务的主要构件,是真正提供应用服务的节点

## etcd
> 保存有集群运行状态的所有数据

> 对外提供watch服务,不能直接访问,apiservice是和他对接的唯一对象

## apiservice
> kube对外的唯一通道

> 对资源的操作全部由他接管,并写入etcd

## controller-manager
> 集群所有资源的管理中心

> 下分多个控制器,并管理这些控制器

> deployment-controller,replicaset-controller,service-controller,endpoint-controller

## scheduler
> pod和node关联的调度中心

> 负责收集集群中node的所有信息和状态并分析

> 监控pod,将pod调度到node上


## kubelet
> pod能否在该node上运行的实际决定者(根据node自身的状态)

> 向master提供 node和pod信息

> 维护pod的状态(创建,删除,修改,监控)

## kube-proxy
> 集群应用负载和代理的提供者

> 监控 service 和endpoint的关系,更新和创建iptables(网络数据包的处理和转发)规则


## docker
> 提供运行应用环境的提供者

# 架构
![](/image/k8s-base.png)

----

![](/image/kubernetes-high-level-component-archtecture.jpg)

# kubernetes 主要对象
## ns
> 提供资源划分的顶级对象

## label
> 给对象添加标识,提高识别度,并提供给其他对象选择

> 是service和controller运行的基础

> 方便的管理多个container


## volume
> 数据落地的提供者

## pod
> kube能管理的最小单元,整合多个或一个应用同时对外提供服务

> pod内的所有container共享network,volume

## deployment
> 保证pod稳定提供服务

> 始终保证pod的运行状态和期望的一致

> 对pod提供更新,部署,回滚等服务

## service
> 对集群外或集群内提供访问pod应用服务

> 是应用服务的抽象

> 通过label来选择关联pod

# 对象简要说明
## volume
> 为了保证pod被销毁后数据不会丢失(container销毁,数据不会销毁),以及同一个pod中的container共享文件
### 分类
#### emptydir
> 当pod被分配到node上时,会创建,初始内容为空,不需要指定宿主机上的目录文件,有kube自动分配,当pod被删除,对应的emptyDir也会被删除
```
apiVersion:v1
kind:Pod
metadata:
    name:test-pd
spec:
    containers:
    - image:nginx:1.14
      name:test-nginx
      volumeMounts:
      - mountPath:/cache
        name:cache-volume
    volumes:
    - name;cache-volume
      emptyDir:{}
```
#### hostpath
> 挂载node节点上的文件系统到pod里,缺点就是数据固定在某个node上,一但pod被调度到其他node上那么存储的数据将不能使用
```
volumeMounts:
- mountPath:/test-pd
  name:test-volume

volumes:
- name:test-volume
  hostPath:
    path:/var/data
```
#### pv
> 网络文件系统,是基于rpc远程过程实现调用,nfs数据是永久保存的,支持同时写的操作
```
volumeMounts;
- mountPath:/data/nfs-test
  name:nfs-client

volumes:
- name:nfs-client
  nfs:
    server:192.168.1.1
    path:/usr/local/work/nfs
```

## pod
> pod是kube创建和管理的最小单元,并且每个pod都有个pause容器(根容器)和init容器

> 每个pod都有独立的ip

> pod 可以分为两类,普通pod和静态pod

> 每个pod 可以有单独的资源配额

### 基本命令

- kubectl create -f xxx.yaml
- kubectl get pod pod-name [-o wide,yaml,json]
- kubectl describe pod pod-name --namespace=ns
- kubectl get pods --show-labels
- Kubectl delete pod po-name
- kubectl delete pod --all
- kubectl replace xxx.yaml

### pod生命周期

- pending pod已经被创建,但是部分container还没有创建好
- running 所有container已经创建好,至少有一个container在运行状态,启动状态,正在启动状态
- successed 所有container已经执行成功并退出,不会在重启
- failed 所有container全部执行完成,至少有一个容器退出状态为失败
- unknown 由于各种原因,无法获取pod状态

### 探针

由kubelet来定期检查pod,有三种方式(由container实现,kubelet调用)来检查

- execAction
- tcpSocketAction
- httpGetAction

三种结果:成功,失败,未知

探针类型:

> livenessProbe(存活探针)

- 表明容器是否正在运行 pod.status:running
- 如果探针失败,kube会kill掉container,并且会受restartPolicy影响,决定是否重启
- 如果容器没有提供探针,那么kubelet会认为探针的返回值永远是成功的

> readinessProbe(就绪探针)

- 表明容器是否可以正常接受请求 container.ready:true
- 如果探针失败,端点控制器(endpoint-controller)会从与pod匹配的所有service中的端点删除该pod-ip
- 直到下次探测成功

区别:

- livenessProbe kill 掉容器,并根据策略作出决定
- readinessProbe 将pod-ip从endpoint 列表中删除
- rp用于探测容器是否就绪,如果未就绪不会把流量转给pod,比如pod已经启动状态为running,但容器内应用程序还没有启动成功,如果没有rp,kube会认为他可以处理请求了,但此时并不能处理请求

### pod重启策略

- Always
- OnFailure
- Never

### hook
- 由kubelet发起,在容器中的进程工作前和终止之前执行,包含在容器的生命周期之中
- 包括exec和http 两种
- 在容器创建之后,容器的entrypoint 执行之前,这是pod已经被调度到node上,被某个kubelet管理
- kubelet调用postStart,该命令和容器的启动命令是异步执行,在postStart执行完成之前,kubelet会锁住容器,不让应用容器启动,此时pod状态为pending,成功后pod为running
- 如果postStart和preStop执行失败,那么终止容器


### 创建流程

- 开发者开发一个应用,打包docker 镜像,上传到镜像仓库中
- 编写一个deployment.yaml的文件
- 通过kubectl或其他方式提交(调用apiserver中的deployment接口)
- apiserver将部署需求更新到etcd中(apiserver任务完成,只记录,不做具体任务,具体操作由
controller-manager完成)
- deployment-controller通过监听apiserver,得知需要创建一个对象,会调用apiserver提供的replicaset操作接口
- replicaset-controller通过监听apiserver,得知需要创建一个对象,会创建一个pod
- scheduler通过监听apiserver,得知有一个新的pod被创建,经过计算,会将该pod分配到合适的node上
- kubelet通过监听apiserver,得知有个pod分配过来,会根据node情况,创建该pod或拒绝

### pause容器
- pause容器的状态代表整个容器的状态,其他容器共享pause的ip(pod ip),volume
- 每个pod 里都有一个该容器
- 该容器代表了pod的状态

### init容器
- 专用容器,在所有应用容器启动前启动
- 在pod启动过程中,init容器会按顺序在网络和volume初始化成功后启动
- 如果pod重启,init容器会重新执行,更改init容器的image等于重启pod
- 如果启动失败会,kube会不停的重启,直到init成功,如果pod对应的策略是never,那么失败了不会重启
- yaml文件中通过template.spec.initContainers来定义,可以有多个,但是按照顺序依次执行
- 和普通容器一致,全部字段和特性,但是不支持readiness probe (探针),因为他在pod就绪之前完成
- 可以用来将应用镜像分离出创建和部署两个,减少image的复杂度
- 应用容器是并行运行的,init容器可以提供简单的堵塞或延迟应用容器的启动方法,直到满足了一组必要条件

### 静态pod

- 静态pod由kubelet管理,仅存在于特定的node上,不能通过apiservice管理
- 通过启动kubelet时带上--config 参数 指定需要使用的pod yaml文件存放路径

### pod删除
- 强制删除
  - kubectl delete pod k8s-demo --force --grace-peroid=0
  - yaml文件.spec.spec.terminationGracePeriodSeconds
  - api-service 不会等待各个节点kubelet的确认,会立即从api-service中删除pod
  - pod状态会被立即设置为terminating状态
  - 不建议使用
- 有等待期的删除(默认)
  - kubectl delete pod k8s-demo
    - pod状态为terminating
    - 如果pod超时,状态为dead
    - 如果pod中使用了hook 会在pod停止前被调用,如果在宽限其还没有执行完,会增加2秒宽限期
  - 发送term请求到每个容器的主进程
  - 从service的端点列表中删除pod
  - 一旦超时会直接发送kill给主进程,并从api-service删除
  - 如果 kubelet 或controller-manageer在等待期中重启,会重新执行一个等待期


## deployment
> rc的升级版,一般使用deploy来管理pod,和replicaSet

### 功能:
- 创建一个deploy对象会创建一个对应的rs,在由rs在后台完成pod的创建
- 支持回滚和升级应用
- 扩容和缩容
- 暂停和继续
- 清除不需要的rs

### 状态
#### progressing:

deployment 在创建新的rs,扩容或缩容rs,有新的pod出现

#### complete:

deploy中replica数量等于或超过期望的数量,所有resplica都更新完成,没有旧的pod存在

#### fail to progress;

镜像拉取错误,配置错误,权限不够等

通过设定 spec.progressDeadlineSeconds 时间,来确定是卡住了还是真发生错误了

### 命令
```
相关命令
kubectl get deploy
kubectl get rs
kubectl get rc
kubectl create -f xxx.yaml --record 创建,并将使用的命令记录
kubectl apply -f xxx.yaml 能创建,还能更新,一般使用该命令(其他kubectl create,replace,edit,patch)
kubectl describe deployments
kubectl set image deployments/kel kel=nginx:1.15 设置镜像更新
kubectl edit deployment/k8s-demo 编辑deploy

(rollout当且仅当deployment中的.spec.template中的label或image 更新时才会被触发,其他情况不会触发,比如扩容)

kubectl rollout paush deployment/nginx-deployment 暂停升级
kubectl rollout resume depoyment/nginx-deployment 恢复升级
kubectl rollout history deployment/nginx-deployment 查看历史
kubectl rollout undo deployment/nginx-deployment  回滚上个版本
kubectl rollout undo deployment/nginx-deployment --to-version=2 回滚指定版本
kubectl scale deployment nginx-reployment --replicas 1 设置副本数量为1
kubectl rollout status deployment/k8s-demo 查看rollout状态

```
## service
> 后台pod的抽象实例

> 前端应用,通过该入口访问背后的一组由pod副本组成的集群实例

> 在service中通过selector选择具有相同lable的pod作为一个整体,该工作由service-controller来完成

> service 和pod的映射关系有endpoint controller 来维护

> 创建service时如果选择了selector 会创建一个endpoint 对象

### 没有selector
> 不会创建 endpoint,可以手动创建

> 主要用于将负载转移到kube集群,但是又想用其他集群的应用,比如外部的mysql集群

### 服务发现
- 环境变量
- dns

#### 环境变量
- pod 运行在node上,kubelet会为每个活跃的service添加一组环境变量,
- 只有在pod创建前的service才会能被container获取到
- 可以在pod中通过`env`查看所有的环境变量(kubectl exec -it pod-name /bin/bash 进入pod查看)

#### dns
- 一个可选的集群插件
- 他监视着kube,如果有新的service被创建,会为每个service创建一个dns记录,

#### 从集群外部访问集群内应用ip走向
- proxy-ip: 外部访问应用的网关ip,代理层公网ip
- service-ip(cluster-ip): service的虚拟ip(vip),是内部ip,外部无法寻址
- node-ip: 容器宿主机ip
- container-bridge-ip : 容器网桥ip(docker0),容器的网络都由该网桥转发
- pod-ip: 等效与容器中的container-ip
- container-ip: 容器ip,容器的网络是个隔离网络空间

#### 对外提供服务
- clusterIP
- nodePort
- loadBalancer
- externalName

##### cluster-ip
> 通过集群内部ip暴露服务,服务只能在集群内部可以访问,也是默认值

##### nodePort
> 通过每个node的ip和port(NodePort) 暴露服务,通过nodePort访问会路由到clusterIp(会自动创建),通过nodeport 可以从集群外部访问服务,会自动分配一个node上的port(30000-32767),通过集群内的任何一个ip和port都能访问服务

##### lb
> 使用云服务商提供的负载均衡,外部可以访问服务,外部的负载均衡器可以路由到nodeport和clusterip

##### 外部ip
> 如果外部ip路由到集群中一个或多个node上,service会被暴露给这些externalIps,通过外部ip进入到集群,打到service的流量,会被路由到service的endpoint上

```
客户端通过80.34.23.66:80 来访问服务

kind: Service
apiVersion: v1
spec:
  selector:
    app: k8s-demo
  ports:
   - name: http
     port: 80
     targetPort: 8080
     protocol: TCP
  externalIps:
    - 80.34.23.66
```

```
apiVersion: v1
kind: service
metadata:
  name: my-svc
  namespace: prod
spec:
  type: ExternalName
  externalName: my.example.com

```

# 详细描述
[k8s描述](http://gitlab.x.lan/congxi/k8s-describe/)