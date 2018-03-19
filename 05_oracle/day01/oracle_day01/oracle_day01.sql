SELECT SYSDATE FROM dual

SELECT SYSDATE FROM dual

SQL���
SQL:�ṹ����ѯ��䣬�������������ݿ������
���е����ݿⶼ֧�ֱ�ʾ׼��SQL���
SQL������:
DDL,DML,TCL,DQL,DCL�⼸�����

DDL���
DDL�����������ɾ�����ݿ�����
���ݿ����:����ͼ������������

������:
CREATE TABLE employee_xxx(
	id NUMBER(4),
	name VARCHAR2(20),
	gender CHAR(1),
	birth DATE,
  salary NUMBER(6,2),
  job VARCHAR2(30),
  deptno NUMBER(2)
)

�鿴��ṹ
DESC employee


ɾ����:
DROP TABLE employee


SQL����ǲ����ִ�Сд�ģ������ַ�����
ֵ(ֱ����)�����ִ�Сд�ģ��ַ�����ֱ����
��ʹ�õ������������ġ�
���ݿ��������������͵�Ĭ��ֵ����NULL��
�ڴ�����ʱ������ʹ��DEFAULTΪ�ֶε���
ָ��Ĭ��ֵ��
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



�ǿ�Լ��
��һ���ֶα�NOT NULL���κ󣬸��ֶ�
���κ������ֵ����ΪNULL��
CREATE TABLE employee(
	id NUMBER(4),
	name VARCHAR2(20) NOT NULL,
	gender CHAR(1) DEFAULT 'M',
	birth DATE,
  salary NUMBER(6,2) DEFAULT 5000,
  job VARCHAR2(30) DEFAULT 'CLERK',
  deptno NUMBER(2)
);

�ǿ�Լ�������ڲ鿴��ṹ�����ֳ���
DESC employee



�޸ı�
1:�޸ı���
2:�޸ı�ṹ

�޸ı���:
RENAME old_name TO new_name

��employee�����Ϊmyemp
RENAME employee TO myemp

DESC myemp


�޸ı�ṹ:
1:������ֶ�
���myemp������ֶ�hiredate

ALTER TABLE myemp 
ADD(
  hiredate DATE
)
DESC myemp



ɾ�����������ֶ�
��myemp���е�hiredate�ֶ�ɾ��
ALTER TABLE myemp
DROP(hiredate)


�޸ı��������ֶ�
�޸��ֶο����޸��ֶε����ͣ����ȣ�Ĭ��ֵ
�ǿ�Լ����
���Ǳ������Ѿ��������ݣ���ô�޸��ֶε�ʱ��
�������޸����ͣ����޸ĳ��Ⱦ�����Ҫ��С����
����ܵ����޸�ʧ�ܡ�

ALTER TABLE myemp
MODIFY(
  job VARCHAR2(40) DEFAULT 'CLERK'
)

DESC myemp

DML���
DML��������Ա������ݽ�����ز���������:
����ɾ���ġ�

1:��������
INSERT INTO myemp
(id,name,salary,deptno)
VALUES
(1,'JACK',3000,10)

SELECT * FROM myemp

��������ʱ�������ֶ�������ȫ�в���
INSERT INTO myemp
VALUES
(2,'ROSE','F',SYSDATE,5000,
 'MANAGER',20)


��������ʱ��ʹ��TO_DATE����
INSERT INTO myemp
(id,name,birth)
VALUES
(3,'JACKSON',
 TO_DATE('1992-08-02','YYYY-MM-DD'))

SELECT * FROM myemp


2:�޸�����
UPDATE��������޸ı������ݣ���Ҫʹ��
WHERE����������޸����������ļ�¼����
�����WHERE����ȫ�����������޸�!

��ROSE�Ĺ��ʸ�Ϊ6000,���źŸ�Ϊ30
UPDATE myemp
SET salary=6000,deptno=30
WHERE name='ROSE'


3:ɾ����������
DELETE�������ɾ�����м�¼��ͨ����Ҫ
ʹ��WHERE���������ɾ�����������ļ�¼
�������WHERE����ձ����!
DELETE FROM myemp
WHERE name='ROSE'




























