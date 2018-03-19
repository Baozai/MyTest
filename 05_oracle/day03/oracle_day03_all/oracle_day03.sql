�б���
��һ��SELECT�Ӿ��а����������߱���ʽ
ʱ����ѯ�Ľ������Ӧ�ĸ��ֶξ���ʹ��
����������߱���ʽ��Ϊ�ֶ������ɶ���
�Ϊ�˿���Ϊ�������ֶ����ӱ�����
������ʹ��˫���ţ���ô�����Ϳ�������
��Сд���Ұ����ո�
SELECT ename,sal*12 sal
FROM emp

AND�����ȼ�����OR
SELECT ename,job,sal
FROM emp
WHERE sal>1000
AND (job='SALESMAN'
OR job='CLERK')

LIKE�ؼ���
LIKE����ģ��ƥ���ַ�������֧��
����ͨ����Ƚ�:
_:��ʾ��һ��һ���ַ�
%:��ʾ������ַ�(0-���)

�鿴���ֵڶ�����ĸ��A�ĵ��ĸ���ĸ��T��Ա��
SELECT ename
FROM emp
WHERE ename LIKE '_A_T%'


IN(list)��NOT IN(list)
�ж����б��л����б���
IN��NOT IN�������Ӳ�ѯ���ж���

�鿴ְλ��CLERK��SALESMAN��Ա��?
SELECT ename,job,deptno
FROM emp
WHERE job IN ('CLERK','SALESMAN')


BETWEEN...AND...
�ж���һ����Χ��
�鿴������1500��3000֮���Ա��?
SELECT ename,job,sal
FROM emp
WHERE sal BETWEEN 1500 AND 3000

ANY(list)��ALL(list)
ANY��ALL�����>,>=,<,<=ʹ�õ�
>ANY(list):�����б�֮һ
>ALL(list):�����б�����
<ANY(list):С���б�֮һ
<ALL(list):С���б�����
�������Ӳ�ѯ��


DISTINCT�ؼ���
ȥ���ظ���

�鿴��˾����Щְλ?
SELECT DISTINCT job FROM emp

���ֶ�ȥ�أ��⼸���ֶ�ֵ�����û���ظ���
SELECT DISTINCT job,deptno FROM emp


��������
ORDER BY�Ӿ������Խ��������ָ��
���ֶ�����
���������ַ�ʽ:
����(ASC):��дĬ�Ͼ�������
����(DESC):�Ӵ�С����Ҫ����ָ��
ORDER BY�Ӿ����д��DQL�����һ���Ӿ���

�鿴��˾�й��ʵ�����:
SELECT ename,sal,deptno
FROM emp
ORDER BY sal DESC

���ֶ����������ȼ������Ȱ��յ�һ��
�ֶ����򣬵���һ���ֶ����ظ�ֵʱ��
���յڶ����ֶ������������ơ�
SELECT ename,deptno,sal
FROM emp
ORDER BY deptno DESC,sal DESC

NULL������Ϊ���ֵ
SELECT ename,comm
FROM emp
ORDER BY comm DESC


�ۺϺ���
�ۺϺ����ֳ�Ϊ:���к��������麯��.
�����ǶԽ������ָ���ֶν���ͳ��Ȼ��
�ó�һ�����.

�鿴��˾����߹�������͹���?
SELECT MAX(sal),MIN(sal)
FROM emp

�鿴��˾��ƽ�������빤���ܺ�?
SELECT AVG(sal),SUM(sal)
FROM emp

COUNT�����ǶԼ�¼����ͳ��
�鿴��˾��������?
SELECT COUNT(ename) FROM emp

�ۺϺ�������NULLֵ
SELECT SUM(comm),AVG(comm) FROM emp

SELECT AVG(NVL(comm,0)) FROM emp

����
GROUP BY �Ӿ�
GROUP BY���Խ���������ո����ֶ�
ֵһ���ļ�¼���з��飬��ϾۺϺ���
���ԶԲ�ͬ�ķ���ֱ�ͳ�ƽ����

SELECT AVG(sal),deptno
FROM emp
GROUP BY deptno

SELECT MAX(sal),job
FROM emp
GROUP BY job


���ֶη���
��Щ�ֶ�ֵ��һ���ļ�¼����һ��
ͬ���ţ�ְͬλ��Ա����ƽ������?
SELECT AVG(sal),deptno,job
FROM emp
GROUP BY deptno,job


�鿴ÿ�����ŵ���͹����Ƕ���?
ǰ���Ǹò��ŵ���͹���Ҫ����1000
SELECT MIN(sal),deptno
FROM emp
WHERE MIN(sal)>1000
GROUP BY deptno

�����SQL���ᱨ��:�˴�������ʹ�÷��麯��

HAVING�Ӿ�
HAVING�Ӿ�������GROUP BY �Ӿ�֮����
�������ӹ�������������GROUP BY�ķ��飬��
���Խ������������ķ���ȥ����HAVING�Ӿ�
����ʹ�þۺϺ�����Ϊ����������
SELECT MIN(sal),deptno
FROM emp
GROUP BY deptno
HAVING MIN(sal)>1000

�鿴ƽ�����ʸ���2000�Ĳ��ŵ���͹���?
SELECT MIN(sal),deptno
FROM emp
GROUP BY deptno
HAVING AVG(sal)>2000


�鿴��͹��ʸ���1000����Щְλ��ƽ������?
SELECT AVG(sal),job
FROM emp
GROUP BY job
HAVING MIN(sal)>1000


������ѯ
��ѯ�����ǴӶ��ű��й�����ѯһ�������
������ѯ���ص�����������������
���������������Ǹ�֪���ݿ�����֮���
������������Ӧ�ġ�
������ѯͨ����Ҫ��������������������
���ѿ�������ͨ����һ��������Ľ������

�鿴ÿ��Ա���������Լ������ڲ��ŵ�����?
SELECT e.ename,e.deptno,d.dname
FROM emp e,dept d
WHERE e.deptno=d.deptno

��������ѯ�ı�����ͬ���ֶΣ���Ҫͨ������
���������ָ�����ֶ���������


�ڹ�����ѯ�й���������������������
ͬʱ������
�鿴RESEARCH���ŵ�Ա����Ϣ?
SELECT e.ename,e.deptno,d.dname
FROM emp e,dept d
WHERE e.deptno=d.deptno
AND d.dname='RESEARCH'

������������������ѿ�����
SELECT e.ename,d.dname
FROM emp e,dept d


������
������Ҳ�ǹ�����ѯ��һ��
SELECT e.ename,d.dname
FROM emp e,dept d
WHERE e.deptno=d.deptno


SELECT e.ename,d.dname
FROM emp e JOIN dept d
ON e.deptno=d.deptno
WHERE d.dname='RESEARCH'

������ѯ���Բ��������������ļ�¼

������
�������ڹ�����ѯʱ�����Խ�����������
�����ļ�¼Ҳ��ѯ������
�����ӷ�Ϊ:
�������ӣ��������ӣ�ȫ������
��������:��JOIN������Ϊ������
���������������ݶ�Ҫ�г�������ô���ñ�
ĳ����¼��������������ʱ����ô�����Ҳ�
�����ֶ�ֵȫ��ΪNULL��
SELECT e.ename,d.dname
FROM emp e 
  LEFT|RIGHT|FULL OUTER JOIN 
dept d
ON e.deptno=d.deptno

������
����ǰ���е�һ����¼���Զ�Ӧ��ǰ����
������¼ʱ��������Ƴ�Ϊ�����ӡ�

�鿴ÿ��Ա���Լ�����˾������?
SELECT e.ename,m.ename
FROM emp e,emp m
WHERE e.mgr=m.empno

SELECT e.ename,m.ename
FROM emp e JOIN emp m
ON e.mgr=m.empno

�鿴SMITH����˾��˭?�����ĸ����й���?










































