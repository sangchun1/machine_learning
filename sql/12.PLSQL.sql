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