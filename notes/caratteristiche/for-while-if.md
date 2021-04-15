### if
- python
    ```
    age = 6
    if age > 7:
        print('you age is ',age)
    else if age > 5:
        print('you age is ',age)
    else:
        print('you age is ',age)

    # 非0,非空str，非空list等，返回true
    if age:
        print('you age is ',age)

    # input 读取用户输入，默认类型是str，str 不能直接和int类型比较，需要转换
    s = input('age: ')
    age = int(s)
    if age > 20:
        print('you age is ',age)

    ```

### for
- python
    ```
    for...in 依次将tuple或list 的每个元素迭代出来
    for x in range(10):
        print(x)
    ```
### while
- python
    ```
    只要条件满足，就不断循环，条件不满足时退出循环
    n = 100
    while n > 2:
        if n == 60:
            continue
        if n == 50:
            break
        n -= 2
    print(n)
    ```