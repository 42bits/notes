### 更新

> brew install vim --with-lua --with-override-system-vim --with-python3 --with-python

### inster
```
i 光标处
I 光标行首
a 光标后
A 光标行末
o 下一行
O 上一行
j 合并上下两行为一行
d 删除
c 剪切，并进入插入模式
P（大写） 光标前插入(粘贴)
p（小写）光标后插入（粘贴）
> 选择快进行缩进
< 选择快进行取消缩进
>> 当前行进行缩进
<< 当前行取消缩进

```

### 临时推出vim进入shell后在回来
```
:sh 进入 shell 环境
exit 退出shell 进入 vim

```

### 取得外部输入
```
:r!<cmd> 将命令cmd 的输出写入当前光标所在位置
:r<file> 将文件读入到光标所在位置
```

### 编辑没有权限的文件
> w !sudo tee %

### 撤销和恢复
> u 撤销 ; ctrl r 恢复 ; . 执行前一个命令

### 添加注释和取消注释（试图模式[ctrl+v]）

- 选中行
- 大写I
- 添加注释符号
- esc（添加）
- d（删除）

### 批量替换
> g 全局替换，i 不区分大小写

100到199行将# 替换成x
> :100,199s/#/x/g

全局替换

> :%s/#/x/g

当前行替换
> :s/#/x/g

### 复制粘贴（试图模式[v]）

- 内部
    - 选中行
    - 点击y
    - esc
    - 需要的地方，点击p

- 系统(vim --version | grep "clipboard" 查看是否支持交互 （出现+clipboard）)

    - `"+y` 复制
    - `"+p`粘贴

### 模拟tab
```
:E 打开目录选择,
:ls 查看打开的buffer ，buffer 1 选择为1的文件打开，（会冲掉当前打开的文件，一般不用）

:He 把当前窗口上下分屏，并在下面进行目录浏

:He! 如果你要在上面，你就在 :He后面加个 !

:Ve在左边分屏间浏览目录，要在右边则是 :Ve!


`-` 到上级目录
`D` 删除文件
`R` 重命名文件
`s` 对文件排序
`x` 执行文件


先按Ctrl + W，然后按方向键：h j k l

分屏同步移动（需要的屏执行命令）
：set scb
：set scb! 取消


Tab页浏览目录
：Te

gt 下一个tab
gT 上一个tab
3 gt 到第三个tab

：tabm 3 到第三个tab

现在打开的窗口和Tab的情况
：tabs

关闭tab
：tabclose 3 关闭第三个
：q

```
### 更新打开的文件

> :e

> :e! 放弃当前更改，强制更新

> bufdo e 所有文件

> bufdo e!

### 翻页and 跳转
> ctrl f 下一页 ctrl d 半页

> ctrl b 上一页 ctrl u 半页

> ctrl e 向上滚屏

> ctrl y 向下滚屏

> `{` 段落的开始 `}` 段落的结尾

> `（`句子的开始 `）` 句子的结束

```
hjkl 光标左下上右
0 光标移动到本行的开始
^ 本行开始的一个字符
$ 本行的末尾
b 单词的开头
e 单词的末尾
w 下一个单词的开头
W、E 相同，只不过以空格为分解点
```

```
+ 下一行的开头
- 上一行的开头
% 在最近的（）和{} 切换,(光标要先在标签的开始或结束)
gg  文件的开始
G 文件的结束
`:23` 跳转到23行
23gg 跳转到23

```

### vim配置
```

" 设置不兼容 VI 模式，在增强模式下运行
set nocompatible
" 覆盖文件时不备份
set nobackup
" 不启用交换文件
set noswapfile
" 保存文件格式
set fileformats=unix,dos
" 出错时，不要发出响声
set noerrorbells
" 读文件时，使用的编码。前 2 个顺序不能错
set fileencodings=ucs-bom,utf-8,cp936,gb2312,gb18030,gbk
" 保存时，使用的编码
set fileencoding=utf-8
" 程序使用的编码
set encoding=utf-8
" 终端上使用的编码
set termencoding=utf-8
" 菜单语言，必须要在 set encoding 之后,界面加载之前
set langmenu=zh_CN.utf-8
" 右键点击时，弹出菜单
set mousemodel=popup
"支持使用鼠标
set mouse=a
" 高亮显示当前行
set cursorline
" 关闭折行
set nowrap
" 显示行号
set nu
" 搜索时高亮关键字
set hlsearch
" 搜索时逐字高亮
"set incsearch
" 忽略大小写
set ignorecase
" 命令行按tab补全时，显示一个候选菜单
set wildmenu
set wildmode=longest:list,full
" 高亮显示匹配的符号，大括号什么的
set showmatch
" 右下角显示光标状态的行
set ruler
" 左下角显示当前的模式
set showmode
" 显示当前输入的命令
set showcmd
" 打开语法高亮
syntax on
" 缩进方式
set smartindent
" 为 C 程序提供自动缩进
set smartindent
set cindent
" 使用空格代替 tab.
set expandtab
set backspace=indent,eol,start
set tabstop=4
set softtabstop=4
set shiftwidth=4
" 显示一些不显示的空白字符 
" 通et list 和 set nolist 控制是否显示或是用 set list! 切换显示
set listchars=tab:»■,trail:■
set list
```


