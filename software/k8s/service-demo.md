```
apiVersion: v1
kind: Service
metadata:
  name: my-svc
spec:
  clusterIp: 10.23.1.23  #可以自己指定集群ip地址
  selector:
    app:k8s-demo
  ports:            # 会将请求代理到使用tcp的80端口,并且具有"app:k8s-demo"label的pod上
    - name: http    #如果service需要暴露多个端口,必须给端口命名,这样endpoint就不会产生歧义
      port: 80
      targetPort: 8081  # 容器暴露的端口,也可以使用pod定义的端口名称,好处是如果下个版本修改了端口,不会中断客户端的调用
      protocol: TCP  # 默认tcp,支持tcp和udp
    - name: https
      port: 443
      targetPort: 8081
      protocol: TCP
---

apiVersion: v1
kind: Endpoint
metadata:
  name:my-svc
subsets:
- address:
  - ip: 192.168.1.11
  ports:
  - port: 8081
    name: http
    protocol: TCP
```