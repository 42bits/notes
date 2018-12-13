### 类(class)、实例(instance)

类是抽象的模板，实例是根据类创建出来的一个具体的对象，每个对象拥有相同的方法，但各自的数据可能不同

类名通常一大写字母开头

- python

  类对象支持两种操作：属性引用和实例化

  self代表类的实例，而非类

  不要对实例属性和类属性使用相同的名字，否则将产生难以发现的错误

  由于实例属性优先级比类属性高，因此，它会屏蔽掉类中名称相同的属性

```
class Student（object):
    '''
    构造函数，该方法在实例化时会自动调用
    '''
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
 stu = Student(congxi)
 print(stu.name)
 stu.get_info()
 定义实例变量
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
> 当子类和父类都存在相同的run()方法时，我们说，子类的run()覆盖了父类的run()，在代码运行的时候，总是会调用子类的run()。这样，我们就获得了继承的另一个好处：多态。
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
- python


### 鸭子类型


### 对象
> 通过类定义的数据结构实例。对象包括两个数据成员（类变量和实例变量）和方法
> 定义：确定的内存空间+存储在这个内存空间中的值
> 对象可以被多出引用
> 每个对象都有两个东西，一个类型，一个引用
> 对象的垃圾回收，每个对象保持了一个引用计数器，计数器记录了当前指向该对象的引用数目，一旦一个计数器为0，这个对象的内存空间就会被自动回收
