-- PL/SQL : Oracle's Procedural Language extension to SQL

-- PL/SQL�� ����
/*
declare
-- �����(����, ���, CURSOR ��)    
begin
-- �����(SQL ��ɾ�, �ݺ���, ���ǹ� ��)    
exception
--����ó����
end;
*/

-- 1. ���� ���ν��� : Stored Procedure(SP, ���� ���ν���)
/* ����:
CREATE OR REPLACE PROCEDURE ���ν����̸�(�Ű�����)  
IS
    ���� ����
BEGIN
    ����
END;
*/

-- �޿� �λ� ���� ���ν��� �ǽ�
create or replace procedure sal_p(p_empno number)
is
begin
    update emp
    set sal=sal*1.1
    where empno=p_empno;
end;
/

select * from emp;
execute sal_p(7499);

select * from user_source where name='SAL_P';

-- ���ٸ޸��� ���� ���ν��� �ǽ�
create table memo (
    idx number primary key,
    writer varchar2(50) not null,
    memo varchar2(500) not null,
    post_date date default sysdate
);

create sequence memo_seq
    start with 1
    increment by 1;

insert into memo (idx,writer,memo) values (memo_seq.nextval,'kim', 'memo');
insert into memo (idx,writer,memo) values (memo_seq.nextval,'park', 'memo2');

alter table memo add ip varchar2(50);
desc memo;

create or replace procedure memo_insert_p(p_writer varchar, p_memo varchar, p_ip varchar)
is
begin
    insert into memo(idx,writer,memo,ip)
    values(memo_seq.nextval, p_writer, p_memo, p_ip);
end;
/

execute memo_insert_p('��ö��', '�޸�...', '192.168.0.10');

select * from memo;

select * from user_source where name='MEMO_INSERT_P';

-- 2. �Լ�(function)
/* ����:
CREATE OR REPLACE FUNCTION �Լ��̸�(�Է¸Ű�����)
RETURN �����ڷ���
IS
    ���� ����
BEGIN
    ����
    return
END;
*/

-- �Լ� ����
create or replace function sal_f(p_empno number)
return number
is
    v_sal number;
begin
    update emp set sal=sal*1.1 where empno=p_empno;
    
    select sal into v_sal from emp
    where empno=p_empno;
    return v_sal;
end;
/

select sal from emp where empno=7499;

--������ �߻��ϹǷ� �Լ��� update ��ɾ �ּ�ó���� �� �����մϴ�.
select sal_f(7499) from dual;
select empno, ename, sal, sal*1.1, sal_f(empno) from emp;

--�Լ��� update ��ɾ��� �ּ��� Ǯ�� �ٽ� �����մϴ�.
--�Ʒ� ������ ��ɾ �Ѳ����� �����մϴ�.(�߰��� �ּ��� ������ ������ �߻��մϴ�.)
var salary number;
execute :salary := sal_f(7499);
print salary;

-- 3. If ��
/* ����:
if ���� then
elsif ���� then
else
end if;
*/

-- if�� ����
create or replace procedure dept_p(p_empno number)
is
    v_deptno number;
begin
    select deptno into v_deptno from emp
    where empno=p_empno;
    dbms_output.put_line('�μ��ڵ�:'||v_deptno); 
    if v_deptno = 10 then
        dbms_output.put_line('������ �����Դϴ�'); 
    elsif v_deptno = 20 then
        dbms_output.put_line('ȫ���� �����Դϴ�'); 
    elsif v_deptno = 30 then
        dbms_output.put_line('��ȹ�� �����Դϴ�'); 
    else
        dbms_output.put_line('��Ÿ�μ� �����Դϴ�'); 
    end if;
end;
/
select * from dept;
set serveroutput on
select * from emp;
execute dept_p(7782);
execute dept_p(7788);
execute dept_p(7844);

-- 4. For Loop ��
/* ����:
for ī��Ʈ���� in [reverse] ���۰� .. �������� loop
    --�ݺ��� �����
end loop;
*/

set serveroutput on
delete from emp where empno <=100;
begin
    for cnt in 1 .. 100 loop
        insert into emp (empno,ename,hiredate) values
        (cnt, 'test'||cnt, sysdate);
    end loop;
    dbms_output.put_line('100���� ���ڵ尡 �ԷµǾ����ϴ�.'); 
end;
/

-- 5. Loop ��
/* ����:
loop
    --�ݺ��� �����
    exit [when ���ǹ�] 
end loop;
*/
set serveroutput on
delete from emp where empno <=100;
declare
    cnt number := 1;
begin
    loop
        insert into emp (empno,ename,hiredate) values
            (cnt, 'test'||cnt, sysdate);
        exit when cnt >= 100;
        cnt := cnt+1;
    end loop;
    dbms_output.put_line('100���� ���ڵ尡 �ԷµǾ����ϴ�.'); 
end;
/

-- 6. While Loop : FOR ���� ����ϸ� ������ TRUE�� ��츸 �ݺ��Ǵ� LOOP ����
delete from emp where empno<=100;
declare
    cnt number := 1;
begin
    while cnt <=100 loop
        insert into emp(empno, ename , hiredate)
        values (cnt, 'test'||cnt, sysdate);
        cnt := cnt + 1 ;
    end loop ;
    dbms_output.put_line('100���� ���ڵ尡 �ԷµǾ����ϴ�.'); 
end;
/

-- 6. Ŀ��(Cursor) : select ��ɾ��� ���� ����� �ϳ��� �� ������ Ž���ϴ� ��ü
create or replace procedure cursor_p(p_deptno number)
is
    cursor cursor_avg is
        select dname,count(empno) cnt, round(avg(sal),1) sal
        from emp e, dept d
        where e.deptno=d.deptno
            and e.deptno=p_deptno
        group by dname;
    dname varchar(50);
    cnt number;
    sal_avg number;
begin
    open cursor_avg;
    
    fetch cursor_avg into dname, cnt, sal_avg;
    dbms_output.put_line('�μ���:'|| dname); 
    dbms_output.put_line('�����:'|| cnt); 
    dbms_output.put_line('��ձ޿�:'|| sal_avg); 
    close cursor_avg;
end;
/
execute cursor_p(10);

create or replace procedure cursor2_p
is
    cursor cursor_avg is
        select dname,count(empno) cnt, round(avg(sal),1) sal
        from emp e, dept d
        where e.deptno=d.deptno
        group by dname;
begin
    for row in cursor_avg loop
        dbms_output.put_line('�μ���:'|| row.dname); 
        dbms_output.put_line('�����:'|| row.cnt); 
        dbms_output.put_line('��ձ޿�:'|| row.sal); 
    end loop;
end;
/
execute cursor2_p;

-- 7. Ʈ����(Trigger) : �������� ������ �����ϴ� ��ü
/*
create or replace trigger Ʈ�����̸�
before/after
    insert/update/delete on ���̺��̸�
    --������ ��ɾ��
*/

create or replace trigger sum_t
after
    insert or update or delete on emp
declare
    avg_sal number;
begin
    select avg(sal) into avg_sal from emp;
    dbms_output.put_line('�޿����:'|| avg_sal); 
end;
/
set serveroutput on;
select avg(sal) from emp;
insert into emp (empno,ename,hiredate,sal) values (1000,'��ö��',sysdate,500);
update emp set sal=600 where empno=1000;
delete from emp where empno=1000;