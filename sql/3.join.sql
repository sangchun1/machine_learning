-- stud, major ���̺��� �����Ͽ� �̸�, �а��ڵ�, �а��̸��� ����Ͻÿ�.
select sname, s.majorno, mname
from stud s, major m
where s.majorno = m.majorno;

-- emp ���̺��� �����ȣ�� dept ���̺��� �μ����� �����Ͽ� ����Ͻÿ�.
select empno, ename, dname
from emp e, dept d
where e.deptno = d.deptno;

-- �л�, �а�, ���� ���̺��� �����Ͽ� �л��̸�, �а��̸�, ���������̸��� ����Ͻÿ�
select sname, mname, pname
from stud s, major m, prof p
where s.majorno = m.majorno and s.profno=p.profno;

-- self join : �����ؾ� �� �÷��� �ڽ��� ���̺� �ִ� �ٸ� �÷��� ��쿡 ����ϴ� ����
select a.empno ���, a.ename �̸�, b.empno �Ŵ������, b.ename �Ŵ���
from emp a, emp b
where a.mgr = b.empno;

-- outer join: ���� ���̺��� �ڷᰡ ���� ��쿡 ��µǵ��� �Ϸ��� �ܺ� ������ �ؾ� ��
select sname, pname
from stud s, prof p
where s.profno= p.profno;

select sname, pname
from stud s left outer join prof p
    on s.profno= p.profno;

select sname, s.majorno, pname
from stud s, prof p
where s.profno = p.profno(+);


-- ANSI ����
select empno , dname
from emp e inner join dept d
    on e.deptno = d.deptno;

-- left outer join
select sname, s.majorno, pname
from stud s left outer join prof p
    on s.profno = p.profno;
 
select sname, s.majorno, pname
from stud s, prof p
where s.profno = p.profno(+);

-- right outer join
select sname, s.majorno, pname
from stud s right outer join prof p
    on s.profno = p.profno;
    
select sname, s.majorno, pname
from stud s, prof p
where s.profno(+) = p.profno;

-- full outer join
select sname, s.majorno, pname
from stud s left outer join prof p
    on s.profno = p.profno
union all

select sname, s.majorno, pname
from stud s right outer join prof p
    on s.profno = p.profno;
    
-- �ǽ�����
-- ���̺� ���� ����(��ǰ���̺�, �Ǹ����̺�)
-- 1. ��ǰ���̺�( ��ǰ�ڵ�, ��ǰ��, �ܰ�, ������, �������� )
drop table product;
create table product (
product_code varchar2(20) not null primary key,
product_name varchar2(50) not null,
price number default 0,
company varchar2(50),
make_date date default sysdate
);

insert into product values ('A1', '������', 900000, '����', '2017-03-01');
insert into product values ('A2', '�����ó�Ʈ', 1000000, '�Ｚ', '2017-08-01');
insert into product values ('A3', '��������', 1200000, '�Ｚ', '2017-10-01');

select * from product;

-- 2. �Ǹ� ���̺�(��ǰ�ڵ�, �Ǹż���)
create table product_sales (
product_code varchar2(20) not null,
amount number default 0
);

insert into product_sales values ('A1', 100);
insert into product_sales values ('A2', 200);
insert into product_sales values ('A3', 300);

select * from product_sales;

-- ��ǰ���̺�� �Ǹ����̺��� ����
-- ��ǰ�ڵ�, ��ǰ�̸�, ������, �ܰ�, ����, �ݾ�
select p.product_code, product_name, price, company, amount, price*amount money, make_date
from product p, product_sales s
where p.product_code = s.product_code;

-- ANSI join
select p.product_code, product_name, price, company, amount, price*amount money, make_date
from product p inner join product_sales s
    on p.product_code = s.product_code;

-- View(��, �������̺�)
create or replace view product_sales_v
as
select p.product_code, product_name, price, company, amount, price*amount money, make_date
from product p, product_sales s
where p.product_code = s.product_code; 

-- �並 ���̺�ó�� Ȱ�� ����
select * from product_sales_v
where company='�Ｚ';

-- �ǽ�����
select * from emp;
select * from dept;
/*
1. emp�� dept ���̺��� �����Ͽ� ����̸�, �μ���, �޿��� ����Ͻÿ�.
*/
select ename ����̸�, dname �μ���, sal �޿�
from emp e, dept d
where e.deptno = d.deptno;

/* 
2. ������ ��������� ����̸�, �μ����� ����Ͻÿ�.
*/
select ename ����̸�, dname �μ���
from emp e join dept d
    on e.deptno = d.deptno
where job = '���';

/* 
3. �̸��� ���ձ�ö���� ����� �μ����� ����Ͻÿ�.
*/
select dname �μ���
from emp e join dept d
    on e.deptno = d.deptno
where ename = '�ձ�ö';

/* 
4. emp���̺� �ִ� empno, mgr�� �̿��Ͽ� ������ ���踦 ������ ���� ����Ͻÿ�. ���������� �Ŵ����� �ڼ�ȯ�̴١�
*/
select a.ename || '�� �Ŵ����� ' || b.ename || '�̴�' ����
from emp a, emp b
where a.mgr = b.empno;