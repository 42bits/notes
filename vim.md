### 更新

> brew install vim --with-lua --with-override-system-vim --with-python3 --with-python

### 添加注释和取消注释（试图模式[ctrl+v]）

- 选中行
- 大写I
- 添加注释符号
- esc（添加）
- d（删除）

### 批量替换

100到199行将# 替换成x
> :100,199s/#/x/g

全局替换

> ：%s/#/x/g

当前行替换
> s/#/x/g

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
:E 打开目录选择

:He 把当前窗口上下分屏，并在下面进行目录浏

:He! 如果你要在上面，你就在 :He后面加个 !

:Ve在左边分屏间浏览目录，要在右边则是 :Ve!

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
