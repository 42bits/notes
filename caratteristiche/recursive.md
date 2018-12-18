### 递归
> 函数在内部调用自身
> 必须有一个明确的结束条件
> 处理的问题规模必须越来越小的

```
理解递归

在初学递归的时候, 看到一个递归实现, 我们总是难免陷入不停的回溯验证之中, 因为回溯就像反过来思考迭代, 这是我们习惯的思维方式, 但是实际上递归不需要这样来验证

比如, 另外一个常见的例子是阶乘的计算

我们怎么判断这个阶乘的递归计算是否是正确的呢? 先别说测试, 我说我们读代码的时候怎么判断呢?

回溯的思考方式是这么验证的, 比如当n = 4时, 那么factoria(4)等于4 * factoria(3), 而factoria(3)等于3 * factoria(2), factoria(2)等于2 * factoria(1), 等于2 * 1, 所以factoria(4)等于4 * 3 * 2 * 1. 这个结果正好等于阶乘4的迭代定义.

用回溯的方式思考虽然可以验证当n = 某个较小数值是否正确, 但是其实无益于理解.


Paul Graham提到一种验证方法,:

当n=0, 1的时候, 结果正确.

假设函数对于n是正确的, 函数对n+1结果也正确.

如果这两点是成立的，我们知道这个函数对于所有可能的n都是正确的

```

我们来计算阶乘n! = 1 x 2 x 3 x ... x n，用函数fact(n)表示，可以看出

fact(n) = n! = 1 x 2 x 3 x ... x (n-1) x n = (n-1)! x n = fact(n-1) x n

所以，fact(n)可以表示为n x fact(n-1)，只有n=1时需要特殊处理。

于是，fact(n)用递归的方式写出来就是：

```
如果我们计算fact(5)，可以根据函数定义看到计算过程如下：

===> fact(5)
===> 5 * fact(4)
===> 5 * (4 * fact(3))
===> 5 * (4 * (3 * fact(2)))
===> 5 * (4 * (3 * (2 * fact(1))))
===> 5 * (4 * (3 * (2 * 1)))
===> 5 * (4 * (3 * 2))
===> 5 * (4 * 6)
===> 5 * 24
===> 120
```
使用递归函数需要注意防止栈溢出。在计算机中，函数调用是通过栈（stack）这种数据结构实现的，每当进入一个函数调用，栈就会加一层栈帧，每当函数返回，栈就会减一层栈帧。由于栈的大小不是无限的，所以，递归调用的次数过多，会导致栈溢出。

解决递归调用栈溢出的方法是通过尾递归优化，事实上尾递归和循环的效果是一样的，所以，把循环看成是一种特殊的尾递归函数也是可以的。

尾递归是指，在函数返回的时候，调用自身本身，并且，return语句不能包含表达式。这样，编译器或者解释器就可以把尾递归做优化，使递归本身无论调用多少次，都只占用一个栈帧，不会出现栈溢出的情况。

```
fact_iter(5, 1)的调用如下：

===> fact_iter(5, 1)
===> fact_iter(4, 5)
===> fact_iter(3, 20)
===> fact_iter(2, 60)
===> fact_iter(1, 120)
===> 120
```

- python
```
    def fact(n):
        if n == 1:
            return n
        return n* fact(n-1)

    # 尾递归
    def fact_iter(n,product=1):
        if n == 1:
            return product
        return fact_iter(n-1,n*product)
```