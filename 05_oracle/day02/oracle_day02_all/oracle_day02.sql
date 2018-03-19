DQL语句
DQL语句用于查询数据库中的数据

DQL必须包含两个子句:
SELECT,FROM
SELECT子句用来指定要查询的字段，可以
是表中的字段，函数和表达式
FROM子句用来指定数据来源的表

查看emp表中的数据
SELECT * FROM emp

查看ename,job,sal,deptno
SELECT ename,job,sal,deptno
FROM emp

查看20号部门的员工信息?
DQL中也可以使用WHERE子句来添加过滤
条件，这样只会将满足条件的记录查询出来
SELECT ename,job,sal,deptno
FROM emp
WHERE deptno=20


SELECT子句中也可已使用函数或表达式
查看公司每个员工的年薪是多少?
SELECT ename,sal,sal*12
FROM emp


字符串函数
1:CONCAT(char1,char2)
将两个参数字符串连接在一起返回
SELECT CONCAT(ename,sal)
FROM emp

SELECT CONCAT(CONCAT(ename,','),sal)
FROM emp

"||"可以连接字符串
SELECT ename||','||sal
FROM emp


2:LENGTH(char)
返回指定字符串的长度
SELECT ename,LENGTH(ename)
FROM emp


伪表:dual
伪表不是一张真是存在的表，当查询的内容
与任何表数据无关时，可以使用伪表。
SELECT SYSDATE FROM dual

3:UPPER,LOWER,INITCAP
将字符串转换为大写，小写，首字母大写
SELECT
 UPPER('helloworld'),
 LOWER('HELLOWORLD'),
 INITCAP('HELLO WORLD')
FROM dual

查看scott的信息?
SELECT ename,sal,job,deptno
FROM emp
WHERE ename=UPPER('scott')

4:TRIM,LTRIM,RTRIM
去除字符串两端的指定字符
SELECT TRIM('e' FROM 'eeeliteee')
FROM dual

SELECT LTRIM('eddsdsesliteee','esd')
FROM dual

SELECT RTRIM('eeeliteddsdses','esd')
FROM dual

5:LPAD,RPAD补位函数
将指定字符串显示指定长度，当不足
时补充若干个指定字符以达到该长度
SELECT ename,RPAD(sal,5,'$')
FROM emp


6:SUBSTR(char,m[,n])
截取指定字符串，从m处开始连续截取n个字符
n若不指定或超过实际可截取的长度，则都
是截取到字符串末尾
m若为负数，则是从倒数位置开始截取
数据库中下标都从1开始
SELECT 
 SUBSTR('thinking in java',-7,2)
FROM 
 dual


7:INSTR(char1,char2[,m[,n]])
查看char2在char1中的位置
m为从哪里开始查找，不写默认为1
n为第几次出现，不写默认为1
SELECT 
 INSTR('thinking in java','in',4,2)
FROM 
 dual


数字函数
1:ROUND(n,m)
四舍五入保留n小数点后m位
若m不写或0则表示保留到个位
若是负数则是保留到十位以上的数字

SELECT ROUND(45.678, 2) FROM DUAL
SELECT ROUND(45.678, 0) FROM DUAL
SELECT ROUND(55.678, -2) FROM DUAL


2:TRUNC函数
与ROUND参数意义一致，作用是截取数字。
SELECT TRUNC(45.678, 2) FROM DUAL
SELECT TRUNC(45.678, 0) FROM DUAL
SELECT TRUNC(55.678, -1) FROM DUAL


3:MOD(m,n)函数
求余数。n为0则直接返回m
SELECT ename,sal,MOD(sal,1000)
FROM emp


4:CEIL,FLOOR
向上取整与向下取整
SELECT CEIL(45.678) FROM DUAL; --46?
SELECT FLOOR(45.678) FROM DUAL;--45



日期类型
两个常用关键字
SYSDATE:对应数据库一个内置函数，返回
一个DATE类型数据，表示当前系统时间

SYSTIMESTAMP:返回一个时间戳类型
的当前系统时间。

SELECT SYSDATE FROM dual

INSERT INTO emp
(empno,ename,hiredate)
VALUES
(1,'jack',SYSDATE)


SELECT SYSTIMESTAMP FROM dual


日期转换函数
1:TO_DATE()
可以将给定字符串按照指定的日期格式
转换为DATE类型值。
SELECT
 TO_DATE('1992-08-03 15:22:33',
         'YYYY-MM-DD HH24:MI:SS')
FROM 
 dual

在日期格式字符串中凡不是英文，符号的其他
字符都需要使用双引号括起来
SELECT
 TO_DATE('1992年08月03日 15时22分33秒',
         'YYYY"年"MM"月"DD"日" HH24"时"MI"分"SS"秒"')
FROM 
 dual


TO_CHAR函数
可以将DATE按照给定的日期格式转换为字符串
SELECT
 TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS')
FROM
 dual

SELECT
 TO_CHAR(TO_DATE('58-08-03','RR-MM-DD'),
         'YYYY-MM-DD')
FROM 
 dual

日期类型是可以计算的
对一个日期加减一个数字等同于加减天数
两个日期做减法，差为相差的天数。


查看明天的日期?
SELECT SYSDATE+1 FROM dual

查看每个员工入职至今多少天了?
SELECT ename,SYSDATE-hiredate
FROM emp

日期函数:
1:LAST_DAY(date)
返回给定日期所在月的月底日期

查看当月月底?
SELECT LAST_DAY(SYSDATE)
FROM dual


2:ADD_MONTHS(date,i)
对指定日期加上指定月
若i为负数，则是减去指定的月数

查看每个员工的转正日期?
SELECT ename,ADD_MONTHS(hiredate,3)
FROM emp


3:MONTHS_BETWEEN(date1,date2)
计算两个指定日期之间相差的月
查看每个员工入职至今多少个月?
SELECT 
 ename,MONTHS_BETWEEN(SYSDATE,hiredate)
FROM emp

4:NEXT_DAY(date,i)
返回给定日期第二天开始一周内指定
周几的日期
i可以是1-7，分别表示周日，周一..周六

SELECT NEXT_DAY(SYSDATE,5)
FROM dual

5:LEAST,GREATEST
求最小值与最大值
对于日期而言，最大值为最晚的日期
最小值为最早的日期
SELECT 
 LEAST(SYSDATE,
       TO_DATE('1998-08-06',
               'YYYY-MM-DD')
 ) 
FROM 
 DUAL;

6:EXTRACT函数
获取一个日期中指定时间分量的值
查看今年是哪年？
SELECT EXTRACT(YEAR FROM SYSDATE)
FROM dual

查看1980年入职的员工?
SELECT ename,hiredate
FROM emp
WHERE EXTRACT(YEAR FROM hiredate)=1980



空值操作
CREATE TABLE student
    (id NUMBER(4), name CHAR(20), gender CHAR(1) NOT NULL);

INSERT INTO student VALUES(1000, '李莫愁', 'F');

INSERT INTO student VALUES(1001, '林平之', NULL);

INSERT INTO student(id, name) VALUES(1002, '张无忌');

更新NULL
UPDATE student
SET gender=null
WHERE id=1000

SELECT * FROM student

判断是否为NULL
判断要用IS NULL或IS NOT NULL
DELETE FROM student
WHERE gender IS NULL

NULL的运算
NULL与字符串连接等于什么都没做
NULL与数字运算结果还是NULL

SELECT ename||NULL
FROM emp

查看每个员工的收入(工资+绩效)
SELECT ename,sal,comm,sal+comm
FROM emp

空值函数
1:NVL(arg1,arg2)
当arg1为NULL时，函数返回arg2的值
否则返回arg1自身
该函数意义:将NULL值替换为非NULL值

查看每个员工的收入(工资+绩效)
SELECT 
 ename,sal,comm,
 sal+NVL(comm,0)
FROM emp


2:NVL2(arg1,arg2,arg3)
当arg1不为NULL时，函数返回arg2
若为NULL，则函数返回arg3

查看每个员工是否有绩效，即：
有绩效的显示"有绩效"，为NULL的则
显示为"没有绩效"
SELECT 
 ename,comm,
 NVL2(comm,'有绩效','没有绩效')
FROM
 emp








