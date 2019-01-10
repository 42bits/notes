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
    - name: rbd-pvc                                 #挂载申请到的pvc磁盘
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
规范:
以[a-z0-9A-Z]带有虚线（-）、下划线（_）、点（.）和开头和结尾必须是字母或数字（都是字符串形式）的形式组成

标签:
一对key/value 关联到对象上,标签的使用倾向于能够标识对象的特点
对用于有意义,对系统是没有意义的,
标签不需要唯一,一般使用方法时很多对象有相同的标签

标签选择器:
通过选择器,可以方便的标识出有相同标签的多组对象

选择器种类;
1:平等(equality-based)
2:集合(set-based)

平等写法1:
    env=pro
    sources!=ns
平等写法2:逗号相当与and
    env=pro,sources!=ns

集合写法1:
    env in(pro,test)
    sources notin (ns,backend)
集合写法2:(key=env但是value 等于pro或者test,key=sources但是value不等于ns和backend)
    env in (pro,test),sources notin (ns,backend)


支持写法:

url请求模式(需要urlencode)和kubectl操作模式支持这两种写法
?labelSelector=env=pro,sources!=ns
?labelSelector=env in (pro,test),sources notin (ns.backend)

kubectl get pods -l env=pro,sources!=ns
kubectl get pods -l 'env in (pro,test),sources notin (ns,backend)'

对象使用
services和 replicationControllers 也使用selector来指定标签,但是只支持平等写法
selector:
    env:pro
    sources:pod

job,deployment,replica set 支持 集合写法(可以使用matchLables,或者matchExpressions)

selector:
    matchLables:
        env:pro
    matchExpressions:
        - {key:env,operator:In,values:[pro,test]}
        - {key:sources,operator:NotIn,values:[ns,backend]}

```
> annotations
```
可以将非metadata的参数附加到对象,目地就是为了方便用户阅读和查找
annotations:
    time:2019-01-11
    hash:1234qwer
    user:congxi
    phone:12344567

labels和annotations区别:
labels 可以用于选择对象,并查找满足某些条件的对象
annotations不能用于标识和选择对象

```
> volume
```
容器中的文件是非持久化,容器挂掉,文件会丢失,一个pod中的多个container需要共享文件,使用volume可以解决问题

docker中的volume是磁盘中的一个目录,生命周期不受管理,通过 多个 -v 可以挂载多个目录

k8s中的volume生命周期和pod一致,不随container的消失而消失,使用volume,pod需要指定volume的内容和类型(spec.volumes),容器配置需要指定(spec.containers.volumeMounts)

volume 支持多种类型,主要介绍几种,emptyDir,hostPath,nfs

emptyDir
当pod被分配到node上时,会创建emptyDir,生命周期和pod一直,不随容器的消失而消失,pod消失,emptyDir也会被删除
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

hostPath
挂载node节点上的文件系统到pod里,缺点就是数据固定在某个node上,一但pod被调度到其他node上那么存储的数据将不能使用
volumeMounts:
- mountPath:/test-pd
  name:test-volume

volumes:
- name:test-volume
  hostPath:
    path:/var/data

nfs:
网络文件系统,是基于rpc远程过程实现调用,nfs数据是永久保存的,支持同时写的操作
volumeMounts;
- mountPath:/data/nfs-test
  name:nfs-client

volumes:
- name:nfs-client
  nfs:
    server:192.168.1.1
    path:/usr/local/work/nfs

```
> nodes
```
k8s中的工作节点,可以是vm或实体机
每个node上具有运行pod的必要服务,并有master进行管理

节点信息:
kubectl describe no/kel-test

address:
    hostname 节点名称
    internalIp 集群内进行路由的 节点ip
    externalIp 可以被集群外部路由到的ip

condition:
运行节点的信息
autofDisk 磁盘空间是否足够创建pod,true:是的空间不足,false:空间足够
memoryPressure 内存压力.true:压力太大,false:没有压力
diskPressure 空间压力,true:压力太大,false:没有压力
pidPressure pid是够足够,true:不够,false:足够
read        节点健康与否,true:健康,可以接收pod,false:不健康,不接受pod,unknown,节点控制器在40秒中没有收到节点信息,为unknown

capacity:
节点上的容量
    cpu,memory,pod

allocatable:
可分配的容量
    cpu,memory,pod

system info
系统信息

```
```
node 不是由kube系统创建
如果通过kube创建的节点只是说明创建了一个node对象,创建后kube可以用来检查node是否正常,是否可以用于部署pod

apiVersion: v1
kind: node
metadata:
    name:knode01
    labels:
        name:node-test

```
```
kube通过controller-manager 中的 node-controller 来管理节点,
节点通过kubelet 来向kube注册自己,

流程:
注册时,kube会将cidr快分配给节点(一个网段)
保证节点控制器内的列表和可以机器列表保持最新,并进行节点健康检查,如果不可用会做标识,并删除节点,1.5版本以前会删除该node上的pod
1.5后会将属于该node的pod做标识`Terminating`或`unknown`

`如果节点永久退出,需要管理员手动删除node对象,如果删除node对象,那么属于该node的所有pod也会被删除`

```

### k8s对象

> pod

[pod驱逐细节](/image/node_eviction.png)


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
