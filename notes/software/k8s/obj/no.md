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