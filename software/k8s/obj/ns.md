### namespace
```
主要用于多租户的资源隔离

规范:[a-z0-9]([-a-z0-9]*[a-z0-9])?

可以使用namespace 创建多个虚拟集群,默认default,kube-system

kubectl create namespace test-ns

cat my-ns.yaml
apiVersion:v1
kind: Namespace
metadata:
    name:test-ns

kubectl create -f my-ns.yaml

kubectl delete namespace  test-ns

删除ns会删除属于该ns的所有资源
默认的ns不能被删除

kubectl get ns

node和persistentVolumes 不再ns中,events是否存在取决于 产生events的对象
其他大部分在ns中

```