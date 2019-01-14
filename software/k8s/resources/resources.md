### 获取资源信息

```
导出资源描述1
kubectl get <resource-type> <resource>  --export -o yaml  > xxxx.yaml

kubectl get deployment kel-demo --export -o yaml > kel-demo.yaml

模拟命令执行2
kubectl run myapp --image=nginx:1.15 --dry-run -o yaml
```
### [yaml格式-demo](./deploy-demo.md)

### namespace
```
主要用于多租户的资源隔离

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
### labels和selectors
```
规范:
以[a-z0-9A-Z]带有虚线（-）、下划线（_）、点（.）和开头和结尾必须是字母或数字（都是字符串形式）的形式组成

标签:
一对key/value 关联到对象上,标签的使用倾向于能够标识对象的特点
可以附加在任何对象上,pod,service,node,rc
对用于有意义,对系统是没有意义的,
标签不需要唯一,一般使用方法时很多对象有相同的标签
主要用来实现资源的精细和多维度的分组管理


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
### annotations
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

### volume
```
容器中的文件是非持久化,容器挂掉,文件会丢失,一个pod中的多个container需要共享文件,使用volume可以解决问题

docker中的volume是磁盘中的一个目录,生命周期不受管理,通过 多个 -v 可以挂载多个目录

k8s中的volume生命周期和pod一致,不随container的消失而消失,使用volume,pod需要指定volume的内容和类型(spec.volumes),容器配置需要指定(spec.containers.volumeMounts)

volume 支持多种类型,主要介绍几种,emptyDir,hostPath,nfs

emptyDir
当pod被分配到node上时,会创建,初始内容为空,不需要指定宿主机上的目录文件,有kube自动分配,当pod被删除,对应的emptyDir也会被删除

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
挂载node节点上的文件系统到pod里,
缺点就是数据固定在某个node上,一但pod被调度到其他node上那么存储的数据将不能使用

volumeMounts:
- mountPath:/test-pd
  name:test-volume

volumes:
- name:test-volume
  hostPath:
    path:/var/data

pv(nfs):
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

### nodes
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

### pod
```
pod是kube创建和管理的最小单元,并且每个pod都有个pause容器(根容器)
容器依附与pod,一个pod可以只有一个container 也可以有多个container,
一个pod内的container共享volume,network,namespace/ip,port
每个pod都有独立的ip,共享网络空间,包括ip地址和端口,pod内的container通过localhost互相访问

pause容器的状态代表整个容器的状态,其他容器共享pause的ip(pod ip),volume

pod 可以分为两类,普通pod和静态pod,又k8s创建,调度是普通,静态又具体文件来启动运行在某个node上

endpoint podip+port 为一个endpoint

每个pod 可以有单独的资源配额[基本是cpu和memory] 通过spec.containers.resources

其他配置:
spec.containers.command
spec.containers.env
spec.containers.ports.containerPort/hostIp/hostPort/protocol


基本命令
kubectl create -f xxx.yaml
kubectl get pod pod-name [-o wide]
kubectl describe pod pod-name

pod状态:
pending pod已经被创建,但是部分container还没有创建好
running 所有container已经创建好,至少有一个container在运行
successed 所有container已经执行成功并退出,不会在重启
failed 所有container全部执行完成,至少有一个容器退出状态为失败
unknown 由于各种原因,无法获取pod状态

创建流程

1:开发者开发一个应用,打包docker 镜像,上传到镜像仓库中

2:编写一个deployment.yaml的文件

3:通过kubectl或其他方式提交(调用apiserver中的deployment接口)

4:apiserver将部署需求更新到etcd中(apiserver任务完成,只记录,不做具体任务,具体操作由
controller-manager完成)

5:deployment-controller通过监听apiserver,得知需要创建一个对象,会调用apiserver提供的replicaset操作接口

6:replicaset-controller通过监听apiserver,得知需要创建一个对象,会创建一个pod

7:scheduler通过监听apiserver,得知有一个新的pod被创建,经过计算,会将该pod分配到合适的node上

8:kubelet通过监听apiserver,得知有个pod分配过来,会根据node情况,创建该pod或拒绝
```
[pod驱逐细节](/image/node_eviction.png)

### replicationController
```
确保kube中有指定数量的pod在运行,如果少于指定的pod replicas ,rc会创建新的pod,反之会杀掉多余的pod
```

### replicaSet
```
rc的升级版本,区别就是rc的lable选择器种类只支持平等写法,而rs支持平等和集合写法
```

### deployment
```
rc的升级版本,包含(rc+rs),一般使用deploy来管理pod,不再使用上述两个
创建一个deploy对象会生成对于的rs,并完成pod的创建
相关命令
kubectl get deploy
kubectl get rs
kubectl get rc
kubectl create -f xxx.yaml --record 创建,并将使用的命令记录
kubectl apply -f xxx.yaml 能创建,还能更新,一般使用该命令(其他kubectl create,replace,edit,patch)
kubectl describe deployments
kubectl set image deployments/kel kel=nginx:1.15 设置镜像更新
kubectl rollout paush deployment/nginx-deployment 暂停升级
kubectl rollout resume depoyment/nginx-deployment 恢复升级
kubectl rollout history deployment/nginx-deployment 查看历史
kubectl rollout undo deployment/nginx-deployment  回滚上个版本
kubectl rollout undo deployment/nginx-deployment --to-version=2 回滚指定版本
kubectl scale deployment nginx-reployment --replicas 1 设置副本数量为1

```
### stateFulSet
```
```
### ingress
```
```
###  service
```
一个真实服务的抽象,后面有很多对应的container在支持该服务,前端应用,通过该入口访问背后的一组
由pod副本组成的集群实例
在service中通过selector选择具有相同lable的pod作为一个整体,将信息写入etcd中
该工作由service-controller来完成
```
```
service ip 类型

node ip  node 节点ip
pod ip   pod ip
cluster ip  service ip

node ip
每个节点的物理网卡ip,是真实存在的物理网络
每个集群外的节点访问集群内的某个节点或tcp/ip服务时都是通过node ip 来访问

pod ip 是一个虚拟的ip,有docker engine 来分配,集群中一个pod的容器访问另外一个pod中的容器都是通过pod ip 来访问,pod中的容器相互通信由localhost来实现

cluster ip 是虚拟ip 只作用在service对象
无法ping通
集群外如果访问需要额外处理,type选项

```