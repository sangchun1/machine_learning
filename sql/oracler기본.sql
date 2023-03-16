-- �⺻����
select * from emp order by empno;

-- distinct / all
/*
distinct: �ߺ��� �����͸� ������� ����
all: �ߺ��� �����͸� �����
*/
select job from emp;
select all job from emp;
select distinct job from emp;

-- order by: ���� - asc, desc
select * from emp order by sal desc;

select * from emp
order by job, sal desc;

-- alis : ��Ī
select ename �̸�, job ����, sal �޿�
from emp
order by job, sal desc;

-- where : �˻� ����
select * from emp
where sal > 100 and sal < 400
order by sal desc;

-- �������� ����
/*
��������� : + , - , *, /
�񱳿����� : = , != , > , > = , < , < =
�������� : and, or, not
��Ÿ������: in, all, between, like, is null, is not null
*/
select ename, sal, deptno from emp
where deptno in (10, 20, 40);

select ename, sal, deptno from emp
where deptno = 10 or deptno = 20 or deptno = 40;

select ename, sal, deptno from emp
where deptno != 30;

select ename, sal from emp
where sal between 300 and 500;

select ename, sal from emp
where sal >= 300 and sal <= 500;

select ename from emp where ename like '��%';

select ename from emp where ename like '%��%';

select ename from emp where comm = null;
select ename from emp where comm is null;

select ename, comm from emp where comm != null;
select ename, comm from emp where comm is not null;

-- ���տ����� : ||
select ename || '�� �޿��� ' || sal || '�Դϴ�' from emp;

-- �������� �켱����
/*
1����: �񱳿�����, SQL������, ���������
2����: not
3����: and
4����: or
��ȣ( ): ������ �켱�������� �켱��
*/
select empno, sal from emp
where not(sal > 200 and sal < 300)
order by sal;

select empno, sal from emp
where sal < = 200 or sal > = 300
order by sal;

select empno, sal from emp
where not sal > 200 and sal < 300
order by sal;

-- �ǽ�����
select * from emp;
/*
1. emp ���̺��� �Ի���(hiredate)�� 2015�� 1��1�� ������ 
����� ���� ����� �̸�(ename), �Ի���, �μ���ȣ(deptno)�� ����Ͻÿ�.
*/

select ename �̸�, hiredate �Ի���, deptno �μ���ȣ from emp
where hiredate < '15/01/01'
order by hiredate;

/*
2. emp ���̺��� �μ���ȣ�� 20���̳� 30���� �μ��� ���� 
����鿡 ���Ͽ� �̸�, �����ڵ�(job), �μ���ȣ�� ����Ͻÿ�.
*/
select ename �̸�, job �����ڵ�, deptno �μ���ȣ from emp
where deptno in (20, 30)
order by ename;