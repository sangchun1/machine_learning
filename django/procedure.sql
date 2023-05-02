-- 급여 인상 프로시저
create or replace procedure mysal_p(p_empno number)
is
begin
    update procedure_emp
    set sal=sal*1.1
    where empno=p_empno;
end;
/
select * from procedure_emp;
execute mysal_p(7499);
select * from user_source where name='MYSAL_P';

-- 메모 저장 프로시저
create or replace procedure memo_insert_p(p_writer varchar, p_memo varchar)
is
begin
    insert into memo_memo (writer,memo,post_date)
    values ( p_writer, p_memo, sysdate);
end;
/
execute memo_insert_p('김철수', '메모');
execute memo_insert_p('박철수', '메모1');
commit;
select * from user_source where name='MEMO_INSERT_P';

-- 메모 목록 프로시저
create or replace procedure memo_list_p(v_row out sys_refcursor)
is
begin
    open v_row for
        select idx,writer,memo,post_date
        from memo_memo
        order by idx desc;
end;
/
select * from user_source where name='MEMO_LIST_P';

-- 메모 상세 프로시저
create or replace procedure memo_view_p(v_idx number, v_row out sys_refcursor)
is
begin
    open v_row for
        select idx,writer,memo,post_date
        from memo_memo
        where idx=v_idx;
end;
/

-- 메모 수정 프로시저
create or replace procedure memo_update_p(p_idx number, p_writer varchar, p_memo varchar)
is
begin
    update memo_memo set writer=p_writer, memo=p_memo where
    idx=p_idx;
end;
/

-- 메모 삭제 프로시저
create or replace procedure memo_delete_p(p_idx number)
is
begin
    delete from memo_memo where idx=p_idx;
end;
/

insert into procedure_emp values (7369,'이철수','사원','2010-12-17',300);
insert into procedure_emp values (7499,'이민수','대리','2011-02-20',360);
insert into procedure_emp values (7521,'박종수','대리','2012-02-22',425);
insert into procedure_emp values (7566,'임성민','팀장','2011-04-02',597);
insert into procedure_emp values (7654,'나호석','대리','2011-09-28',425);
insert into procedure_emp values (7698,'박성환','팀장','2021-05-01',585);
insert into procedure_emp values (7782,'손기철','팀장','2021-06-09',545);
insert into procedure_emp values (7788,'박기호','부장','2007-04-17',600);
insert into procedure_emp values (7839,'김철수','대표','2011-11-17',900);
insert into procedure_emp values (7844,'송명준','대리','2011-09-08',450);
insert into procedure_emp values (7876,'황선태','사원','2017-05-23',310);
insert into procedure_emp values (7900,'박민철','사원','2011-12-03',395);
insert into procedure_emp values (7902,'박희성','부장','2011-12-03',700);
insert into procedure_emp values (7934,'최철수','사원','2012-01-23',330);
select * from procedure_emp;
commit;

select * from memo_memo;
select * from mymember_member;
desc mymember_member;

select * from ajax_keyword;
insert into ajax_keyword values (1, 'test1');
insert into ajax_keyword values (2, 'test2');
insert into ajax_keyword values (3, 'test3');
insert into ajax_keyword values (4, 'thanks');
insert into ajax_keyword values (5, 'thank you');
select * from ajax_keyword;
commit;

select * from guestbook_guestbook;
desc guestbook_guestbook;

select * from auth_user;