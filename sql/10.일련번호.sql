-- �Ϸú�ȣ
-- ������(sequence) : �Ϸù�ȣ�� ������ִ� ��ü

/* ������ ����:
create sequence �������̸�
    start with ����
    increment by ����
    minvalue ����
    maxvalue ����
    cycle or nocycle    --�Ϸù�ȣ ��ȯ����
    cache or nocache    --�������� ���� �޸𸮿� ����
*/

delete from c_emp;

create sequence c_emp_seq
    start with 1
    increment by 1;

select c_emp_seq.nextval from dual; -- nextval = ���� ��ȣ
select c_emp_seq.currval from dual; -- currval = �����ȣ

-- ��� ��
insert into c_emp values(c_emp_seq.nextval, 'kim', 1000, '02-123-4567', 10);

-- ���������� �̿��ϴ� ���
delete from c_emp;

select max(id)+1 from c_emp;

select nvl( max(id)+1, 1 ) from c_emp;

insert into c_emp values
    ((select nvl(max(id)+1,1) from c_emp) , 'park', 3000, '02-123-4567', 10);
    
-- ������ ����
/*
1. c_emp ���̺� id�� �Է��ϱ� ���� sequence�� �����մϴ�.(300���� �����Ͽ� 1�� �����ϰ� �ִ밪�� 999)
*/
create sequence emp_seq
    start with 300
    increment by 1
    maxvalue 999;

/*
2. c_emp ���̺� ���ο� ���ڵ带 �Է��մϴ�. ���: �������� �Է�, �̸�: ��ö��, �μ���ȣ: 10��
*/
insert into c_emp(id, name, dept_id)
    values(emp_seq.nextval, 'kim', 10);