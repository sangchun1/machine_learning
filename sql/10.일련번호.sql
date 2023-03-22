-- 일련변호
-- 시퀀스(sequence) : 일련번호를 만들어주는 객체

/* 시퀀스 생성:
create sequence 시퀀스이름
    start with 숫자
    increment by 숫자
    minvalue 숫자
    maxvalue 숫자
    cycle or nocycle    --일련번호 순환여부
    cache or nocache    --시퀀스의 값을 메모리에 저장
*/

delete from c_emp;

create sequence c_emp_seq
    start with 1
    increment by 1;

select c_emp_seq.nextval from dual; -- nextval = 다음 번호
select c_emp_seq.currval from dual; -- currval = 현재번호

-- 사용 예
insert into c_emp values(c_emp_seq.nextval, 'kim', 1000, '02-123-4567', 10);

-- 서브쿼리를 이용하는 방법
delete from c_emp;

select max(id)+1 from c_emp;

select nvl( max(id)+1, 1 ) from c_emp;

insert into c_emp values
    ((select nvl(max(id)+1,1) from c_emp) , 'park', 3000, '02-123-4567', 10);
    
-- 시퀀스 문제
/*
1. c_emp 테이블에 id를 입력하기 위한 sequence를 생성합니다.(300부터 시작하여 1씩 증가하고 최대값은 999)
*/
create sequence emp_seq
    start with 300
    increment by 1
    maxvalue 999;

/*
2. c_emp 테이블에 새로운 레코드를 입력합니다. 사번: 시퀀스로 입력, 이름: 김철수, 부서번호: 10번
*/
insert into c_emp(id, name, dept_id)
    values(emp_seq.nextval, 'kim', 10);