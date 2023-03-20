-- groupby : Ư���� �÷��� �������� ����� �����͸� ���� ���� ��ɾ�
--  (select���� �÷��� �����Լ��� �����ϰ� ��� group by���� ����ؾ� ��)
-- emp ���̺��� �μ��ڵ庰�� �޿����� ���
select deptno, count(*), sum(sal), avg(sal), min(sal), max(sal)
from emp
group by deptno
order by dpetno;

select e.deptno, dname, count(*), sum(sal), avg(sal), min(sal), max(sal)
from emp e, dept d
where e.deptno = d.deptno
group by e.deptno, dname
order by deptno;

-- �����ڵ庰�� �������� ��� �޿�
select majorno, round(avg(pay),2)
from prof
group by majorno
order by majorno;

select p.majorno, mname, round(avg(pay),2)
from prof p, major m
where p.majorno = m.majorno
group by p.majorno, mname
order by p.majorno;

-- �����ڵ庰, ���޺� ��� �޿�
select majorno, position, round(avg(pay),2)
from prof
group by majorno, position
order by majorno, position;

-- having : group by�� ��� �߿��� ���ǿ� �´� ���� �����ϱ� ���� ��ɾ�
-- ������ ��� �޿��� 450 �̻��� ������ ��ձ޿� ���
select mname, round(avg(pay),2)
from prof p, major m
where p.majorno = m.majorno
group by mname
having avg(pay) >= 450;

-- �ǽ�����
select * from stud;
select * from major;
select * from prof;
/*
1. stud ���̺�� major ���̺��� ������ �� �����ڵ庰�� �����Ͽ� �����ڵ�, �����̸�, �л����� ����Ͻÿ�.
*/
select s.majorno, mname, count(*)
from stud s, major m
where s.majorno = m.majorno
group by s.majorno, mname;

/*
2. �����������, ���������̸�, �����л����� ����Ͻÿ�.(stud ���̺�� prof ���̺��� �����Ͽ� �������� ������� ����)
*/
select p.profno, pname, count(*)
from prof p, stud s
where p.profno = s.profno
group by p.profno, pname;

/*
3. ���� �߿��� �޿��Ѿ�(�޿�+ ���ʽ�)�� ���� ���������� ���� ���� ����, �޿��Ѿ��� ��ձݾ��� ����Ͻÿ�.(�����ڵ庰�� ����)
*/
select majorno, max(pay+nvl(bonus,0)), min(pay+nvl(bonus,0)), round(avg(pay+nvl(bonus,0)),2)
from prof
group by majorno;