> kubelet
```
pod能否在node上运行最终决定权在kubelet(pod的创建,修改,监控,删除)
kubelet默认使用cadvisor进行资源监控
维护pod的生命周期,也同时负责volume 和network的管理
并将node,pod以及容器的运行状态通知给apiserver,接受master的指令
```
> kube-proxy
```
为servcie提供访问pod的cluster内部的服务发现和负载均衡
由他来负责服务地址到pod地址的代理和负载均衡工作
proxy使用etcd的watch机制,监控service和endpoint的信息,维护service和endpoint的一个映射关系
当后台pod ip发生变化时,不至于影响访问
```
> docker
```
image管理和pod以及container的运行
```