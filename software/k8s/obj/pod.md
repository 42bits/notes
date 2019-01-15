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
kubectl get pod pod-name [-o wide,yaml]
kubectl describe pod pod-name
kubectl get pods --show-labels

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
