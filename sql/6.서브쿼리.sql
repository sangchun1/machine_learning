-- ���� ������ �������� ��������
-- ������ ���� ���� �޴� ���
select min(sal) from emp;

select * from emp
where sal = 300;

select * from emp
where sal = (select min(sal) from emp);

-- ������� ��� ���޺��� ���� �޿��� �޴� ����̸�, �μ���, �޿�
select (avg) from emp;

select ename, dname, sal
from emp e, dept d
where e.deptno = d.deptno
    and sal > (select avg(sal from emp);

-- ��ȹ�� �������� (�μ��ڵ�:30) �ְ�޿����� ���� ������ �޴� ����̸�, �μ��̸�, �޿�
select max(sal) from emp
where deptno = 30;

select ename, dname
from emp e, dept d
where e.deptno = d.deptno
    and sal > (select max(sal) from emp where deptno = 30);
    
-- ���������� �������� �ִ� ��������
-- ����̸�, �μ��ڵ�, �μ���
--  (�������� ó���� ���)
select ename, e.deptno, dname
from emp e, dept d
where e.deptno = d.deptno;

--  (���������� ó���� ���)
select ename, deptno,
    (select dname from dept where deptno = e.deptno) dname
from emp e;

-- ����� �ٹ��ϴ� �μ��� ��� �޿����� ���� �޿��� �޴� �����̸�, �޿�, �μ���ȣ

-- 4. �ζ��� ��(inline view) : from���� ��ġ�� ��������
--��ձݾ׺��ٴ� ���� �ְ�ݾ׺��ٴ� ���� ������ �޴� �����
select empno, ename, sal, round(e2.avgs) e2.maxs
from emp, 
    select avg(sal) avgs, max(sal) maxs from emp) e2
where sal > e2.avgs and sal < e2.maxs
order by sal desc;

-- ����(job)�� "���"�� ������� �����, ����, �μ���
select ename, job, dname
from
    (select ename, job, deptno form emp where job = '���') e,
    dept d
where e.deptno = d.deptno;

-- scalar �������� : �Ѱ��� ��, �Ѱ��� �÷��� ��ȯ�ϴ� �������� 
-- ��� �̸�, �޿�, �Ҽ� �μ��� ��ձ޿�
select ename, sal,
    (select avg(sal) from emp) avg_sal,
    (select avg(sal) from emp
        where deptno = e.deptno) dept_avg_sal
from emp e;

-- �ǽ�����
/*
1. ����ö �������� ���߿� �Ի��� ������, �Ի���, �������� ����Ͻÿ�.
*/
select pname, hiredate, mname
from prof p, major m
where p.majorno = m.majorno
    and hiredate > (select hiredate from prof where pname='����ö');

/*
2. �ɻ�� �������� ���߿� �Ի��� ���� �߿��� ��öȣ �������� ������ ���� �޴� ������, �޿�, �Ի����� ����Ͻÿ�.
*/
select pname, pay, hiredate
from prof
where hiredate > (select hiredate from prof where pname='�ɻ��')
    and pay < (select pay from prof where pname='��öȣ');