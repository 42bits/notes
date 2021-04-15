### 类(class)、实例(instance)

类是抽象的模板，实例是根据类创建出来的一个具体的对象，每个对象拥有相同的方法，但各自的数据可能不同

类名通常一大写字母开头

通过继承和多态可以实现对扩展开放，对修改关闭，这就是`开闭原则`，见下文多态

- python
    - python 类有两种，经典类，新式类
    - 类对象支持两种操作：属性引用和实例化
    - self代表类的实例，而非类
    - 不要对实例属性和类属性使用相同的名字，否则将产生难以发现的错误
    - 由于实例属性优先级比类属性高，因此，它会屏蔽掉类中名称相同的属性

    ```
    class Student（object):
        '''
        构造函数，该方法在实例化时会自动调用
        '''
        ttt = ”33333“
        def __init__(self,name,age=20):
            self.name = name
            self.age = age
        def get_info(self):
            '''
            两种格式化方式
            '''
            print('%s,%s' % (self.name,self.age))
            print('hello {0},age is {1}'.format(self.name,self.age))
    ```
    ```
    print（Student.ttt）## 访问类变量
    stu = Student(congxi)
    print(stu.name) ## 访问实例变量
    stu.get_info()
    定义新增实例变量
    stu.address = 'suzhou'
    ```

### 限制(属性，方法)
- python
    ```
    如果想让属性外部不可访问，可以把属性的名称前加上两个下划线__，方法也一样
    class Student(object):

    #定义基本属性
    age = 0
    #定义私有属性,私有属性在类外部无法直接进行访问
    __name = ''
    __score = 0

    def __init__(self, name, score,age=20):
        self.age = age
        self.__name = name
        self.__score = score

    #私有方法
    def __test(self,age):
        self.age =10
        return self.age

    #获取
    def print_score(self):
        print('%s: %s: %s' % (self.__name, self.__score,self__test(10)))

    # 修改
    def set_score(self, score):
        self.__score = score

    bart = Student('Bart Simpson', 59)
    bart.__name #会报错
    bart._Student__name #可以访问，但是不建议这么做

    __init__ : 构造函数，在生成对象时调用
    __del__ : 析构函数，释放对象时使用
    ```
### 封装
> 封装 离不开私有化，就是将类中的一些方法和属性，限制在某个作用域内，使之无法直接使用，争强安全性，和简化编码，使用者不需要关注具体细节。

### 继承
- python
  ```
    #基类
    class Animal(object):
        def run(self):
            print('Animal is running')

    #继承
    calss Dog(Animal):
        def run(self):
            print('Dog is runnint)

    class Cat(Animal):
        def run(self):
            print('Cat is running')
  ```
    [多继承详解(需要注意基类的引入顺序，C3算法是在拓扑排序的基础上)](/image/inherit.png)

    [引入顺序展示](./inherit-info.md)

    [拓扑图](/image/tuopu.png)

    [super和init关系](/image/super.png)


### 多态
> 多态, 不同的 子类对象调用 相同的 父类方法，产生 不同的 执行结果，可以增加代码的外部 调用灵活度
> 多态以 继承 和 重写 父类方法 为前提
> 但是python的多态没有那么严格，他是基于一种`鸭子类型`的做法，见下文（不需要强制继承，就可以实现多态）

- python
    ```
    我们定义一个class的时候，我们实际上就定义了一种数据类型。我们定义的数据类型和Python自带的数据类型，比如str、list、dict没什么两样：
    a = list() # a是list类型
    b = Animal() # b是Animal类型
    c = Dog() # c是Dog类

    isinstance(a, list)
    True
    isinstance(b, Animal)
    True
    isinstance(c, Dog)
    True

    ### c不仅仅是Dog，c还是Animal,
    isinstance(c, Animal)
    True

    ### 反过来就不行
    isinstance(b, Dog)
    False
    ```
    ```
    通过继承实现多态

    class A(object)：
        def eat():
            print('a eat')
        def sleep():
            print('a sleep')

    class B(A):
        def eat():
            print('b eat')

    class C(A):
        def eat():
            print('c eat')

    class D():
        def test(A):
            return A.eat()

    调用方式a
    B.eat() # 'b eat'
    C.eat() # 'c eat'

    调用方式b
    D.test(B) # 'b eat'
    D.test(C) # 'c eat'

    ```
    ```
    通过鸭子类型实现多态
    class A(object)：
        def eat():
            print('a eat')
        def sleep():
            print('a sleep')

    class B(A):
        def eat():
            print('b eat')

    class C(A):
        def eat():
            print('c eat')

    class E():# 没有继承A类，但是有eat方法
        def eat():
            print('E eat')

    class D():
        def test(A):
            return A.eat()

    调用方式b
    D.test(B) # 'b eat'
    D.test(C) # 'c eat'
    D.test(E) # 'E eat'
    ```
    ```
    调用那个方式a缺点就是如果新增一个eat吃法，就需要新增一个类比如C-1或者B-1类
    调用方式b的优点就是，这个D类我一旦定义好了就不需要在去改动，只要你test的参数类型对，就能正确执行，不管你是B，C 或者新增一个E，只要B，C，E都有eat方法就可以，这就是开原则，如果你修改了test方法，就报错，这就是闭原则
    对新增开放，对修改关闭
    ```
    ```
    继承可以把父类的所有功能都直接拿过来，这样就不必重零做起，子类只需要新增自己特有的方法，也可以把父类不适合的方法覆盖重写。
    动态语言的鸭子类型特点决定了继承不像静态语言那样是必须的。
    ```



### 鸭子类型（python和golang使用）
> 简单说就是 有一个A类，有a,b,c方法，有一个类B，有a,b,c方法
> 有一个类C的x方法他的参数是Y类型，并且调用了Y的a方法
> 在调用C的x方法时，你可以传参数为A，或者B，虽然他们是不同的类，但是都有a方法
> 那么x的参数就能接收A或者B 只要他们实现了a方法就行
> 不需要A和B有任何关系

```
只要有个动物他走起来像鸭子，叫起来像鸭子，那么就可以认为这个动物是一只鸭子
鸭子就是Y，走的方式是a，叫的方式是b
有个动物A，有走的方式a，叫的方式b，那么他基本上就是一只鸭子
```

### 对象
> 通过类定义的数据结构实例。对象包括两个数据成员（类变量和实例变量）和方法
> 定义：确定的内存空间+存储在这个内存空间中的值
> 对象可以被多出引用
> 每个对象都有两个东西，一个类型，一个引用
> 对象的垃圾回收，每个对象保持了一个引用计数器，计数器记录了当前指向该对象的引用数目，一旦一个计数器为0，这个对象的内存空间就会被自动回收

[python oop 讲解一](/image/python-oop-1.png)
[python oop 讲解二](/image/python-oop-2.png)