### replicationController
```
确保kube中有指定数量的pod在运行,如果少于指定的pod replicas ,rc会创建新的pod,反之会杀掉多余的pod
,适用于long-running类型的业务类型
```

### replicaSet
```
rc的升级版本,区别就是rc的lable选择器种类只支持平等写法,而rs支持平等和集合写法,
一般不单独使用,使用deployment在自动管理replicaSet,做为deploy的理想状态参数使用
```

### deployment

rc的升级版本,一般使用deploy来管理pod,和replicaSet,不再使用上述两个

> 对应支持的功能:
- 创建一个deploy对象会创建一个对应的rs,在由rs在后台完成pod的创建
- 支持回滚和升级应用
- 扩容和缩容
- 暂停和继续
- 清除不需要的rs

> 滚动升级:
```
创建一个新的rs,逐渐将新的rs中副本数量增加到理想状态,将久的rs中副本数量减小到0,这是一个复合操作,适合deploy来操作,rs就比较复杂了
```

> 注意:

- 添加,更新selector 需要同时在spec template label做添加

`新的selector不会选择旧的selector创建的rs和pod,会导致旧的rs被丢弃,创建新的rs`

- 删除selector中的key 不需要更新 pod的label,但是旧的label会继续存在现有的pod和rs

> 状态
- progressing
- complete
- fail to progress

progressing:

deployment 在创建新的rs,扩容或缩容rs,有新的pod出现

complete:

deploy中replica数量等于或超过期望的数量,所有resplica都更新完成,没有旧的pod存在

fail to progress;

镜像拉取错误,配置错误,权限不够等

通过设定 spec.progressDeadlineSeconds 时间,来确定是卡住了还是真发生错误了

```
相关命令
kubectl get deploy
kubectl get rs
kubectl get rc
kubectl create -f xxx.yaml --record 创建,并将使用的命令记录
kubectl apply -f xxx.yaml 能创建,还能更新,一般使用该命令(其他kubectl create,replace,edit,patch)
kubectl describe deployments
kubectl set image deployments/kel kel=nginx:1.15 设置镜像更新
kubectl edit deployment/k8s-demo 编辑deploy

(rollout当且仅当deployment中的.spec.template中的label或image 更新时才会被触发,其他情况不会触发,比如扩容)

kubectl rollout paush deployment/nginx-deployment 暂停升级
kubectl rollout resume depoyment/nginx-deployment 恢复升级
kubectl rollout history deployment/nginx-deployment 查看历史
kubectl rollout undo deployment/nginx-deployment  回滚上个版本
kubectl rollout undo deployment/nginx-deployment --to-version=2 回滚指定版本
kubectl scale deployment nginx-reployment --replicas 1 设置副本数量为1
kubectl rollout status deployment/k8s-demo 查看rollout状态

```

[结构图](/image/deployment.png)