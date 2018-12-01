一次测试多个接口
[参考]（https://github.com/timotta/wrk-scripts)

wrk -t12 -c400 -d30s http://127.0.0.1:8080/index.html

使用12个线程运行30秒, 400个http并发

```
-c, --connections: 总的http并发数

-d, --duration:    持续压测时间, 比如: 2s, 2m, 2h

-t, --threads:     总线程数

-s, --script:      luajit脚本,使用方法往下看

-H, --header:      添加http header, 比如. "User-Agent: wrk"

    --latency:     在控制台打印出延迟统计情况

    --timeout:     http超时时间

```

### post 测试

> wrk -t2 -c100 -t30s -T10s -s post.lua http://127.0.0.1/

post.lua
``` lua

wrk.method="POST"
wrk.headers["Content-Type"]="application/json"
wrk.body=""{test:"ssss",name:"na"}

#每个request参数不一样

request = function{
    uid =math.random(1,1000)
    path = "test?id=" .. uid
    return wrk.format(nil,path)
}

```
```
wrk.format这个函数的作用,根据参数和全局变量wrk生成一个http请求
函数签名: function wrk.format(method, path, headers, body)
method:http方法,比如GET/POST等
path: url上的路径(含函数)
headers: http header
body: http body
```

![](/image/wrk.png)


