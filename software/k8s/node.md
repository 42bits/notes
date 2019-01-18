> 真正提供服务的实例

> kubelet
```
pod能否在node上运行最终决定权在kubelet(pod的创建,修改,监控,删除)
kubelet默认使用cadvisor进行node和pod的状况
并将node,pod以及容器的运行状态通知给apiserver,接受master的指令
维护pod的生命周期,也同时负责volume 和network的管理
```

> kube-proxy
```
proxy使用etcd的watch机制,监控service和endpoint的信息,维护service和endpoint的一个映射关系,实时更新转发规则(iptables), 当后台pod ip发生变化时,不至于影响访问

为通过servcie来访问pod服务提供服务发现和代理(为service提供虚拟ip[vip]cluster-ip,并设置iptables代理)以及负载均衡

代理规则:
iptables:
对每个service对象会安装一个iptables[网络数据包的处理和转发]规则,从而捕获到达该cluster-ip和port的请求,进而将请求重定向到一组backend的某个pod上
对于endpoints对象,也会安装iptables规则,这个规则会选择一个backend pod

```

> docker
```
image管理和pod以及container的运行
```