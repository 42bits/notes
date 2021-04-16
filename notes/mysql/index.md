[toc]

### 一条查询语句如何执行
- mysql基本架构
    - server层
        - 连接器
            ```
            mysql -h$ip -P$port -u$root -p
            show processlist
            ```
            连接mysql建议使用连接池来管理长连接，
        - 缓存（8.0废弃）
        - 分析器
            - 词法分析，识别出关键字、表、列
            - 语法分析
        - 优化器
            - 表里有多个索引，决定用哪一个
            - 多表查询，决定表的先后
        - 执行器
            - 权限检查
            - 根据表的引擎，调用引擎提供的接口
                - 没有索引
                    - 调用引擎接口去表数据第一行，如果不是跳过，否则这行存在结果集中
                    - 调用引擎接口取下一行，重复相同的逻辑判断，知道最后一行
                    - 将上述遍历过程中所有满足的行组成记录集作为结果集返回给客户端
                - 有索引
                    - 调用取满足条件的第一行接口，之后循环取满足条件的下一行接口
                    - 将上述遍历过程中所有满足的行组成的记录集作为结果集返回给客户端

            慢查询日志中会有rows_examined,表示这个语句执行中扫描来多少行，这个数据是执行器每次调用引擎获取数据时的累加。
            有些场景，执行器调用一次，引擎内部会扫描多行，因此引擎扫描行数和rows_examined并不是完全相等的

    - 存储引擎层

### 一条更新语句是如何执行的
流程和查询一致，只是多了个日志模块的调用，redo log（重做日志） ，binlog（归档日志），类似于酒店消费记录，一个用于速记（xxx消费了多少钱）的黑板，一个用于最后的对账（xxx最终消费了多少钱）的账本，配合使用就是mysql的wal技术（write-ahead logging）,先写日志，在写磁盘。

- 日志模块
为了使数据库在发生异常重启后，之前提交的记录不会丢失，引入了crash-safe 概念，`todoing`不是很懂

    - redo log（innodb引擎独有）
        有更新，innodb引擎会把记录写入redo log中，并更新到内存。
        写入到磁盘中，innodb会在空闲时或者redo满了时。
        redo log是循环写的，空间固定会用完，write pos 和checkpoint
    - binlog
    mysql server层的日志模块，所有引擎都可以使用
    binglog 是追加写的，写到一定大小会切换到下一个，不会覆盖

- 执行流程
    - 执行器根据where条件找引擎获取到数据，读入内存
    - 执行器根据set更新该数据后再次调用引擎接口写入数据
    - 引擎将更新后的数据写入内存，同时写入redo log中并且redo log处于prepare状态，并告知执行器，写完，可以提交事物。
    - 执行器生成该操作的binlog，并写入磁盘
    - 执行器调用引擎的提交事物接口，引擎把刚刚写入的redo log 改成commit状态，更新完成
    ```
    将redo log拆两个步骤，prepare和commit就是两阶段提交
    ```

- 为什么要两阶段提交
为了让两份日志之间的逻辑一致。
假设初始：id=2的value=0，更新value=1
    - 先写redo log，再写binlog
    redo log写入后，系统奔溃，数据回复后，value=1，但是binglog没有记录到，此时binlog相当于少记录了一条，此时用binlog恢复后value=0，原来value=1，不一致
    - 先写binlog在写redo log
    binlog写入后，系统奔溃，由于redo log 还没有写，恢复后，这个事务无效，value=0，不变，但是binlog里有value=1的记录，后面用binlog来恢复，value=1，与原来的值不一致

- 设置
innodb_flush_log_at_trx_commit=1，每次事务的redo log都持久化到磁盘，可以保存系统重启后数据不丢失
sync_binlog=1，每次事务的binlog都持久化到磁盘，保证系统重启后binlog不丢失


