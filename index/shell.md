### 软链接
> ln -s  源文件或目录  目标目录或目录

### 查看用户组和用户
```
cat /etc/groups
cat /etc/password
```
### 查看当前用户信息
```
id username
groups groupname
```
### 用户多个组
> usermode -G groupname1,groupname2 username

### 格式化文件为unix
> find ./ |xargs -l {} dos2unix {}

### 修改host
>  sudo vim /etc/hosts

### 重启网络
> /etc/init.d/networking restart
> 

### grep 查找文件是否包含
> grep -rin "hello" *

```
* 当前目录
r 递归查询
n 显示行号
i 忽略大小写
R 查找所有文件包含子目录
w 匹配整个单词，不是字符串的一部分
```
> grep "test" |"qqq" *  匹配test 或qqq

> grep "test" * |grep "qqq" 同时匹配 test 又匹配qqq

> grep im* * 匹配到 vim time

> grep "\<vim" * 匹配到 vim

> grep "\<vim\>" 匹配到 vim




