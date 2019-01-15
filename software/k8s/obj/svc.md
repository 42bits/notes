###  service

一个真实服务的抽象,后面有很多对应的container在支持该服务,

前端应用,通过该入口访问背后的一组由pod副本组成的集群实例

在service中通过selector选择具有相同lable的pod作为一个整体,将信息写入etcd中

该工作由service-controller来完成

service 和pod的映射关系有endpoint controller 来维护

pod的更新,删除,在通过service调用pod的前端来看是没有影响的,也不需要关心

创建service时如果选择了selector 会创建一个endpoint 对象

如果没有选择,不会创建endpoint,可以通过yaml来创建(kubectl get ep)


#### service ip 类型
- node ip  node 节点ip
- pod ip   pod ip
- cluster ip  service ip

> node ip

每个节点的物理网卡ip,是真实存在的物理网络,
每个集群外的节点访问集群内的某个节点或tcp/ip服务时都是通过node ip 来访问

> pod ip

是一个虚拟的ip,有docker engine 来分配,集群中一个pod的容器访问另外一个pod中的容器都是通过pod ip 来访问,pod中的容器相互通信由localhost来实现

> cluster ip

是虚拟ip 只作用在service对象,
无法ping通,
集群外如果访问需要额外处理,type选项

### 容器之间通信
同一个pod中的container 共享网络命名空间,通过localhost互访

### pod 之间通信
- 同一个node中的pod通信,通过pod ip 进行互访
- 不同node间的pod通信,需要保证整个集群中的pod-ip不能有冲突,node-ip和pod-ip关联起来,通过node-ip转发到pod-ip(Flannel)

