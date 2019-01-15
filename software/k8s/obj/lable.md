

### labels和selectors
```
规范:
以[a-z0-9A-Z]带有虚线（-）、下划线（_）、点（.）和开头和结尾必须是字母或数字（都是字符串形式）的形式组成

标签:
一对key/value 关联到对象上,标签的使用倾向于能够标识对象的特点
可以附加在任何对象上,pod,service,node,rc
对用于有意义,对系统是没有意义的,
标签不需要唯一,一般使用方法时很多对象有相同的标签
主要用来实现资源的精细和多维度的分组管理


标签选择器:
通过选择器,可以方便的标识出有相同标签的多组对象

选择器种类;
1:平等(equality-based)
2:集合(set-based)

平等写法1:
    env=pro
    sources!=ns
平等写法2:逗号相当与and
    env=pro,sources!=ns

集合写法1:
    env in(pro,test)
    sources notin (ns,backend)
集合写法2:(key=env但是value 等于pro或者test,key=sources但是value不等于ns和backend)
    env in (pro,test),sources notin (ns,backend)


支持写法:

url请求模式(需要urlencode)和kubectl操作模式支持这两种写法
?labelSelector=env=pro,sources!=ns
?labelSelector=env in (pro,test),sources notin (ns.backend)

kubectl get pods -l env=pro,sources!=ns
kubectl get pods -l 'env in (pro,test),sources notin (ns,backend)'

对象使用
services和 replicationControllers 也使用selector来指定标签,但是只支持平等写法
selector:
    env:pro
    sources:pod

job,deployment,replica set 支持 集合写法(可以使用matchLables,或者matchExpressions)

selector:
    matchLables:
        env:pro
    matchExpressions:
        - {key:env,operator:In,values:[pro,test]}
        - {key:sources,operator:NotIn,values:[ns,backend]}

```
### annotations
```
可以将非metadata的参数附加到对象,目地就是为了方便用户阅读和查找
annotations:
    time:2019-01-11
    hash:1234qwer
    user:congxi
    phone:12344567

labels和annotations区别:
labels 可以用于选择对象,并查找满足某些条件的对象
annotations不能用于标识和选择对象

```