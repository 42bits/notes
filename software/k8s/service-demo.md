apiVersion: v1
kind: Service
metadata:
  name: my-svc
spec:
  selector:
    app:k8s-demo
  ports:
  - protocol: TCP
    name:http
    port: 80
    targetPort: 80

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