��ͼ
��ͼҲ�����ݿ����֮һ
��SQL��������ֵĽ�ɫ���һ�£���
��ͼֻ�Ƕ�Ӧһ����ѯ���Ľ������
������ͼ:
CREATE VIEW v_emp_10
AS
SELECT empno, ename, sal, deptno 
FROM emp 
WHERE deptno = 10;

��ͼҲ���Բ鿴�ṹ
DESC v_emp_10

SELECT * FROM v_emp_10


��ͼ���ݶ�Ӧ��SQL��䲻ͨ����Ϊ:
����ͼ��������ͼ��������ͼ
������ͼ����������ͼ��һ�֡�

����Ӧ���Ӳ�ѯ�����к��������ʽ�����飬
ȥ�أ�������ѯ����ͼ��Ϊ����ͼ���෴
���Ǹ�����ͼ��������ͼָ�Ӳ�ѯʹ���˹���
��ѯ��

��ͼ��Ӧ���Ӳ�ѯ�Ĳ�ѯ�ֶο���ʹ�ñ�����
��ô���ֶε����־���������������ֶκ���
��������ʽ����ô���ֶα���ָ��������

CREATE OR REPLACE VIEW v_emp_10
AS
SELECT empno id,ename name,
       sal*12 sal,deptno
FROM emp
WHERE deptno=10

DESC v_emp_10
SELECT * FROM v_emp_10


����ͼ����DML����
����ͼ����DML���Ƕ���ͼ������Դ�Ļ�����
���еĲ�����
ֻ�ܶԼ���ͼ����DML������������ͼ������

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


����ͼ����DML������������Ⱦ���������ݡ�
INSERT INTO v_emp_10
(empno,ename,sal,deptno)
VALUES
(1002,'JACKSON',2000,10)

SELECT * FROM emp
SELECT * FROM v_emp_10

UPDATE v_emp_10
SET deptno=20

����Ϊ��ͼ��Ӽ��ѡ�����֤����ͼ
����DML����ʱ����Ի���������Ⱦ��
WITH CHECK OPTION
����ͼ����˼��ѡ�����ͼҪ�����ͼ
�����ݽ���DML��������ͼ����Ըü�¼
�ɼ����������������
CREATE OR REPLACE VIEW v_emp_10
AS
SELECT empno,ename,sal,deptno
FROM emp
WHERE deptno=10
WITH CHECK OPTION


Ϊ��ͼ���ֻ��ѡ��
��һ����ͼ�����ֻ��ѡ��󣬸���ͼ����
����DML������
WITH READ ONLY

CREATE OR REPLACE VIEW v_emp_10
AS
SELECT empno,ename,sal,deptno
FROM emp
WHERE deptno=10
WITH READ ONLY

�鿴�����ֵ䣬�������˽�����������
�����ݿ����
SELECT * FROM user_objects
WHERE object_name LIKE '%_FANCQ'

SELECT * FROM user_views

SELECT * FROM user_tables


������ͼ
������ͼ���ܽ���DML������

����һ�����Ź�����Ϣ����ͼ:
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

�鿴˭�Ĺ��ʸ����Լ����ڲ���ƽ������?
SELECT e.ename,e.sal,e.deptno
FROM emp e,v_dept_sal v
WHERE e.deptno=v.deptno
AND e.sal>v.avg_sal

ɾ����ͼ
DROP VIEW v_emp_10
ɾ����ͼ����Ӱ��������ݡ�


����
����Ҳ�����ݿ����֮һ
�����Ǹ���ָ���Ĺ�������һϵ������
һ������Ϊ���ÿһ����¼�������ֶ��ṩֵ

��������
CREATE SEQUENCE seq_emp_id
START WITH 1
INCREMENT BY 1


����֧������α��:
NEXTVAL:��ȡ������һ�����֣����л����
����������ɵ����ּ��ϲ������õ���NEXTVAL
�ᵼ�����з��������������ǲ��ܻ��˵ġ�
CURRVAL:��ȡ�������һ�����ɵ����֡���Ҫ
ע����ǣ��´��������б�����ʹ��NEXTVAL����
һ�����ֺ�ſ���ʹ��CURRVAL��
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

ɾ������
DROP SEQUENCE seq_emp_id


����
���������ݿ����֮һ
�����Ǽӿ��ѯЧ�ʵĻ���
�����Ľ����Լ�Ӧ�������ݿ�������ɵġ�


Լ��

Ψһ��Լ��
Ψһ��Լ��Ҫ����ֶ�ÿ����¼��ֵ����
�ظ���NULL���⡣

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


����Լ��
����Լ��Ҫ����ֶε�ֵΪ����Ψһ
����Լ��ֻ����һ�ű��һ���ֶ��Ͻ�����
����:ʹ�ø��ֶε�ֵ����Ψһ��λ���е�
һ����¼��
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
















































