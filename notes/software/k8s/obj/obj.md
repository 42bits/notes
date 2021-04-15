### 对象(都可以通过yaml来创建)
- 资源对象
  ```
  Pod、ReplicaSet、ReplicationController、Deployment、StatefulSet、DaemonSet、Job、CronJob、HorizontalPodAutoscaling、Node、Namespace、Service、Ingress、Label、CustomResourceDefinition
  ```
- 存储对象
  ```
  Volume、PersistentVolume、Secret、ConfigMap
  ```
- 策略对象
  ```
  SecurityContext、ResourceQuota、LimitRange
  ```
- 身份对象
  ```
  ServiceAccount、Role、ClusterRole
  ```
```
对象字段(必须)
apiVersion:创建对象时使用的api版本(kubectl api-versions)
kind:对象类型
metadata:对象元数据,识别对象唯一性的数据(name,uid,namespace)
spec:描述了对象的期望状态,通过yaml提供
status:描述了对象的实际状态,由系统提供和更新

kube通过读取spec 来调整status,使只系统保持期望状态

```

### 获取资源信息

```
导出资源描述1
kubectl get <resource-type> <resource>  --export -o yaml  > xxxx.yaml

kubectl get deployment kel-demo --export -o yaml > kel-demo.yaml

模拟命令执行2
kubectl run myapp --image=nginx:1.15 --dry-run -o yaml
```