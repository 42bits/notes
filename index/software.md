### [vscode](/software/vscode.md)
### [curl](/software/curl.md)
### [l2tp](/software/l2tp.md)
##  [vim](/software/index/vim.md)
##  [git](/software/index/git.md)
### [docker](/software/docker.md)
### [k8s](/software/k8s.md)


### brew
```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

### ss
```
export http_proxy=http://127.0.0.1:1080
export https_proxy=http://127.0.0.1:1080

curl cip.cc

unset http_proxy

```

### ps&net
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
