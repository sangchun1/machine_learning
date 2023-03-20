-- 테이블 생성
create table t_emp (
    id number not null,
    name varchar2(25),
    salary number(7,2),
    phone varchar2(15),
    dept_name varchar2(25)
);

-- 테이블명 수정 : rename ~ to ~
rename t_emp to s_emp;

-- 테이블에 데이터 입력
insert into s_emp values(100, '이정민', 3000,'010-222-3333', '개발팀'); 
insert into s_emp values(101, '최순철', 3600,'010-333-4444', '연구팀'); 
insert into s_emp values(102, '장혜숙', 4500,'010-444-5555', '영업팀'); 

-- 테이블에 컬럼 추가
alter table s_emp add hire_date date;

-- 컬럼 수정
alter table s_emp modify phone varchar2(50);

-- 컬럼의 이름 수정
alter table s_emp rename column id to t_id;

-- 컬럼의 삭제
alter table s_emp drop column dept_name;

-- insert, update, delete
-- 기존 레코드의 hire_date 수정
update s_emp set hire_date = sysdate where t_id = 100;
update s_emp set hire_date = sysdate where t_id = 101;
update s_emp set hire_date = sysdate where t_id = 102;

-- 새로운 레코드 추가
insert into s_emp (t_id,hire_date) values(40,sysdate);

-- 레코드 삭제
delete from s_emp where t_id=102;