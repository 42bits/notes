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


