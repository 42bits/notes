[TOC]

### 数据类型
- python
    ```
    Number(int,float,boole,complex)
    String
    Tuple(元组)
    List(列表)
    Set（集合）
    Dictionary（字典）
    ```
    *number,string,tuple 不可变*

### 类型判断
- python
  ```
  a = 1
  isinstance(a,int) # return true
  type(a) # return <class 'int'>
  ```
  *type 不会认为子类和父类是同一个类型，isinstance相反*

### 空值
- python
    ```
    None,不等于0,0 是有意义的
    ```
### 常量
- python
    ```
    使用全大写来表示，实际python没有常量
    ```
### 变量
- python
    ```
    变量名必须是大小写，数字和_ 组合,不能用数字开头
    a = 20.0
    a = "string"
    a = (1,2,3,4,5)
    a = [1,2,3,4,5]
    a = {1，2,3,4,5，5} 或 a = set(123455) # 空集合只能使用set()，print(a) 会过滤掉重复的值
    a = {'one':1,'two':2,'three':3,'four':4,'five':5}
    ```

### 变量作用域
- python
    ```
    变量定义后是有一定的使用范围
    1：全局变量（函数外定义的变量），整个程序范围内访问，任何函数都可以
    2：局部变量（函数内定义的变量），函数内部访问，外部访问不了

    作用域由lambda,class，def 语句产生，if,try,for不会产生(语句内定义的变量,外部可以引用，但不会超过lambda，class，def的范围)

    变量搜索规则（legb）
    locals 是函数内的名字空间，包括局部变量和形参
    enclosing 外部嵌套函数的名字空间（闭包中常见）
    globals 全局变量，函数定义所在模块的名字空间
    builtins 内置模块的名字空间
    ```
