-- �޿� �λ� ���ν���
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

-- �޸� ���� ���ν���
create or replace procedure memo_insert_p(p_writer varchar, p_memo varchar)
is
begin
    insert into memo_memo (writer,memo,post_date)
    values ( p_writer, p_memo, sysdate);
end;
/
execute memo_insert_p('��ö��', '�޸�');
execute memo_insert_p('��ö��', '�޸�1');
commit;
select * from user_source where name='MEMO_INSERT_P';

-- �޸� ��� ���ν���
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

-- �޸� �� ���ν���
create or replace procedure memo_view_p(v_idx number, v_row out sys_refcursor)
is
begin
    open v_row for
        select idx,writer,memo,post_date
        from memo_memo
        where idx=v_idx;
end;
/

-- �޸� ���� ���ν���
create or replace procedure memo_update_p(p_idx number, p_writer varchar, p_memo varchar)
is
begin
    update memo_memo set writer=p_writer, memo=p_memo where
    idx=p_idx;
end;
/

-- �޸� ���� ���ν���
create or replace procedure memo_delete_p(p_idx number)
is
begin
    delete from memo_memo where idx=p_idx;
end;
/

insert into procedure_emp values (7369,'��ö��','���','2010-12-17',300);
insert into procedure_emp values (7499,'�̹μ�','�븮','2011-02-20',360);
insert into procedure_emp values (7521,'������','�븮','2012-02-22',425);
insert into procedure_emp values (7566,'�Ӽ���','����','2011-04-02',597);
insert into procedure_emp values (7654,'��ȣ��','�븮','2011-09-28',425);
insert into procedure_emp values (7698,'�ڼ�ȯ','����','2021-05-01',585);
insert into procedure_emp values (7782,'�ձ�ö','����','2021-06-09',545);
insert into procedure_emp values (7788,'�ڱ�ȣ','����','2007-04-17',600);
insert into procedure_emp values (7839,'��ö��','��ǥ','2011-11-17',900);
insert into procedure_emp values (7844,'�۸���','�븮','2011-09-08',450);
insert into procedure_emp values (7876,'Ȳ����','���','2017-05-23',310);
insert into procedure_emp values (7900,'�ڹ�ö','���','2011-12-03',395);
insert into procedure_emp values (7902,'����','����','2011-12-03',700);
insert into procedure_emp values (7934,'��ö��','���','2012-01-23',330);
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