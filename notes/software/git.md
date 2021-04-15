### bash 显示git branch
```
vi .bashrc

function git_branch {
   branch="`git branch 2>/dev/null | grep "^\*" | sed -e "s/^\*\ //"`"
   if [ "${branch}" != "" ];then
       if [ "${branch}" = "(no branch)" ];then
           branch="(`git rev-parse --short HEAD`...)"
       fi
       echo " ($branch)"
   fi
}

export PS1='\u@\h \[\033[01;36m\]\W\[\033[01;32m\]$(git_branch)\[\033[00m\] \$ '

source ./.bashrc


```

### 常用配置
```
[user]
	email = congxi@yunshan.net.cn
	name = congxi
[alias]
        lg = log
        lt = log --stat
        lm = log --pretty=format:
        ld = log --graph --pretty=format:'%Cred%h %C("#009966")%an  %Cred=>  %C(yellow)%d%Creset%s %Cgreen[%cr|%ci]%Creset' --abbrev-commit
        l5 = log --graph --pretty=format:'%Cred%h %C("#009966")%an  %Cred=>  %C(yellow)%d%Creset%s %Cgreen[%cr|%ci]%Creset' --abbrev-commit -5
        l10 = log --graph --pretty=format:'%Cred%h %C("#009966")%an  %Cred=>  %C(yellow)%d%Creset%s %Cgreen[%cr|%ci]%Creset' --abbrev-commit -10
        l20 = log --graph --pretty=format:'%Cred%h %C("#009966")%an  %Cred=>  %C(yellow)%d%Creset%s %Cgreen[%cr|%ci]%Creset' --abbrev-commit -20
[color]
        ui = true


[core]
	ignorecase = false
```

### 清除commit中间的某个提交
```
未push到远端

git reset --HEAD CommitA
git cherry-pick CommitC,CommitD
```
```
已经push到远端

git revert CommitB
```

### 统计当前分支提交次数
> git rev-list --count HEAD

> git rev-list HEAD|wc -l

### 合并commit
> git rebase -i xxx(一个commitid）

> pick 改为 s

> 修改 commit

> wq

### lfs 大文件
> (添加源到列表源中,不是必须) curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash

> apt-get install git-lfs

> git lfs install

### 使用子模块

建议指定子模块的分支（默认为master），实际开发中关联使用的子模块一般都不是master，通过以下命令指定

> git config -f .gitmodules submodule.d17n.branch release_5_4_1

clone 含有子模块的项目(fauths为例)

方式一
> git clone --recursive  ssh://git@gitlab.x.lan:1022/web/fauths.git

方式二
```
git clone ssh://git@gitlab.x.lan:1022/web/fauths.git
git submodule init
git submodule update
cd d17n
git checkout master
```

主项目添加子模块(fauths为例)
```

git clone ssh://git@gitlab.x.lan:1022/web/fauths.git

cd fauths

git submodule add http://gitlab.x.lan/web/d17n.git

cd d17n
git checkout master
git pull --rebase
```

更新子模块

- 建议在子项目中执行相关命令，主项目中默认子项目为master分支
- 命令和主项目中执行命令基本一致
- 看清使用的具体分支

更新主项目

> 需要注意使用的子模块分支，已经是否已经落后于gitlab上的提交，避免将子模块的旧代码更新上去

删除子模块
```
git rm --cached d17n #将d17n从版本控制中删除（本地仍保留有），若不需要可不带 --cached进行完全删除
vim .gitmodules #删除对应的submodule
vim .git/config #删除对应的submodule
rm -rf .git/modules/d17n #删除.git下的缓存模块
```

[git使用](/image/git.png)