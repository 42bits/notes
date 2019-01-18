###  service

- 是一个真实服务的抽象,后面有很多对应的container在支持该服务,
- 前端应用,通过该入口访问背后的一组由pod副本组成的集群实例
- 在service中通过selector选择具有相同lable的pod作为一个整体,将信息写入etcd中
- 该工作由service-controller来完成
- service 和pod的映射关系有endpoint controller 来维护
- 使pod的更新,删除,在通过service调用pod的前端来看是没有影响的,也不需要关心
- 创建service时如果选择了selector 会创建一个endpoint 对象
- 如果没有选择,不会创建endpoint,可以通过yaml来创建(kubectl get ep)
- service 能访问 pod ,通过selector来选择label来关联,注意label的定义

#### 没有selector 的service
没有selector的service不会自动创建endpoint,可以手动的将service映射到指定的endpoint

访问该service和普通的service一样,都会被路由到用户指定的endpoint上

externalname service 是没有selector和 定义端口以及endpoint的一个特殊的service
```
apiVersion: v1
kind: service
metadata:
  name: my-svc
  namespace: prod
spec:
  type: ExternalName
  externalName: my.example.com

```

#### 服务发现

- 环境变量
- dns

环境变量:

- pod 运行在node上,kubelet会为每个活跃的service添加一组环境变量,
- 只有在pod创建前的service才会能被container获取到
- 可以在pod中通过`env`查看所有的环境变量(kubectl exec -it pod-name /bin/bash 进入pod查看)

dns:

- 一个可选的集群插件
- 他监视着kube,如果有新的service被创建,会为每个service创建一个dns记录,


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

#### 从集群外部访问集群内应用ip走向
- proxy-ip: 外部访问应用的网关ip,代理层公网ip
- service-ip(cluster-ip): service的虚拟ip(vip),是内部ip,外部无法寻址
- node-ip: 容器宿主机ip
- container-bridge-ip : 容器网桥ip(docker0),容器的网络都由该网桥转发
- pod-ip: 等效与容器中的container-ip
- container-ip: 容器ip,容器的网络是个隔离网络空间

#### 提供服务
通过service yaml 中的spec.type来指定 服务类型

- clusterIP
- nodePort
- loadBalancer
- externalName

> clusterIP

通过集群内部ip暴露服务,服务只能在集群内部可以访问,也是默认值

> nodePort

通过每个node的ip和port(NodePort) 暴露服务,通过nodePort访问会路由到clusterIp(会自动创建),通过nodeport 可以从集群外部访问服务,会自动分配一个node上的port(30000-32767),通过集群内的任何一个ip和port都能访问服务

> lb

使用云服务商提供的负载均衡,外部可以访问服务,外部的负载均衡器可以路由到nodeport和clusterip
```
kind: Service
...
...
spec:
  loadBalancerIp: 78.12.45.77
  type: loadBalancer

```

> externalName

通过返回 CNAME 和它的值，可以将服务映射到 externalName 字段的内容（例如， foo.bar.example.com）。 没有任何类型代理被创建

> 外部ip

如果外部ip路由到集群中一个或多个node上,service会被暴露给这些externalIps,通过外部ip进入到集群,打到service的流量,会被路由到service的endpoint上
```
客户端通过80.34.23.66:80 来访问服务

kind: Service
apiVersion: v1
spec:
  selector:
    app: k8s-demo
  ports:
   - name: http
     port: 80
     targetPort: 8080
     protocol: TCP
  externalIps:
    - 80.34.23.66
```

#### iptables
当一个service被创建,master会分配一个vip地址

该service会被kube-proxy发现,并创建一系列的iptables,保证通过vip能访问到endpoint的pod


#### 容器之间通信
同一个pod中的container 共享网络命名空间,通过localhost互访

#### pod 之间通信
- 同一个node中的pod通信,通过pod ip 进行互访
- 不同node间的pod通信,需要保证整个集群中的pod-ip不能有冲突,node-ip和pod-ip关联起来,通过node-ip转发到pod-ip(Flannel)



