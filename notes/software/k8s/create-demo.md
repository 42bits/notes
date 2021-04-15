### demo

```
查看cluster 信息
kubectl cluster-info

查看节点信息
kubectl get nodes -o wide
```

### 部署应用
```
kubectl run kel --image=nginx:1.14 --port=8080 --labels=app=kel --replicas=3

kind: Deployment
apiVersion: extensions/v1beta1
metaData:
  name: kel
spec:
  selector:
    app: kel
  replicas: 3
  template:
    metadata:
      labels:
        app: kel
    spec:
      containers:
      - name: kel
        image: nginx:1.14
        ports:
        - containerPort: 8080
          protocol: TCP
          port: 80

kubectl create -f xxx.yaml --record
查看是否部署
kubectl get pods -o wide
kubectl get deployments/kel
```
### 发布应用
```
kubectl expose deployment kel --type="NodePort" --port=80 --target-port=8080

apiVersion: v1
kind: Service
metadata:
  name: kel
spec:
  selector:
    app: kel
  ports:
  - name: default
    protocol: TCP
    port: 80
    targetPort: 8080

查看是否发布
kubectl get svc/kel
kubectl get svc -l run=kel `-l run=kel 表示选择label 为run=kel`
kubectl get pods -l run=kel
kubectl describe services/kel
```

### 扩容和缩容(添加或减少pod)
```
kubectl scale deployments/kel --replicas=2 `pod设置为2个`
kubectl get pods  -o wide

kubectl scale deployments/kel --replicas=1
kubectl get pods -o wide
```

### 更新
```
kubectl set image deployments/kel kel=nginx:1.15
kubectl rollout undo deployments/kel
```