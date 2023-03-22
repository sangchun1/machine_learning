-- �ε��� : �뷮�� ���ڵ尡 ����� ���̺��� �����͸� ������ �˻��� �� �ֵ��� �������ִ� ��ü

-- �ε��� ���� : create index �ε����� on ���̺�� (�÷���);   
--   (primary key �� �ε����� �ڵ����� ������)
create index c_emp_name_idx on c_emp(name);

-- �ε��� ���� : drop index �ε�����; 
drop index c_emp_name_idx;

-- �ε��� �ǽ�
--parsing(��ɾ� �м�) -> �����ȹ ����(��Ƽ������) -> ����
--sql developer : F10(�����ȹ ����)
--full scan ��� ���ڵ带 �˻�
--�ε����� ����� �˻�(by index rowid)
--index unique scan : ������ ��
--index range scan : �������� ���� ��
select empno,ename from emp where empno=7900;
select empno,ename from emp where ename='�ڹ�ö'; 

--�ε��� �߰�
create index emp_ename_idx on emp(ename);
-- �ε����� ����Ͽ� �˻�
select empno,ename from emp where ename='�ڹ�ö'; 
--�ε��� ����
drop index emp_ename_idx;

--�ε��� �׽�Ʈ�� ���� ���̺� ����
create table emp3 (
    no number,
    name varchar2(10),
    sal number
);

-- PL/SQL (Procedural Language)
-- �׽�Ʈ�� ���ڵ� 10���� �Է�
declare
    i number := 1;
    name varchar(20) := 'kim';
    sal number := 0;
begin
    while i <= 100000 loop
        if i mod 2 = 0 then
            name := 'kim' || to_char(i);
            sal := 300;
        elsif i mod 3 = 0 then
            name := 'park' || to_char(i);
            sal := 400;
        elsif i mod 5 = 0 then
            name := 'hong' || to_char(i);
            sal := 500;
        else
            name := 'shin' || to_char(i);
            sal := 250;
        end if;
        insert into emp3 values (i,name,sal);
        i := i + 1;
    end loop;
end;
/ 

--�ε����� ������� ���� ��� : table access full, cost:104
select * from emp3 where name='shin691' and sal > 200;

--�ε��� �߰�
create index emp_name_idx on emp3(name,sal);

--index range scan, cost:11
select * from emp3 where name='shin691' and sal > 200;

--�ε��� ���� Ȯ��
-- unique index : primary key, unique �������� �÷��� ����
-- nonunique index
select * from user_indexes where table_name='EMP3';

-- �����ε����� and ���꿡���� ��� ����, or ���꿡���� ������� ����
select * from emp3 where name like 'park1111%' and sal> 300;
select * from emp3 where name like 'park1111%' or sal> 300;

--primary key�� �ε����� �ڵ����� ������
create table emp4 (
    no number primary key,
    name varchar2(10),
    sal number
);

select * from user_indexes where table_name='EMP4';

--no �÷��� primary key ����
alter table emp3 add constraint emp3_no_pk primary key(no);
select * from user_indexes where table_name='EMP3';

--�ε����� ����� ��� �ڵ� ����
select * from emp3 where no>90000;

--primary key �������� ���� (�ε��� ����)
alter table emp3 drop constraint emp3_no_pk;
select * from user_indexes where table_name='EMP3';

--�ε����� ������� ���� ��� �ڵ� ������ ���� ����
select * from emp3 where no>90000;