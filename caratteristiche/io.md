### 命令行参数
- python
    ```
    import sys
    if __name__ == '__main__':
        for arg in sys.argv:
            print(arg)
    python io.py 1 3 5 6 7 # 1 3 5 6 7
    ```

    ```
    import sys
    import getopt

    def usage():
        str = '''
        python sys.srgv[0] [options] [value]...

        [options]
        --help
        -h, --host [string]
        -P, --port [int]
        -u, --user [string]
        -p, --passwd [string]
        ```
        print(str)

    def main():
        shortargs = "ho:v"
        longargs = ["help","file="]

        try:
            opts,args = getopt.getopt(sys.argv[1:],shortargs,longargs)
        except getopt.GetoptError as e:
            print(str(e))
            sys.exit(2)

        for o,a in opts:
            print(o,a)

        for i in args:
            print(i)
    if __name__ =="__main__":
        if len(sys.argv)  == 1
            usage()
            sys.exit(1)
        else:
            main()

    python test.py -h -o file -v --help --file=out file1 file2
    解析：
    opts：
    [('-h', ''),('-o', 'file'),('-v', ''),('--help', ''), ('--file', 'out')]
    args：
    ['files',file2]

    说明：
    短标签带`o:` 说明 o 后面必须要带一个值，长标签`--file=` 必须要带一个值
    args 返回的为不符合格式信息的剩余的命令行参数，

    ```
### 文件读写

### 文件&目录操作

### 序列化
