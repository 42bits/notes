### shell

[shell](./shell.md)

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





