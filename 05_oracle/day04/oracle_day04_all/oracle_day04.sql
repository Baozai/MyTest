�Ӳ�ѯ
�Ӳ�ѯ��һ����ѯ��䣬����Ƕ��������
SQL��䵱�еģ�Ŀ����Ϊ������ѯ�ṩ
���ݵġ�
�鿴˭�Ĺ��ʸ���CLARK?
SELECT ename,sal
FROM emp
WHERE sal>(SELECT sal FROM emp
           WHERE ename='CLARK')


SELECT ename,job
FROM emp
WHERE job=(SELECT job FROM emp
           WHERE ename='SMITH')

�鿴˭�Ĺ��ʸ��ڹ�˾ƽ������?
SELECT ename,sal
FROM emp
WHERE sal>(SELECT AVG(sal) FROM emp)

��DDL��ʹ���Ӳ�ѯ
���Ը���һ����ѯ��������ٹ���һ�ű�
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


DML��ʹ���Ӳ�ѯ
��SMITH���ڲ��ŵ�Ա�������ϸ�10%
UPDATE emp
SET sal=sal*1.1
WHERE deptno=(SELECT deptno FROM emp
              WHERE ename='SMITH')

SELECT * FROM emp

DELETE FROM emp
WHERE deptno=(SELECT deptno FROM emp
              WHERE ename='CLARK')

���Ӳ�ѯΪ���е���ʱ����ô�������ж�
������ʱҪ����IN,ANY,ALLʹ��
�鿴��ְλ��SALESMANͬ���ŵ�����ְλԱ��?

SELECT ename,sal,deptno,job
FROM emp
WHERE deptno IN(SELECT deptno 
                FROM emp
                WHERE job='SALESMAN')
AND job <> 'SALESMAN'                

�鿴��ְλ��SALESMAN��CLERK����
���ߵ�Ա����Ϣ?
SELECT ename,sal
FROM emp
WHERE 
 sal>ALL(SELECT sal FROM emp
         WHERE 
          job IN('SALESMAN','CLERK')
        )


EXISTS�ؼ���
EXISTS�ؼ��ֺ����һ���Ӳ�ѯ������
�Ӳ�ѯ���Բ�ѯ������һ����¼ʱ��EXISTS
����������

�鿴��Ա���Ĳ�������Щ?
SELECT d.deptno,d.dname,d.loc
FROM dept d
WHERE EXISTS(
  SELECT * FROM emp e
  WHERE e.deptno=d.deptno
)

�鿴��Щ���Ǳ��˵��쵼?
SELECT empno,ename,job,deptno
FROM emp m
WHERE EXISTS(
  SELECT * FROM emp e
  WHERE e.mgr=m.empno
)


�鿴���ŵ����нˮ��ǰ���Ǹò��ŵ����
нˮҪ����30�Ų��ŵ����нˮ?
SELECT MIN(sal),deptno
FROM emp
GROUP BY deptno
HAVING 
 MIN(sal)>(SELECT MIN(sal) FROM emp
           WHERE deptno=30)


��FROM�Ӿ���ʹ���Ӳ�ѯͨ���ǽ��Ӳ�ѯ�Ľ��
����һ�ű��������ڸò�ѯ������ж��β�ѯ
ʹ�á�
�鿴˭�Ĺ��ʸ��������ڲ��ŵ�ƽ������?
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


��ҳ��ѯ
��ҳ��ѯ���ǽ����ݷֶβ�ѯ������һ��
ֻ��ѯ���ݵ�һ���֡�
���������Լ���ϵͳ��Դ��������������
������������紫���ٶȡ� 

��ҳ�ڲ�ͬ�����ݿ��е�SQL����ǲ�ͬ�ġ�

ORACLE���ṩ��һ��α��:ROWNUM
ROWNUM�ֶβ��������κ�һ�ű��У�����ÿ��
�����Բ�ѯ���ֶΡ����ֶε�ֵ�ǽ������
ÿ����¼���кš�
ROWNUM�ֶε�ֵ�Ƕ�̬���ɵģ������ѯ���̡�
ֻҪ���Բ�ѯ��һ����¼��ROWNUM�ͻ�Ϊ����
��¼�����кţ���1��ʼÿ�ε���1.

����ROWNUM���ڲ�ѯ��Ĺ����н��б��
�ģ�������ʹ��ROWNUM�Խ�������кŵ�
��ѯ�����в�Ҫʹ��ROWNUM������1������
�ֵ��жϣ���������û���κ����ݡ�
SELECT *
FROM (SELECT 
       ROWNUM rn,empno,ename,
       sal,deptno
      FROM emp)
WHERE rn BETWEEN 6 AND 10

�鿴��˾���������ĵ�6-10��
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

pageSize(ÿҳ��ʾ����Ŀ��)
page(ҳ��)

start:(page-1)*pageSize+1
end:pageSize*page





DECODE����������ʵ�ַ�֧Ч����
SELECT 
  ename, job, sal,
  DECODE(job,  
         'MANAGER', sal * 1.2,
         'ANALYST', sal * 1.1,
         'SALESMAN', sal * 1.05,
         sal) bonus
FROM emp;

��MANAGER��ANALYST����һ�飬����ְλ
������һ�飬�ֱ�ͳ����������?
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


������
�������������������ָ���ֶη���
�����ڰ���ָ���ֶ�����Ȼ��ú���Ϊ
ÿ������һ���кš�

ROW_NUMBER():��������������Ψһ������

�鿴ÿ�����ŵĹ�������?
SELECT 
  ename,deptno,sal,
  ROW_NUMBER() OVER(
    PARTITION BY deptno
    ORDER BY sal DESC
  ) rank
FROM emp


RANK����
�������ڲ�����Ҳ��Ψһ������
SELECT 
  ename,deptno,sal,
  RANK() OVER(
    PARTITION BY deptno
    ORDER BY sal DESC
  ) rank
FROM emp



DENSE_RANK����
����������������Ψһ������
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

�鿴ÿ���Ӫҵ��?
SELECT year_id,month_id,
       day_id,SUM(sales_value)
FROM sales_tab
GROUP BY year_id,month_id,day_id
ORDER BY year_id,month_id,day_id

ÿ�µ�Ӫҵ�
SELECT year_id,month_id,
       SUM(sales_value)
FROM sales_tab
GROUP BY year_id,month_id
ORDER BY year_id,month_id

ÿ���Ӫҵ��?
SELECT year_id,SUM(sales_value)
FROM sales_tab
GROUP BY year_id
ORDER BY year_id

�ܹ���Ӫҵ��?
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


�߼����麯��
1:ROLLUP(a[,b,c...])
GROUP BY ROLLUP(a,b,c)
��ͬ��
GROUP BY a,b,c
UNION ALL
GROUP BY a,b
UNION ALL
GROUP BY a
UNION ALL
ȫ��

�鿴ÿ�죬ÿ�£�ÿ���Լ�����Ӫҵ��?
SELECT year_id,month_id,
       day_id,SUM(sales_value)
FROM sales_tab
GROUP BY
 ROLLUP(year_id,month_id,day_id)


2:CUBE()
CUBU�ķ������Ϊÿ�����������
����һ�η���
GROUP BY CUBE(a,b,c)
��ͬ��
a,b,c
a,b
b,c
a,c
a
b
c
ȫ��

SELECT year_id,month_id,
       day_id,SUM(sales_value)
FROM sales_tab
GROUP BY
 CUBE(year_id,month_id,day_id)
ORDER BY year_id,month_id,day_id



GROUPING SETS()
�ú�����������ָ��������ԣ�Ȼ����Щ
����ͳ�ƵĽ������һ�𡣺�����ÿ������
Ϊһ�ַ��鷽ʽ��
�鿴ÿ����ÿ�µ�Ӫҵ��?
SELECT year_id,month_id,
       day_id,SUM(sales_value)
FROM sales_tab
GROUP BY
 GROUPING SETS(
   (year_id,month_id,day_id),
   (year_id,month_id)
 )
ORDER BY year_id,month_id,day_id





