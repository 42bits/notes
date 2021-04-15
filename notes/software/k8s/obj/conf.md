### configmap

- 可以用于容器的环境变量
- 容器启动命令的启动参数(需要设置为环境变量)
- volume的挂载
- 必须在pod之前创建
- 可以定义namespace
- 只能被api-service管理的pod调用,静态pod无法使用
- volume 只能挂载为目录,不能为文件

```
apiVersion: v1
kind: ConfigMap
metadata:
  name:test-conf
data:
  appname: test
  appdir: /vat/data
```

```
kubectl get configmap
```