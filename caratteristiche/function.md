### 定义
- python
```
    def my_abs(x):
        if x > 0 :
            return x
        else:
            return x+1
```
 - 如果没有return 也会返回值，结果为None,return NOne 简写 return
 - 定义空函数 使用pass 返回
 - 必要时需要对参数做类型检查，isinstance()
 - 可以返回多个值，实际返回的是tuple

### 调用
- python
```
    需要知道函数名，和需要参数，如果参数数量不对会报TypeError错误，如果数量对，但是类型不对，也会报TypeError错误
```

### 参数
- python
```
    位置参数：(调用函数时，传入的两个值，按照位置，依次赋给x，y
        def test(x,y):
            pass
        test（1,2）
    
    默认参数：(必选参数在前，默认参数在后)
        def test(x,n=2,y=1):
            pass
        test(1)[默认n=2,y=1] 或 test(1,3)[n=3,y=1] 或 test(1,y=1)[n=2,y=1]

        *默认参数必须指向不可变对象*

    可变参数：numbers 接收到的值为一个tuple,可以传入任意个参数或0个参数
        def test(*numbers):
            sum = 0
            for v in number:
                sum += v
            return sum
        test(1,2,3,5,6) 或 num = [1,2,3,4] test(*num)

    关键字参数：接收到的值为一个字典，可以传入任意个含参数名的参数或0个参数，kw获取到的是一份拷贝，修改不会影响函数外的变量值
        def test(x,y,**kw):
            print(x,y,kw)
        test(1,2)[x=1,y=2,kw空]或 test(1,2,n='test',z=20)[x=1,y=2,kw={'n':'test','z':20}] 或 dics={'name':'te','age':10} test(1,2,**dics)
   
   命名关键字参数：关键字参数，用户可以传入任意的关键字参数，为了做限制可以使用命名关键字参数，比如只接收city和age作为关键字参数
        def test(x,y,*,city,age):
            print(x,y,city,age)
        test(1,2,city='beijing',age=20)
        如果函数中定义的可变参数，后面跟着的命名关键字参数就不需要*分割符(可以有默认值，那么调用时就不需要传该参数了)
        def test(x,y,*args,city='beij',age):
            pass
        test(1,2,3,4,5,age=20)[x=1,y=2,args=(3,4,5),city=beij,age=20]

```
*参数定义顺序必须是，必须参数，默认参数，可变参数，命名关键字参数，关键字参数*




