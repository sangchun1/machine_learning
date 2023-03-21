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

-- 제약조건(constraint) : primary key, check, foreign key, unique, not null
-- 제약조건을 반영한 테이블 생성하기
create table c_emp(
    id number(5) constraint c_emp_id_pk primary key,
    name varchar2(25) ,
    salary number(7,2) constraint c_emp_salary_ck
        check(salary between 100 and 1000),
    phone varchar2(15) ,
    dept_id number(7) constraint c_emp_dept_id_fk
        references dept(deptno)
);

-- 제약조건 이름 검색
select contraint_name from user_constraints;

select * from user_constraints where table_name = 'C_EMP';

--  제약조건 추가
alter table c_emp add constraint c_emp_name_un unique(name);

-- not null 제약조건은 add로 할 수 없고 modify로 가능
alter table c_emp modify name varchar2(25) not null;

-- 제약조건의 삭제
alter table c_emp drop constraint c_emp_name_un;

-- 제약조건 실습소스
--primary key
--제약조건이 설정되지 않은 테이블
create table c_emp (
    id number,
    name varchar2(25),
    salary number,
    phone varchar2(15),
    dept_id number
);

insert into c_emp (id,name) values (1,'김철수'); 
insert into c_emp (id,name) values (1,'김기철'); 
delete from c_emp;
select * from c_emp;
--primary key 제약조건 추가
alter table c_emp add primary key(id);
--primary key 제약조건 삭제
alter table c_emp drop primary key;
--제약조건 이름 지정
alter table c_emp add constraint c_emp_id_pk primary key(id);
--사용자가 만든 제약조건 조회
select * from user_constraints where table_name='C_EMP';
insert into c_emp (id,name) values (1,'김철수'); 
insert into c_emp (id,name) values (1,'김기철'); -- "무결성 제약 조건(PYTHON.C_EMP_ID_PK)에 위배됩니다"

--테이블 제거
drop table c_emp;
--제약조건 이름 추가
create table c_emp (
    id number primary key,
    name varchar2(25),
    salary number,
    phone varchar2(15),
    dept_id number
);
select * from user_constraints where table_name='C_EMP';
insert into c_emp (id,name) values (1,'김철수'); 
insert into c_emp (id,name) values (1,'김기철'); -- "무결성 제약 조건(PYTHON.SYS_C007323)에 위배됩니다"

--2. check 제약조건
drop table c_emp;
create table c_emp (
    id number(5),
    name varchar2(25),
    salary number(7,2) constraint c_emp_salary_ck
        check(salary between 100 and 1000),
    phone varchar2(15),
    dept_id number(7)
);
insert into c_emp (id,name,salary) values (1,'kim',500);
insert into c_emp (id,name,salary) values (2,'park',1500); -- "체크 제약조건(PYTHON.C_EMP_SALARY_CK)이 위배되었습니다"

--3. Foreign key 제약조건(왜래키, 다른 테이블의 PK를 참조)
--테이블 제거
drop table c_emp;
--제약조건 추가
create table c_emp (
    id number primary key,
    name varchar2(25),
    salary number,
    phone varchar2(15),
    dept_id number,
    foreign key(dept_id) references dept(deptno)
);
insert into c_emp (id,name,dept_id) values (1,'kim',10);
insert into c_emp (id,name,dept_id) values (2,'park',20);
insert into c_emp (id,name,dept_id) values (3,'park',50); -- "무결성 제약조건(PYTHON.SYS_C007326)이 위배되었습니다- 부모 키가 없습니다"

--4. unique 제약조건
-- primary key : unique(중복안됨) + not null(필수입력)  
-- 테이블 제거
drop table c_emp;

create table c_emp (
    id number,
    name varchar2(25),
    salary number,
    phone varchar2(15),
    dept_id number,
    constraint c_emp_name_un unique(name)
);
insert into c_emp (id,name) values (1,'kim');
insert into c_emp (id,name) values (2,'kim'); -- "무결성 제약 조건(PYTHON.C_EMP_NAME_UN)에 위배됩니다"

select * from user_constraints where table_name='C_EMP';

insert into c_emp (id) values (3); -- null 입력 가능
insert into c_emp (id) values (4);
select * from c_emp;

--제약조건 삭제
--alter table 테이블 drop constraint 제약조건이름
alter table c_emp drop constraint c_emp_name_un;

insert into c_emp (name) values ('kim');
insert into c_emp (name) values ('kim');
insert into c_emp (name) values ('kim');
select * from c_emp;