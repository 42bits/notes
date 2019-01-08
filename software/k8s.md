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

###k8s对象


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
