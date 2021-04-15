
### mac使用brew
```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

### 终端代理
```
export http_proxy=http://127.0.0.1:1080
export https_proxy=http://127.0.0.1:1080

# 关闭
unset http_proxy

```

### ip信息
```
curl cip.cc
curl ip.cip.cc
```

### ps&net工具
```
apt-get install procps
apt-get install net-tools
```

### pip
```
yum install epel-release
yum install python-pip
pip --version
pip install --upgrade pip
```

### openvpn
```
sudo apt install openvpn
sudo apt-get install network-manager-openvpn-gnome
sudo /etc/init.d/network-manager restart
客户端：导入.ovpn后缀的文件
终端： openvpn ./xxx.ovpn
```

### shell

[shell](./shell.md)

### top
[top](./top.md)

### 查看pid(10进制)的16进制的表现方式
```
python
import os,sys
hex(10)
```

### ubuntu 使用ntfs盘
```
mount | grep gvfs

sudo umount -fl /run/user/（用户ID数字） gvfs
sudo rm -rf /run/user/（用户ID数字） gvfs

reboot

PS: 用户ID用命令
id xxx
查看数字编号

```

### 误删 .bashrc,恢复

```
cp /etc/skel/.bashrc ~/

skel 是ubuntu各种初始文件存放的地方


```
### 解压&&压缩
> x 解压 ，c 压缩，v 显示，f置顶文档名，z 是否具有gzip属性，j是否具有bzip2属性，r递归

.tar.gz
```
tar -zxvf test.tar.gz
tar -zcvf test.tar.gz test
```

.tar.bz2
```
tar -jxvf test.tar.bz2
tar -jcvf test.tar.bz2 test
```
.tar
```
tar -zxvf test.tar
tar -zcvf test.tar test
```
.zip
```
unzip test.zip
zip -r test.zip test
```



