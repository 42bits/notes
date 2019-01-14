> 负责整个集群的管理和控制,kube的所有命令基本都是发给master,由他去负责具体的执行

> apiserver
```
操作资源的唯一入口,提供多种服务(认证,授权,访问控制,api注册和发现)
组件之间的通信全部由apiserver接管,只有apiserver能连接etcd
其他组件只能通过apiserver读写etcd信息
```
> etcd
```
一个开源软件,提供分布式数据存储,保存有整个集群的状态
主要用来共享配置和服务发现
```
> controller-manager
```
维护集群的状态,故障检测,自动扩容和滚动更新,所有资源的总负责
管理多个控制器,每个资源都有一个控制器对应,比如
deployment-controller
replicaset-conrroller
replication-controller(定期关联replication-controller和pod,保证该控制器定义的复制数量与实际的运行pod数量是一致的)
node-controller(定期检查node健康状态,标识出各个node的状态)
namespace-controller(维护ns,清理ns)
service-controller
endpoints-controller(定期关联 service和pod[关联对象由endpoint维护],保证service到pod的映射是最新的)
presister-controller
deamonset-controller
resource-quota-controller
```
> scheduler
```
集群中node的资源收集和分析负载情况,
负责监控pod,按照预定的策略调度到相应的节点上,
将pod的binding信息写入etcd
方法有二
1:如果没有符合的node,该pod会被挂起,直到有合适的node出现
2:对node进行评优,选择最优的node
```