-- day 11
---- 7. ���ΰ� ��������
-- (2) �������� : Sub-Query

--     SELECT, FROM, WHERE ���� ���� �� �ִ�.

-- ����) BLAKE�� ����(job)�� ������ ������ ������ ��ȸ
-- 1. BLAKE �� ������ ��ȸ(��������)
SELECT e.job
  FROM emp e
 WHERE e.ename = 'BLAKE'
;
/*
MANAGER
*/
-- 2. 1�� ����� ����(��������)
-- => ����(job)�� MANAGER �� ����� ��ȸ�Ͽ���.
SELECT e.empno
     , e.ename
  FROM emp e
 WHERE e.job = 'MANAGER'  
;

-- ���������� WHERE ���� ������ 
-- MANAGER �� �ڸ��� 1�� ������ ������ ����.
SELECT e.empno
     , e.ename
  FROM emp e
 WHERE e.job = (SELECT e.job
                  FROM emp e
                 WHERE e.ename = 'BLAKE')
;

-- => ���������� WHERE �� () ��ȣ �ȿ� ���޵Ǵ� ����
--    1�� ������ ����� MANAGER ��� ���̴�.

-------------------------------------------
-- �������� ������ �ǽ�
-- 1. �� ȸ���� ��� �޿����� �޿��� ���� �޴� ������ ��� ��ȸ�Ͽ���.
--    ���, �̸�, �޿��� ��ȸ

-- a) ȸ���� �޿� ��հ��� ���ϴ� ����


-- b) �� ��� ���� ���� �����Ͽ� �� ������ �޿��� ���� ������ ���ϴ� ����


-- c) (b) �� �������� ��� �� �ڸ��� (a)�� ������ ��ü


-- 2. �޿��� ��� �޿����� ũ�鼭
--    ����� 7700�� ���� ���� ������ ��ȸ�Ͻÿ�.
--    ���, �̸�, �޿��� ��ȸ



-- 3. �� �������� �ִ� �޿��� �޴� ���� ����� ��ȸ�Ͽ���.
--    ���, �̸�, ����, �޿��� ��ȸ

-- a) �������� �ִ� �޿��� ���ϴ� ���� : �׷��Լ�(MAX), �׷�ȭ�����÷�(job)
SELECT e.job
     , MAX(e.sal) max_sal
  FROM emp e
 GROUP BY e.job
; 

-- b) (a)���� ������ �ִ� �޿��� job �� ��ġ�ϴ��� �����ϴ� ����.
SELECT e.empno
     , e.ename
     , e.job
     , e.sal
  FROM emp e
 WHERE (e.job = 'CLERK' AND e.sal = 1300)
    OR (e.job = 'SALESMAN' AND e.sal = 1600)
    OR (e.job = 'ANALYST' AND e.sal = 3000)
    OR (e.job = 'MANAGER' AND e.sal = 2975)
    OR (e.job = 'PRESIDENT' AND e.sal = 5000)
;  

-- c) b���� ���� ���� a�� ������ ��ü
SELECT e.empno
     , e.ename
     , e.job
     , e.sal
  FROM emp e
 WHERE (e.job, e.sal) IN (SELECT e.job
                               , MAX(e.sal) max_sal
                            FROM emp e
                           GROUP BY e.job)
;
/*
==> ���ϴ� ���� �÷��� ������ 
    ��ġ���� ���� �� �߻��ϴ� ��������
ORA-00913: ���� ���� �ʹ� �����ϴ�
00913. 00000 -  "too many values"
*/
-- 4. �� ���� �Ի��ο��� ���η� ����Ͻÿ�.
--   ��� ���� : 1�� ~ 12������ �����Ͽ� ���
--  "�Ի��", "�ο�(��)"
/* ----------------------
        1��	    1
        2��	    2
        4��	    1
        5��	    1
        6��	    3
        9��	    2
        11��	1
        12��	3
-----------------------*/
-- a) �������� �Ի���� ����
SELECT TO_CHAR(e.hiredate, 'FMMM') "�Ի��"
  FROM emp e
;  

-- b) �Ի� ���� �ο��� ī��Ʈ
SELECT TO_CHAR(e.hiredate, 'FMMM') "�Ի��"
     , COUNT(*) "�ο�(��)"
  FROM emp e
 GROUP BY TO_CHAR(e.hiredate, 'FMMM')  
 ORDER BY "�Ի��"
;  

-- c) �Ի� ���� ���ڰ����� �����ؾ� ������ �½��ϴ�.
SELECT TO_NUMBER(TO_CHAR(e.hiredate, 'FMMM')) "�Ի��"
     , COUNT(*) "�ο�(��)"
  FROM emp e
 GROUP BY TO_CHAR(e.hiredate, 'FMMM')  
 ORDER BY "�Ի��"
;  

-- d) (c) �� ����� FROM ���� ������ �� �� '��'�� �ٿ��� ��.
SELECT a.month || '��' "�Ի��"
     , a.cnt           "�ο�(��)"
  FROM (SELECT TO_NUMBER(TO_CHAR(e.hiredate, 'FMMM')) month
             , COUNT(*) cnt
          FROM emp e
         GROUP BY TO_CHAR(e.hiredate, 'FMMM')  
         ORDER BY month) a
;         