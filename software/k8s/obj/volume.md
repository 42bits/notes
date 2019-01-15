### volume
```
容器中的文件是非持久化,容器挂掉,文件会丢失,一个pod中的多个container需要共享文件,使用volume可以解决问题

docker中的volume是磁盘中的一个目录,生命周期不受管理,通过 多个 -v 可以挂载多个目录

k8s中的volume生命周期和pod一致,不随container的消失而消失,使用volume,pod需要指定volume的内容和类型(spec.volumes),容器配置需要指定(spec.containers.volumeMounts)

volume 支持多种类型,主要介绍几种,emptyDir,hostPath,nfs

emptyDir
当pod被分配到node上时,会创建,初始内容为空,不需要指定宿主机上的目录文件,有kube自动分配,当pod被删除,对应的emptyDir也会被删除

apiVersion:v1
kind:Pod
metadata:
    name:test-pd
spec:
    containers:
    - image:nginx:1.14
      name:test-nginx
      volumeMounts:
      - mountPath:/cache
        name:cache-volume
    volumes:
    - name;cache-volume
      emptyDir:{}

hostPath
挂载node节点上的文件系统到pod里,
缺点就是数据固定在某个node上,一但pod被调度到其他node上那么存储的数据将不能使用

volumeMounts:
- mountPath:/test-pd
  name:test-volume

volumes:
- name:test-volume
  hostPath:
    path:/var/data

pv(nfs):
网络文件系统,是基于rpc远程过程实现调用,nfs数据是永久保存的,支持同时写的操作
volumeMounts;
- mountPath:/data/nfs-test
  name:nfs-client

volumes:
- name:nfs-client
  nfs:
    server:192.168.1.1
    path:/usr/local/work/nfs

```