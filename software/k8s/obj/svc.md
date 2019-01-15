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