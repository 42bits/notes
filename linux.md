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