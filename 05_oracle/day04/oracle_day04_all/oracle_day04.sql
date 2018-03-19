子查询
子查询是一条查询语句，它是嵌套在其他
SQL语句当中的，目的是为了外层查询提供
数据的。
查看谁的工资高于CLARK?
SELECT ename,sal
FROM emp
WHERE sal>(SELECT sal FROM emp
           WHERE ename='CLARK')


SELECT ename,job
FROM emp
WHERE job=(SELECT job FROM emp
           WHERE ename='SMITH')

查看谁的工资高于公司平均工资?
SELECT ename,sal
FROM emp
WHERE sal>(SELECT AVG(sal) FROM emp)

在DDL中使用子查询
可以根据一个查询结果集快速构建一张表
empno,ename,sal,job,deptno,dname,loc

CREATE TABLE employees
AS
SELECT 
 e.empno,e.ename,e.sal,e.job,
 d.deptno,d.dname,d.loc
FROM
 emp e,dept d
WHERE
 e.deptno=d.deptno(+)

SELECT * FROM employees


DML中使用子查询
将SMITH所在部门的员工工资上浮10%
UPDATE emp
SET sal=sal*1.1
WHERE deptno=(SELECT deptno FROM emp
              WHERE ename='SMITH')

SELECT * FROM emp

DELETE FROM emp
WHERE deptno=(SELECT deptno FROM emp
              WHERE ename='CLARK')

当子查询为多行单列时，那么在用作判断
条件中时要搭配IN,ANY,ALL使用
查看与职位是SALESMAN同部门的其他职位员工?

SELECT ename,sal,deptno,job
FROM emp
WHERE deptno IN(SELECT deptno 
                FROM emp
                WHERE job='SALESMAN')
AND job <> 'SALESMAN'                

查看比职位是SALESMAN和CLERK工资
都高的员工信息?
SELECT ename,sal
FROM emp
WHERE 
 sal>ALL(SELECT sal FROM emp
         WHERE 
          job IN('SALESMAN','CLERK')
        )


EXISTS关键字
EXISTS关键字后面跟一个子查询，当该
子查询可以查询出至少一条记录时，EXISTS
条件成立。

查看有员工的部门有哪些?
SELECT d.deptno,d.dname,d.loc
FROM dept d
WHERE EXISTS(
  SELECT * FROM emp e
  WHERE e.deptno=d.deptno
)

查看哪些人是别人的领导?
SELECT empno,ename,job,deptno
FROM emp m
WHERE EXISTS(
  SELECT * FROM emp e
  WHERE e.mgr=m.empno
)


查看部门的最低薪水，前提是该部门的最低
薪水要高于30号部门的最低薪水?
SELECT MIN(sal),deptno
FROM emp
GROUP BY deptno
HAVING 
 MIN(sal)>(SELECT MIN(sal) FROM emp
           WHERE deptno=30)


在FROM子句中使用子查询通常是将子查询的结果
当做一张表看待，基于该查询结果进行二次查询
使用。
查看谁的工资高于其所在部门的平均工资?
SELECT e.ename,e.sal,e.deptno
FROM emp e,
    (SELECT AVG(sal) avg_sal,
            deptno
     FROM emp
     GROUP BY deptno) t
WHERE e.deptno=t.deptno
AND e.sal>t.avg_sal

SELECT 
  e.ename, e.sal, 
  (SELECT d.dname FROM dept d 
   WHERE d.deptno = e.deptno) dname
FROM emp e


分页查询
分页查询就是将数据分段查询出来，一次
只查询数据的一部分。
这样做可以减少系统资源开销，减少数据
量可以提高网络传输速度。 

分页在不同的数据库中的SQL语句是不同的。

ORACLE中提供了一个伪列:ROWNUM
ROWNUM字段不存在于任何一张表中，但是每张
表都可以查询该字段。该字段的值是结果集中
每条记录的行号。
ROWNUM字段的值是动态生成的，伴随查询过程。
只要可以查询出一条记录，ROWNUM就会为该条
记录生成行号，从1开始每次递增1.

由于ROWNUM是在查询表的过程中进行编号
的，所以在使用ROWNUM对结果集编行号的
查询过程中不要使用ROWNUM做大于1以上数
字的判断，否则结果集没有任何数据。
SELECT *
FROM (SELECT 
       ROWNUM rn,empno,ename,
       sal,deptno
      FROM emp)
WHERE rn BETWEEN 6 AND 10

查看公司工资排名的第6-10名
SELECT *
FROM(SELECT ROWNUM rn,t.*
     FROM(SELECT empno,ename,
                 sal,deptno
          FROM emp
          ORDER BY sal DESC) t)
WHERE rn BETWEEN 6 AND 10


SELECT *
FROM(SELECT ROWNUM rn,t.*
     FROM(SELECT empno,ename,
                 sal,deptno
          FROM emp
          ORDER BY sal DESC) t
     WHERE ROWNUM <=10)
WHERE rn >=6

pageSize(每页显示的条目数)
page(页数)

start:(page-1)*pageSize+1
end:pageSize*page





DECODE函数，可以实现分支效果。
SELECT 
  ename, job, sal,
  DECODE(job,  
         'MANAGER', sal * 1.2,
         'ANALYST', sal * 1.1,
         'SALESMAN', sal * 1.05,
         sal) bonus
FROM emp;

将MANAGER与ANALYST看做一组，其他职位
看做另一组，分别统计两组人数?
SELECT 
  COUNT(*),
  DECODE(job,
         'MANAGER','VIP',
         'ANALYST','VIP',
         'OTHER')
FROM emp
GROUP BY DECODE(job,
         'MANAGER','VIP',
         'ANALYST','VIP',
         'OTHER')


排序函数
排序函数允许将结果集按照指定字段分组
在组内按照指定字段排序，然后该函数为
每组生成一个行号。

ROW_NUMBER():生成组内连续且唯一的数字

查看每个部门的工资排名?
SELECT 
  ename,deptno,sal,
  ROW_NUMBER() OVER(
    PARTITION BY deptno
    ORDER BY sal DESC
  ) rank
FROM emp


RANK函数
生成组内不连续也不唯一的数字
SELECT 
  ename,deptno,sal,
  RANK() OVER(
    PARTITION BY deptno
    ORDER BY sal DESC
  ) rank
FROM emp



DENSE_RANK函数
生成组内连续但不唯一的数字
SELECT 
  ename,deptno,sal,
  DENSE_RANK() OVER(
    PARTITION BY deptno
    ORDER BY sal DESC
  ) rank
FROM emp


SELECT year_id,month_id,day_id,sales_value
FROM sales_tab
ORDER BY year_id,month_id,day_id

查看每天的营业额?
SELECT year_id,month_id,
       day_id,SUM(sales_value)
FROM sales_tab
GROUP BY year_id,month_id,day_id
ORDER BY year_id,month_id,day_id

每月的营业额？
SELECT year_id,month_id,
       SUM(sales_value)
FROM sales_tab
GROUP BY year_id,month_id
ORDER BY year_id,month_id

每年的营业额?
SELECT year_id,SUM(sales_value)
FROM sales_tab
GROUP BY year_id
ORDER BY year_id

总共的营业额?
SELECT SUM(sales_value)
FROM sales_tab


SELECT year_id,month_id,
       day_id,SUM(sales_value)
FROM sales_tab
GROUP BY year_id,month_id,day_id
UNION ALL
SELECT year_id,month_id,
       NULL,SUM(sales_value)
FROM sales_tab
GROUP BY year_id,month_id
UNION ALL
SELECT year_id,NULL,
       NULL,SUM(sales_value)
FROM sales_tab
GROUP BY year_id
UNION ALL
SELECT NULL,NULL,
       NULL,SUM(sales_value)
FROM sales_tab


高级分组函数
1:ROLLUP(a[,b,c...])
GROUP BY ROLLUP(a,b,c)
等同于
GROUP BY a,b,c
UNION ALL
GROUP BY a,b
UNION ALL
GROUP BY a
UNION ALL
全表

查看每天，每月，每年以及所有营业额?
SELECT year_id,month_id,
       day_id,SUM(sales_value)
FROM sales_tab
GROUP BY
 ROLLUP(year_id,month_id,day_id)


2:CUBE()
CUBU的分组策略为每个参数的组合
进行一次分组
GROUP BY CUBE(a,b,c)
等同于
a,b,c
a,b
b,c
a,c
a
b
c
全表

SELECT year_id,month_id,
       day_id,SUM(sales_value)
FROM sales_tab
GROUP BY
 CUBE(year_id,month_id,day_id)
ORDER BY year_id,month_id,day_id



GROUPING SETS()
该函数允许自行指定分组策略，然后将这些
分组统计的结果并在一起。函数的每个参数
为一种分组方式。
查看每天与每月的营业额?
SELECT year_id,month_id,
       day_id,SUM(sales_value)
FROM sales_tab
GROUP BY
 GROUPING SETS(
   (year_id,month_id,day_id),
   (year_id,month_id)
 )
ORDER BY year_id,month_id,day_id





