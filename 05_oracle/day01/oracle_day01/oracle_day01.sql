SELECT SYSDATE FROM dual

SELECT SYSDATE FROM dual

SQL语句
SQL:结构化查询语句，是用来操作数据库的语言
所有的数据库都支持表示准的SQL语句
SQL语句包含:
DDL,DML,TCL,DQL,DCL这几类语句

DDL语句
DDL语句是用于增删改数据库对象的
数据库对象:表，视图，索引，序列

创建表:
CREATE TABLE employee_xxx(
	id NUMBER(4),
	name VARCHAR2(20),
	gender CHAR(1),
	birth DATE,
  salary NUMBER(6,2),
  job VARCHAR2(30),
  deptno NUMBER(2)
)

查看表结构
DESC employee


删除表:
DROP TABLE employee


SQL语句是不区分大小写的，但是字符串的
值(直接量)是区分大小写的，字符串的直接量
是使用单引号括起来的。
数据库中所有数据类型的默认值都是NULL，
在创建表时，可以使用DEFAULT为字段单独
指定默认值。
CREATE TABLE employee(
	id NUMBER(4),
	name VARCHAR2(20),
	gender CHAR(1) DEFAULT 'M',
	birth DATE,
  salary NUMBER(6,2) DEFAULT 5000,
  job VARCHAR2(30) DEFAULT 'CLERK',
  deptno NUMBER(2)
);

DESC employee



非空约束
当一个字段被NOT NULL修饰后，该字段
在任何情况下值不能为NULL。
CREATE TABLE employee(
	id NUMBER(4),
	name VARCHAR2(20) NOT NULL,
	gender CHAR(1) DEFAULT 'M',
	birth DATE,
  salary NUMBER(6,2) DEFAULT 5000,
  job VARCHAR2(30) DEFAULT 'CLERK',
  deptno NUMBER(2)
);

非空约束可以在查看表结构中体现出来
DESC employee



修改表
1:修改表名
2:修改表结构

修改表名:
RENAME old_name TO new_name

将employee表改名为myemp
RENAME employee TO myemp

DESC myemp


修改表结构:
1:添加新字段
向表myemp中添加字段hiredate

ALTER TABLE myemp 
ADD(
  hiredate DATE
)
DESC myemp



删除表中现有字段
将myemp表中的hiredate字段删除
ALTER TABLE myemp
DROP(hiredate)


修改表中现有字段
修改字段可以修改字段的类型，长度，默认值
非空约束。
但是表中若已经存在数据，那么修改字段的时候
尽量不修改类型，若修改长度尽量不要缩小，否
则可能导致修改失败。

ALTER TABLE myemp
MODIFY(
  job VARCHAR2(40) DEFAULT 'CLERK'
)

DESC myemp

DML语句
DML语句用来对表中数据进行相关操作，包括:
增，删，改。

1:插入数据
INSERT INTO myemp
(id,name,salary,deptno)
VALUES
(1,'JACK',3000,10)

SELECT * FROM myemp

插入数据时，忽略字段名则是全列插入
INSERT INTO myemp
VALUES
(2,'ROSE','F',SYSDATE,5000,
 'MANAGER',20)


插入日期时，使用TO_DATE函数
INSERT INTO myemp
(id,name,birth)
VALUES
(3,'JACKSON',
 TO_DATE('1992-08-02','YYYY-MM-DD'))

SELECT * FROM myemp


2:修改数据
UPDATE语句用于修改表中数据，需要使用
WHERE添加条件以修改满足条件的记录，若
不添加WHERE则是全表所有数据修改!

将ROSE的工资改为6000,部门号改为30
UPDATE myemp
SET salary=6000,deptno=30
WHERE name='ROSE'


3:删除表中数据
DELETE语句用于删除表中记录，通常需要
使用WHERE添加条件来删除满足条件的记录
若不添加WHERE是清空表操作!
DELETE FROM myemp
WHERE name='ROSE'




























