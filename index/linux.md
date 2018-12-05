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
