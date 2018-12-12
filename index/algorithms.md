一只青蛙一次可以跳上1级台阶，也可以跳上2级。求该青蛙跳上一个n级的台阶总共有多少种跳法

> 默认大于等于1
> 1个台阶 一种
> 2个台阶 两种
> 3个台阶 1-1-1；1-2；2-1 三种
> 4个台阶 1-1-1-1；1-2-1；1-1-2；2-2；2-1-1 五种

> n = f（n）+f(n-1)
``` golang
func t (n int) int {
    if n <= 2 {
        return n
    }
    return f(n-1)+f(n-2)

}
```

一只青蛙一次可以跳上1级台阶，也可以跳上2级……它也可以跳上n级。求该青蛙跳上一个n级的台阶总共有多少种跳法

> 台阶默认大于等于1
> 1个台阶 1种
> 2个台阶 2种
> 3个台阶 1-1-1；1-2；2-1；3；四种
> 4个台阶 1-1-1-1；1-2-1；1-1-2；2-1-1；2-2；3-1；4；六种

> n= 2 * f(n-1)

``` golang
func t (n int) int {
    if n<=1 {
        return n
    }
    return 2*f(n-1)
}

```

汉诺塔（有3个圆盘）
```golang
func hanoi(n int,a,b,c string) string {
    if n == 1 {
        fmt.Println(a,"->",c)
    }
    hanoi(n-1,a,c,b)
    fmt.Println(a,"->",c)
    hanoi(n-1,b,a,c)
}

hanoi(3,a,b,c)
```
```python
def hanoi(n,a="a",b="b",c="c"):
    if n <= 1:
        print(a,"->",c)
    else:
        hanoi((n-1),a,c,b)
        print(a,"->",c)
        hanoi((n-1),b,a,c)

hanoi(3)
```
