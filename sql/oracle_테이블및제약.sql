-- ���̺� ����
create table t_emp (
    id number not null,
    name varchar2(25),
    salary number(7,2),
    phone varchar2(15),
    dept_name varchar2(25)
);

-- ���̺�� ���� : rename ~ to ~
rename t_emp to s_emp;

-- ���̺� ������ �Է�
insert into s_emp values(100, '������', 3000,'010-222-3333', '������'); 
insert into s_emp values(101, '�ּ�ö', 3600,'010-333-4444', '������'); 
insert into s_emp values(102, '������', 4500,'010-444-5555', '������'); 

-- ���̺� �÷� �߰�
alter table s_emp add hire_date date;

-- �÷� ����
alter table s_emp modify phone varchar2(50);

-- �÷��� �̸� ����
alter table s_emp rename column id to t_id;

-- �÷��� ����
alter table s_emp drop column dept_name;

-- insert, update, delete
-- ���� ���ڵ��� hire_date ����
update s_emp set hire_date = sysdate where t_id = 100;
update s_emp set hire_date = sysdate where t_id = 101;
update s_emp set hire_date = sysdate where t_id = 102;

-- ���ο� ���ڵ� �߰�
insert into s_emp (t_id,hire_date) values(40,sysdate);

-- ���ڵ� ����
delete from s_emp where t_id=102;