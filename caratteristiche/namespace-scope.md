### 作用域和命名空间
- python
    ```
    python中一切都是对象，一般通过定义一个变量来使用该对象（引用），名字和对象的关系保存在一个字典中
    这个字典就叫做命名空间
    ```
    ```
    任何一个模块、类、实例、函数、都有其自己的命名空间，可以通过__dict__来访问
    ```
    ```
    变量定义后是有一定的使用范围，叫做作用域
    1：全局变量（函数外定义的变量），整个程序范围内访问，任何函数都可以
    2：局部变量（函数内定义的变量），函数内部访问，外部访问不了

    作用域由lambda,class，def 语句产生，if,try,for不会产生(语句内定义的变量,外部可以引用，但不会超过lambda，class，def的范围)

    变量搜索规则（legb）
    locals 是函数内的命名空间，包括局部变量和形参
    enclosing 外部嵌套函数的命名空间（闭包中常见）
    globals 全局变量，函数定义所在模块的命名空间
    builtins 内置模块的命名空间
    ```
    ```
    global 声明一系列变量，该变量会引用当前模块的全局命名空间的变量，如果该变量没有定义，也会在全局空间中添加这个变量
    nolocal 声明一系列变量，该变量会从里到外的去搜寻这个变量，直到模块的全局域
    （不包括全局域），找到了则引用这个命名空间的这个名字和对象，若作赋值操作，则直接改变外层域中的这个名字的绑定
    如果在外层域中没有找到，则报错

    def test():
        def do_local():
            spam = "local spam"
        def do_nonlocal():
            nonlocal spam
            spam = "nonlocal spam"
        def do_global():
            global spam
        spam = "global spam"
        spam = "test spam"
        do_local()
        print("after local assignment:", spam)   #输出：test spam
        do_nonlocal()
        print("after nonlocal asssignment:", spam)   #输出：nonlocal spam
        do_global()
        print("after global assignment:", spam)    #输出：nonlocal spam

     test()
     print("in global scope:", spam)  #输出：global spam

     nonlocal spam 没有在函数do_nonlocal()的域中创建一个变量，而是去引用到了外层的，10行定义的spam。

    global spam，在全局域中创建了一个name，9行将其绑定在字符串常量对象"global spam"上。
    ```
    ```
    locals() 返回局部命名空间（函数，或方法）
    globals() 返回当前module的命名空间

    locals()和globals()有一个区别是，locals只读，globals可以写

    def func(a = 1):
        b = 2
        return a+b
    func()
    glos = globals()
    glos['new_variable'] = 3
    print(new_variable)

    def func(a = 1):
        b = 2
        locs = locals()
        locs['c']  = 1
        print(c)
    func()
    # NameError: name 'c' is not defined
    ```