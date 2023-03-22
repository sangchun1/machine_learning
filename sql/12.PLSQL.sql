-- PL/SQL : Oracle's Procedural Language extension to SQL

-- PL/SQL의 형식
/*
declare
-- 선언부(변수, 상수, CURSOR 등)    
begin
-- 실행부(SQL 명령어, 반복문, 조건문 등)    
exception
--예외처리부
end;
*/

-- 1. 저장 프로시저 : Stored Procedure(SP, 저장 프로시저)
/* 형식:
CREATE OR REPLACE PROCEDURE 프로시저이름(매개변수)  
IS
    변수 선언
BEGIN
    문장
END;
*/

-- 급여 인상 저장 프로시저 실습
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

-- 한줄메모장 저장 프로시저 실습
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

execute memo_insert_p('김철수', '메모...', '192.168.0.10');

select * from memo;

select * from user_source where name='MEMO_INSERT_P';