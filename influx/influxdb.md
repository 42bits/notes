### [基本信息](./influxdb-info.md)

### 创建和使用数据库
```
create database "testdb"
show databases
use testdb
drop database "testdb"
```

### 表
```
show measurements
show field keys from tbs 查询tbs表field字段结构，（去掉from tbs 默认全部measurements）
show tag keys from tbs 同上
show series from tbs 同上

show tag values from tbs with key=cpu 返回tbs中tag=cpu的 所有值
show tag values from tbs with in (host,cpu) where value1=test 返回tbs中tag=host和cpu的值，条件为field中value1=test的数据

show continuous queries 查看连续执行的命令
show queries 查看当前正在执行的cq（会返回pid 和具体语句）
kill query 1222 停掉pid=1222的cq
show rentention polices on testdb 查看testdb的数据保留策略

select * from cpu where  value1=test order by time desc limit 5  返回cpu表中所有字段，field中value1=test的值，按照时间倒序，返回五条
select value1 from /.*/ limit 1 返回所有表中field为value1的值，只返回一条

delete from tbs 删除tbs所有数据，那么表会不存在了
drop measurement tbs 删除tbs，但是数据会保留
delete from tbs where time < '2018-12-7T00:00:00Z'
delete where time < '2018-12-7T00:00:00Z'
drop database testdb
drop retention policy cp1 from testdb 删除 testdb中名称为cp1的策略
drop series from tbs1,tbs2 where cpu=cpu1 删除tbs1和tbs2中series中tag为cpu且值为cpu1的数据
drop series where cpu='' 删除tag中的名为cpu的字段
```

### 策略
```
show retention policies on db1
alter retention policy default on rp1 defaule  修改rp1为默认策略
drop retention policy rp1 on db1 删除db1中名称为rp1的策略
create retention policy "rp1" on "db1" duration 30d replication 1 default 创建一个名为rp1的策略，数据有效期为30天，一个副本，状态为默认

时间参数（h 小时,m 分钟,w 星期,d 天）

```

### 函数
```
mean 平均值
sum 总和
min 最小值
max 最大值
count 总数

```

### 用户

开启登录认证
```
[http]
auth-enabled = true
```

```
show users
create user jshawcx with password 'admin'
create user jshawcx password 'admin' with all rpivileges 给予管理员权限
set password for jshawcx='admin1'

revoke all rpivileges from jshawcx
revoke read on db1 from jshawcx 取消用户在db1上的读权限（read，write，all）

show grants for jshawcx 查看权限
grant all to admin 给予admin 所有权限
grant read on db1 to jshawcx 

drop user jshawcx

```


http://www.ywnds.com/?p=10763
