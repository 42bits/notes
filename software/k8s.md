### k8s(kubernetes)

### 是什么
- 一个容器集群管理系统
- 基于容器的应用部署和维护以及升级
- 负载均衡和服务发现
- 支持跨机房和跨地区的集群调度

### 和docker compose 区别
- docker-compose 用来管理容器,只能管理当前主机上的容器
- k8s跨主机的容器管理平台

### [架构图](./k8s/base.md)
![](/image/k8s-base.png)

----

![](/image/kubernetes-high-level-component-archtecture.jpg)
### [master主要组件](./k8s/master.md)

### [node主要组件](./k8s/node.md)

### [对象](./k8s/obj/obj.md)
- [namespace](./k8s/obj/ns.md)
- [node](./k8s/obj/no.md)
- [label](./k8s/obj/lable.md)
- [configMap](./k8s/obj/conf.md)
- [volume](./k8s/obj/volume.md)
- [pod](./k8s/obj/pod.md)
- [deployment](./k8s/obj/deploy.md)
- [service](./k8s/obj/svc.md)
- [ingress](./k8s/obj/ingress.md)

### [授权](./k8s/rbac.md)

### [demo](./k8s/create-demo.md)

### yaml-demo
- [deploy](./k8s/deploy-demo.md)
- [service](./k8s/service-demo.md)