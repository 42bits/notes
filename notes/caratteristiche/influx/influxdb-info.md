### 时序数据库
> 基本都是写入，没有更新

> 数据基本都有时间属性，随着时间推移，不断产出新的数据

> 写入压力大，每秒钟千万的写入

*普遍用于 it 基础设施，运维监控，物联网*
```
获取最新状态
根据指定条件，筛选异常数据
指定区间范围，查询统计信息
```

mysql 缺点
```
存储成本大，对于时序数据压缩不佳，占用大量机器资源
维护成本高，单机系统，需要在上层，人工分库分表
写入吞吐低，单机写入吞吐低，难已满足千万的写入
查询性能差，用户交易处理，海量数据的聚合分析性能差
```

| infludb                                        | mysql            |
| ---------------------------------------------- | ---------------- |
| database                                       | database         |
| measurement                                    | table            |
| point                                          | row (一行数据）  |
| tag(只支持字符串)                              | index (索引）    |
| field（只支持str float int（float加i） boole） | column(一列数据) |
| retention policy（策略）                       | 无               |
| continuous qurey(连续查询= 定时任务)           | 无               |

*策略：指定数据在influxdb中存储时间，时间过期，会自动删除，influxdb没有提供删除动作，只能通过该方法*

eg:
> insert cpu_load_short,host=server01,region=us-west value=0.64,value1=12i 1434055562000000000

measurement=cpu_load_short
keys=host,region
field=value,value1
time=1434055562000000000

```
key 和field 之间有空格
boole 可以写 true，false，T，t,F,f(F,f,t,T 不能用在读中[select])
```

