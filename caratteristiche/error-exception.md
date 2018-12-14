### 错误

### 捕获异常
- python
    - 所有的错误类型都继承自BaseException

    ```
    try:
        r = 10/0
        print(r)
        raise Exception('spam', 'eggs')
    except ZeroDivisionError as e:
    ... print(type(e))    # 获取异常的实例 <class 'Exception'>
        print(e.args)     # 获取参数 （'spam', 'eggs'）
        print(e)          # __str__ 可以直接打印参数,（'spam', 'eggs'）
        print (e.message) # str(e),repr(e)给出较全的异常信息
    except (RuntimeError, TypeError, NameError,UnicodeError) as e:
        raise #不带参数，就会把当前错误原样抛出
        raise ValueError('input error') #可以把一种类型的错误转化成另一种类型
    else:
        print('else') #必须放在所有的except子句之后。这个子句将在try子句没有发生任何异常的时候执行
    finally:
        print('finally')
        #总是在离开 try 语句前被执行, 而无论此处有无异常发生。
        #当一个异常在 try 中产生, 但是并没有被 except 处理 (或者它发生在 except 或 else 语句中), #那么在 finally 语句执行后会被重新抛出. finally 语句在其他语句要退出 try 时也会被执行
    ```
    ```
    预定义的清理动作
    有一些任务，可能事先需要设置，事后做清理工作
    with 语句就允许像文件这样的对象在使用后会被正常的清理掉,不需要

    with open("test.txt") as f:
        for line in f:
            print(line)

    ```

### 自定义异常
- python
    ```
    程序中可以通过定义一个新的异常类来命名它们自己的异常. 异常需要从 Exception 类派生, 既可以是直接也可以是间接.
     class MyError(Exception):
        def __init__(self,value):
            self.value = value
        der __str__(self):
            return repr(self.value)

    try:
        raise MyError(22)
    except MyError as e:
        print('test error ',e.value)

    ```

[python 错误类型继承关系](/image/python-error.png)