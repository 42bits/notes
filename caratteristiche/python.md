### pip 使用
```
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py

sudo python get-pip.py # 使用哪个python版本安装 pip就关联到哪个版本， sudo python3 get-pip.py 就是pip3版本
或
sudo apt-get install python-pip

pip install -U pip # 升级
或
sudo easy_install  --upgrade pip

安装库(==1.7.3 可以不需要指定，除非依赖固定的版本)
pip install sqlalchemy==1.7.3

升级库
pip install --upgrade sqlalchemy

卸载
pip uninstall sqlalchemy

搜索
pip search sqlalchemy

查看安装包(-f 详细信息)
pip show -f sqlalchemy

列出安装包
pip list

查看可升级的包
pip list -o

```

### 使用virtualenv and virtualenvwrapper
```
pip install virtualenv
pip install virtualenvwarpper

echo "export WORKON_HONE=$HOME/project/py" >> ~/.bashrc  #指定工作目录,`>>` 追加到文件， `>` 清空文件，写入内容

whereis virtualenvwrappe.sh 查看脚本路径

source xxx/xxx/xxx/virtualenvwrapper.sh #配置virtualwrapper源位置，不然 命令会失败，eg;mkvirtualenv test 提示命令不存在

基本命令
mkvirtualenv --python= python3 --no-site-packages test #创建一个名称为test 的环境 并且python版本为3,不需要已经存在的包
workon test 选择工作的环境
deactivate 退出环境
rmvirtualenv 删除虚拟环境
workon or lsvirtual 列出环境


vscode 使用虚拟环境

"settings": {
        "python.pythonPath": "/Users/xxx/env/ps36/bin/python",
        "python.venvPath": "/Users/xxx/env",
        "python.venvFolders": [
            "pro1",
            "pro2",
            "pro3"
        ]

    }

重新启动vs code，然后打开python工作区，然后cmd+shift+p然后输入选择Python: Select Interpreter 就可以选择 venv 了

```

### 添加python搜索包路径

在site-packages 里添加xx.pth
内容为搜索包的路径：/home/xxx/lib

### 生成和安装requirements.txt依赖
```
pip freeze > requirements.txt

pip install -r requirement.txt

error:
Command "/usr/bin/python2 -u -c "import setuptools, tokenize;

yum install python -devel

yum install gcc

```


