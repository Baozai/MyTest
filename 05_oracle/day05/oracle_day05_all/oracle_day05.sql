视图
视图也是数据库对象之一
在SQL语句中体现的角色与表一致，但
视图只是对应一个查询语句的结果集。
创建视图:
CREATE VIEW v_emp_10
AS
SELECT empno, ename, sal, deptno 
FROM emp 
WHERE deptno = 10;

视图也可以查看结构
DESC v_emp_10

SELECT * FROM v_emp_10


视图根据对应的SQL语句不通，分为:
简单视图，复杂视图，连接视图
连接视图算作复杂视图的一种。

当对应的子查询不含有函数，表达式，分组，
去重，关联查询的视图称为简单视图，相反
就是复杂视图。连接视图指子查询使用了关联
查询。

视图对应的子查询的查询字段可以使用别名，
那么该字段的名字就是这个别名。若字段含有
函数或表达式，那么该字段必须指定别名。

CREATE OR REPLACE VIEW v_emp_10
AS
SELECT empno id,ename name,
       sal*12 sal,deptno
FROM emp
WHERE deptno=10

DESC v_emp_10
SELECT * FROM v_emp_10


对视图进行DML操作
对视图进行DML就是对视图数据来源的基础表
进行的操作。
只能对简单视图进行DML操作。复杂视图不可以

INSERT INTO v_emp_10
(empno,ename,sal,deptno)
VALUES
(1001,'JACK',2000,10)

SELECT * FROM v_emp_10
SELECT * FROM emp

UPDATE v_emp_10
SET sal=3000
WHERE empno=1001

DELETE FROM v_emp_10
WHERE empno=1001


对视图进行DML操作不当会污染基础表数据。
INSERT INTO v_emp_10
(empno,ename,sal,deptno)
VALUES
(1002,'JACKSON',2000,10)

SELECT * FROM emp
SELECT * FROM v_emp_10

UPDATE v_emp_10
SET deptno=20

可以为视图添加检查选项，来保证对视图
进行DML操作时不会对基表数据污染。
WITH CHECK OPTION
当视图添加了检查选项后，视图要求对视图
中数据进行DML操作后，视图必须对该记录
可见，否则不允许操作。
CREATE OR REPLACE VIEW v_emp_10
AS
SELECT empno,ename,sal,deptno
FROM emp
WHERE deptno=10
WITH CHECK OPTION


为视图添加只读选项
当一个视图添加了只读选项后，该视图不能
进行DML操作。
WITH READ ONLY

CREATE OR REPLACE VIEW v_emp_10
AS
SELECT empno,ename,sal,deptno
FROM emp
WHERE deptno=10
WITH READ ONLY

查看数据字典，有助于了解曾经创建过
的数据库对象
SELECT * FROM user_objects
WHERE object_name LIKE '%_FANCQ'

SELECT * FROM user_views

SELECT * FROM user_tables


复杂视图
复杂视图不能进行DML操作。

创建一个部门工资信息的视图:
CREATE VIEW v_dept_sal
AS
SELECT MIN(e.sal) min_sal,
       MAX(e.sal) max_sal,
       AVG(e.sal) avg_sal,
       SUM(e.sal) sum_Sal,
       d.deptno,d.dname
FROM emp e,dept d
WHERE e.deptno=d.deptno
GROUP BY d.deptno,d.dname

SELECT * FROM v_dept_sal

查看谁的工资高于自己所在部门平均工资?
SELECT e.ename,e.sal,e.deptno
FROM emp e,v_dept_sal v
WHERE e.deptno=v.deptno
AND e.sal>v.avg_sal

删除视图
DROP VIEW v_emp_10
删除视图不会影响基表数据。


序列
序列也是数据库对象之一
作用是根据指定的规则生成一系列数字
一般用于为表的每一条记录的主键字段提供值

创建序列
CREATE SEQUENCE seq_emp_id
START WITH 1
INCREMENT BY 1


序列支持两个伪列:
NEXTVAL:获取序列下一个数字，序列会根据
序列最后生成的数字加上步进来得到。NEXTVAL
会导致序列发生步进，序列是不能回退的。
CURRVAL:获取序列最后一次生成的数字。需要
注意的是，新创建的序列必须在使用NEXTVAL生成
一个数字后才可以使用CURRVAL。
SELECT seq_emp_id.NEXTVAL
FROM dual
SELECT seq_emp_id.CURRVAL
FROM dual

SELECT * FROM emp

INSERT INTO emp
(empno,ename,sal,job,deptno)
VALUES
(seq_emp_id.NEXTVAL,'ROSE',
 5000,'CLERK',10)

删除序列
DROP SEQUENCE seq_emp_id


索引
索引是数据库对象之一
索引是加快查询效率的机制
索引的建立以及应用是数据库自行完成的。


约束

唯一性约束
唯一性约束要求该字段每条记录的值不能
重复，NULL除外。

CREATE TABLE employees1 (
  eid NUMBER(6) UNIQUE,
  name VARCHAR2(30),
  email VARCHAR2(50),
  salary NUMBER(7, 2),
  hiredate DATE,
  CONSTRAINT employees1_email_uk UNIQUE(email)
);

SELECT * FROM employees1

INSERT INTO employees1
(eid,name,email)
VALUES
(NULL,'JACK',NULL)


主键约束
主键约束要求该字段的值为空且唯一
主键约束只能在一张表的一个字段上建立。
主键:使用该字段的值可以唯一定位表中的
一条记录。
CREATE TABLE employees2 (
  eid NUMBER(6) PRIMARY KEY,
  name VARCHAR2(30),
  email VARCHAR2(50),
  salary NUMBER(7, 2),
  hiredate DATE
);

INSERT INTO employees2
(eid,name)
VALUES
(NULL,'JACK')
















































