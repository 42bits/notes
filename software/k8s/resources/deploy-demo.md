```
apiVersion: extensions/v1beta1 # 接口版本

kind: Deployment    #资源类型
metadata:                   #元数据
    name:nginx-deployment   #名称,必须有
    namespace: default      # 名字空间
    labels:                 # 标签
        app:nginx
spec:                           #deployment规格说明,必须有
    replicas:1                   # 启动的pod数量,默认1
    strategy:
        rollingupdate:          #滚动升级时配置
            maxSurge:1          #滚动升级时启动的pod个数
            maxUnavailable:1    #滚动升级时允许的失败pod个数
        type:RollingUpdate
    selector:
        matchLabels:
            run:nginx-test
     template:                      #模板,必须有
        metadata:                   #pod 的元数据,labels必须有
            labels:
                run:nginx-test      #模板名称
        spec:                                       # pod规格说明,必须有
            containers:                             #容器,可以有多少
            - name:nginx                            #container名称
              image:nginx:1.14                      # image 名称
              imagePullPolicy:IfNotPresent          #镜像获取策略 Always,Never,ifnotpresent
              port:
              - containerPort:80                    #容器暴露的端口
        resources:{}                                 #容器的一些资源配置,一般是cpu和memory
        env:                                        #环境变量,容器内部的应用可以使用
        - name:LOCAL_KEY
          value:value
        volumeMounts:                               #挂载目录
        - name:log-cache
          mount:/tmp/log
        - name:sdb
          mount:/data/test
        - name:nfs-client-root
          mount:/mnt/nfs
        - name:ex-volume-config                     #将ConfigMap的log-script,backup-script分别挂载到/etc/config目录下的一个相对路径path/to/...下，如果存在同名文件，直接覆盖
          mount:/etc/conf
        - name:rbd-pvc
    volume:
    - name:log-cache
      emptyDir:{}                                   #有效期和pod一致,pod被删除,该挂载也会被删除
    - name:sdb
      hostPath:                                     #使用node上的文件系统,挂载到pod里,有效期和pod一致,pod被删除,该挂载系统里的文件不会被删除
        path:/any/path/it/will/be/replaced
    - name:ex-volume-config                         # 该挂载每一个key的value挂载在指定的目录下,是相对目录
      configMap:
        name:ex-volumt-config
        items;
        - key:log-script
          path:path/to/log-script
        - key:backup-script
          path:path/to/backup/script
    - name:nfs-client-root                          #网络文件系统
      nfs:
        server:10.24.2.44
        path:/opt/public
    - name: rbd-pvc                                 #挂载申请到的pvc磁盘
      persistentVolumeClaim:
        claimName:rbd-pvc1

```