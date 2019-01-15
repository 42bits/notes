> 真正提供服务的实例

> kubelet
```
pod能否在node上运行最终决定权在kubelet(pod的创建,修改,监控,删除)
kubelet默认使用cadvisor进行资源监控
维护pod的生命周期,也同时负责volume 和network的管理
并将node,pod以及容器的运行状态通知给apiserver,接受master的指令
```

> kube-proxy
```
为通过servcie来访问pod服务提供服务发现和代理以及负载均衡
proxy使用etcd的watch机制,监控service和endpoint的信息,维护service和endpoint的一个映射关系,实时更新转发规则
当后台pod ip发生变化时,不至于影响访问
```

> docker
```
image管理和pod以及container的运行
```