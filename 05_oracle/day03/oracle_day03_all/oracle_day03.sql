列别名
当一个SELECT子句中包含函数或者表达式
时，查询的结果集对应的该字段就是使用
这个函数或者表达式作为字段名，可读性
差。为此可以为这样的字段添加别名。
若别名使用双引号，那么别名就可以区分
大小写并且包含空格。
SELECT ename,sal*12 sal
FROM emp

AND的优先级高于OR
SELECT ename,job,sal
FROM emp
WHERE sal>1000
AND (job='SALESMAN'
OR job='CLERK')

LIKE关键字
LIKE用于模糊匹配字符串，它支持
两个通配符比较:
_:表示单一的一个字符
%:表示任意个字符(0-多个)

查看名字第二个字母是A的第四个字母是T的员工
SELECT ename
FROM emp
WHERE ename LIKE '_A_T%'


IN(list)与NOT IN(list)
判断在列表中或不在列表中
IN和NOT IN常用在子查询的判断中

查看职位是CLERK或SALESMAN的员工?
SELECT ename,job,deptno
FROM emp
WHERE job IN ('CLERK','SALESMAN')


BETWEEN...AND...
判断在一个范围内
查看工资在1500到3000之间的员工?
SELECT ename,job,sal
FROM emp
WHERE sal BETWEEN 1500 AND 3000

ANY(list)和ALL(list)
ANY与ALL是配合>,>=,<,<=使用的
>ANY(list):大于列表之一
>ALL(list):大于列表所有
<ANY(list):小于列表之一
<ALL(list):小于列表所有
常用在子查询中


DISTINCT关键字
去除重复行

查看公司有哪些职位?
SELECT DISTINCT job FROM emp

多字段去重，这几个字段值的组合没有重复行
SELECT DISTINCT job,deptno FROM emp


排序结果集
ORDER BY子句用来对结果集按照指定
的字段排序。
排序有两种方式:
升序(ASC):不写默认就是升序
降序(DESC):从大到小，需要单独指定
ORDER BY子句必须写在DQL的最后一个子句上

查看公司中工资的排名:
SELECT ename,sal,deptno
FROM emp
ORDER BY sal DESC

多字段排序，有优先级，首先按照第一个
字段排序，当第一个字段有重复值时才
按照第二个字段排序，依次类推。
SELECT ename,deptno,sal
FROM emp
ORDER BY deptno DESC,sal DESC

NULL被认作为最大值
SELECT ename,comm
FROM emp
ORDER BY comm DESC


聚合函数
聚合函数又称为:多行函数，分组函数.
作用是对结果集的指定字段进行统计然后
得出一个结果.

查看公司的最高工资与最低工资?
SELECT MAX(sal),MIN(sal)
FROM emp

查看公司的平均工资与工资总和?
SELECT AVG(sal),SUM(sal)
FROM emp

COUNT函数是对记录数的统计
查看公司共多少人?
SELECT COUNT(ename) FROM emp

聚合函数忽略NULL值
SELECT SUM(comm),AVG(comm) FROM emp

SELECT AVG(NVL(comm,0)) FROM emp

分组
GROUP BY 子句
GROUP BY可以将结果集按照给定字段
值一样的记录进行分组，配合聚合函数
可以对不同的分组分别统计结果。

SELECT AVG(sal),deptno
FROM emp
GROUP BY deptno

SELECT MAX(sal),job
FROM emp
GROUP BY job


多字段分组
这些字段值都一样的记录看做一组
同部门，同职位的员工的平均工资?
SELECT AVG(sal),deptno,job
FROM emp
GROUP BY deptno,job


查看每个部门的最低工资是多少?
前提是该部门的最低工资要高于1000
SELECT MIN(sal),deptno
FROM emp
WHERE MIN(sal)>1000
GROUP BY deptno

上面的SQL语句会报错:此处不允许使用分组函数

HAVING子句
HAVING子句必须跟在GROUP BY 子句之后，作
用是添加过滤条件来过滤GROUP BY的分组，它
可以将不满足条件的分组去除。HAVING子句
可以使用聚合函数作为过滤条件。
SELECT MIN(sal),deptno
FROM emp
GROUP BY deptno
HAVING MIN(sal)>1000

查看平均工资高于2000的部门的最低工资?
SELECT MIN(sal),deptno
FROM emp
GROUP BY deptno
HAVING AVG(sal)>2000


查看最低工资高于1000的那些职位的平均工资?
SELECT AVG(sal),job
FROM emp
GROUP BY job
HAVING MIN(sal)>1000


关联查询
查询数据是从多张表中关联查询一个结果集
关联查询的重点是添加连接条件。
连接条件的作用是告知数据库表与表之间的
数据是怎样对应的。
关联查询通常都要添加连接条件，否则会产
生笛卡尔积，通常是一个无意义的结果集。

查看每个员工的名字以及其所在部门的名字?
SELECT e.ename,e.deptno,d.dname
FROM emp e,dept d
WHERE e.deptno=d.deptno

当关联查询的表中有同名字段，需要通过表名
或表别名来指定该字段所属表。


在关联查询中过滤条件必须与连接条件
同时成立。
查看RESEARCH部门的员工信息?
SELECT e.ename,e.deptno,d.dname
FROM emp e,dept d
WHERE e.deptno=d.deptno
AND d.dname='RESEARCH'

不加链接条件会产生笛卡尔积
SELECT e.ename,d.dname
FROM emp e,dept d


内连接
内连接也是关联查询的一种
SELECT e.ename,d.dname
FROM emp e,dept d
WHERE e.deptno=d.deptno


SELECT e.ename,d.dname
FROM emp e JOIN dept d
ON e.deptno=d.deptno
WHERE d.dname='RESEARCH'

关联查询忽略不满足连接条件的记录

外链接
外链接在关联查询时还可以将不满足连接
条件的记录也查询出来。
外链接分为:
左外连接，右外连接，全外连接
左外连接:以JOIN左侧表作为驱动表
驱动表中所有数据都要列出来，那么当该表
某条记录不满足连接条件时，那么来自右侧
表的字段值全部为NULL。
SELECT e.ename,d.dname
FROM emp e 
  LEFT|RIGHT|FULL OUTER JOIN 
dept d
ON e.deptno=d.deptno

自连接
当当前表中的一条记录可以对应当前表的
其他记录时，这种设计称为自连接。

查看每个员工以及其上司的名字?
SELECT e.ename,m.ename
FROM emp e,emp m
WHERE e.mgr=m.empno

SELECT e.ename,m.ename
FROM emp e JOIN emp m
ON e.mgr=m.empno

查看SMITH的上司是谁?他在哪个城市工作?











































