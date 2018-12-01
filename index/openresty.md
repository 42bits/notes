### 时间类型

- request_time
```
从接收客户端发来的第一个字节开始到发送完最后一个字节给前端话费时间

接收客户端数据时间，后端处理时间，发送数据给客户端时间

upstream_response_time

nginx 和后端建立连接到接收完数据，关闭连接时间
```

- upstream_connect_time

> nginx 和后端建立连接时间，如果使用了ssl ，那么还包含该时间

*upstream_response_time 在header 中不准确*
```
其值在log 阶段才生成（ngx_http_log_phase)
发送响应头处于内容生成阶段，（ngx_http_content_phase),期间获得的响应值，是初始化时间戳

要正确打印其值，可在日志格式中声明

http {
  ...
  log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
        '$status $body_bytes_sent "$http_referer" '
        '"$http_user_agent" "$http_x_forwarded_for" "$request_time" "$upstream_response_time"';
}


```
