-- �����Լ�
/* count(), sum(), avg(), max(), min() */
select count(*) from emp;
select count(empno) from emp;
--null �����ϰ� ī��Ʈ
select count(comm) from emp;
select sum(sal) from emp;
select max(sal) from emp;
select min(sal) from emp;
select avg(sal) from emp;
select round(avg(sal),1) from emp;
select count(*),sum(sal),max(sal),min(sal),avg(sal) from emp;

-- �����Լ�
-- concat( '���ڿ�1', '���ڿ�2')
select concat(ename, '�� ������ '), job from emp;

select ename || '�� ������ ' || job from emp;

-- replace( '���ڿ�1', '���ڿ�2', '���ڿ�3')
select replace('java program', 'java', '�ڹ�') from dual;

-- substr( '���ڿ�', �ڸ���, ���ڼ�)
select substr('java program', 4, 3) from dual;

select ename from emp where substr(ename, 2, 1) = 'ö';

-- ��¥ �Լ�
-- sysdate
select sysdate from dual;

-- add_months(��¥������, ����)
select add_months(sysdate, 3) from dual;
select add_months('2021/01/26', 3) from dual;
select add_months('2021/01/26', -3) from dual;
select hiredate, add_months(hiredate, 3) from emp
where hiredate between '2010/01/01' and '2020/12/31';

select sysdate + 100 from dual;
select sysdate - 100 from dual;

-- months between(��¥1, ��¥2)
select months_between('2021/05/25', '2021/01/05') from dual;

select ename, hiredate, months_between(sysdate, hiredate) �ٹ������� from emp;

-- to_char(��¥�÷� or ��¥������, '�������')
/*
d: �����ڵ�(1~7)
day: ���� ���ڿ�
dd: 1~31��
mm: 01~12��
yy: ���ڸ� ����
yyyy: ���ڸ� ����
hh: 1~12 �ð���
hh24 : 24�ð���
mi: ��
ss: ��
am,pm: ����, ����
*/
select to_char(sysdate, 'yyyy-mm-dd am hh:mi:ss day') from dual;

-- to_date( '��¥ ������ ���ڿ�', '��¥ ��ȯ ����')
select to_date('2018-01-26', 'yyyy- mm- dd') from dual;

-- �����Լ�
-- ���ں�ȯ �Լ�: to_number( '���� ������ ���ڿ�')
--���������� to_number()�� ȣ���
select '100'+ 1 from dual;
select to_number('100')+ 1 from dual; 

-- trunc(����, �ڸ���) : ������ �ڸ��� ������ �Ҽ��� ����
select ename, trunc((sysdate- hiredate)/365) �ټӿ��� from emp; 

-- round(����, �ڸ���) : �ݿø�
select round(10.555555, 2) from dual;

-- ceil(����) : �ø�
select ceil(10.1) from dual;

-- ���ǰ˻� �Լ�
-- nvl(�÷�, ��ü��)
select pname, pay, bonus, pay*12 + bonus ����
from prof
where majorno= 101;

select pname, pay, bonus, pay*12 + nvl(bonus,0) ����
from prof
where majorno= 101;

-- decode(A, B, A == B�϶��� ��, A != B�϶��� ��)
select pname, majorno, decode(majorno, 101, '��ǻ�Ͱ���') ������
from prof;

-- �ǽ�
select * from emp;
/*
1. ������ �̸�, ����, �޿��� ����Ͻÿ�.(������ 300 �̻��� ������ ����մϴ�.)
*/
select ename �̸�, job ����, sal �޿� from emp
where sal >= 300
order by sal desc;

select ename || ' ' || job || '�� �޿��� ' || sal || '�Դϴ�.' �޿����� 
from emp
where sal >= 300
order by sal desc;

/*
2. ������ �̸��� �ٹ��������� ����Ͻÿ�.(�ٹ��������� 100���� �̻��� ������ ����մϴ�.)
*/
select ename �̸�, round(months_between(sysdate, hiredate)) �ٹ������� from emp
where months_between(sysdate, hiredate) > 100
order by �ٹ������� desc, �̸�;

/*
3. ������ �̸��� ����, �� �ٹ���(week)���� ����Ͻÿ�. (�ٹ��ּ� ��������, �ٹ��ּ��� ������ �̸��� ���Ͽ� �������� �����մϴ�.)
*/
select ename �̸�, job ����, round((sysdate-hiredate)/7) "�� �ٹ���"
from emp
order by "�� �ٹ���" desc, �̸�;
