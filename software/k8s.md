### k8s(kubernetes)

### 是什么

一个容器集群管理工具,可以实现容器的自动化部署,自动扩容和维护

也是应用管理工具. `创建集群,部署应用,发布应用,扩展应用,更新应用`

### 和docker compose 区别

dockercompose 用来管理容器,只能管理当前主机上的容器

k8s  跨主机的容器管理平台,

### [架构图](./k8s/base.md)

### [master主要组件](./k8s/master.md)

### [node主要组件](./k8s/node.md)

### [对象](./k8s/obj/obj.md)
- [namespace](./k8s/obj/ns.md)
- [node](./k8s/obj/no.md)
- [label](./k8s/obj/lable.md)
- [volume](./k8s/obj/volume.md)
- [deployment](./k8s/obj/deploy.md)
- [pod](./k8s/obj/pod.md)
- [service](./k8s/obj/svc.md)

### [授权](./k8s/rbac.md)

### [demo](./k8s/create-demo.md)

### yaml-demo
- [deploy](./k8s/deploy-demo.md)
- [service](./k8s/service-demo.md)