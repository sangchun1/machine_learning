-- 인덱스 : 대량의 레코드가 저장된 테이블의 데이터를 빠르게 검색할 수 있도록 지원해주는 객체

-- 인덱스 생성 : create index 인덱스명 on 테이블명 (컬럼명);   
--   (primary key 는 인덱스가 자동으로 생성됨)
create index c_emp_name_idx on c_emp(name);

-- 인덱스 삭제 : drop index 인덱스명; 
drop index c_emp_name_idx;

-- 인덱스 실습
--parsing(명령어 분석) -> 실행계획 수립(옵티마이저) -> 실행
--sql developer : F10(실행계획 보기)
--full scan 모든 레코드를 검사
--인덱스를 사용한 검사(by index rowid)
--index unique scan : 유일한 값
--index range scan : 유일하지 않은 값
select empno,ename from emp where empno=7900;
select empno,ename from emp where ename='박민철'; 

--인덱스 추가
create index emp_ename_idx on emp(ename);
-- 인덱스를 사용하여 검색
select empno,ename from emp where ename='박민철'; 
--인덱스 제거
drop index emp_ename_idx;

--인덱스 테스트를 위한 테이블 생성
create table emp3 (
    no number,
    name varchar2(10),
    sal number
);

-- PL/SQL (Procedural Language)
-- 테스트용 레코드 10만건 입력
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

--인덱스를 사용하지 않을 경우 : table access full, cost:104
select * from emp3 where name='shin691' and sal > 200;

--인덱스 추가
create index emp_name_idx on emp3(name,sal);

--index range scan, cost:11
select * from emp3 where name='shin691' and sal > 200;

--인덱스 정보 확인
-- unique index : primary key, unique 제약조건 컬럼에 적용
-- nonunique index
select * from user_indexes where table_name='EMP3';

-- 복합인덱스는 and 연산에서는 사용 가능, or 연산에서는 사용하지 않음
select * from emp3 where name like 'park1111%' and sal> 300;
select * from emp3 where name like 'park1111%' or sal> 300;

--primary key는 인덱스가 자동으로 생성됨
create table emp4 (
    no number primary key,
    name varchar2(10),
    sal number
);

select * from user_indexes where table_name='EMP4';

--no 컬럼에 primary key 설정
alter table emp3 add constraint emp3_no_pk primary key(no);
select * from user_indexes where table_name='EMP3';

--인덱스를 사용할 경우 자동 정렬
select * from emp3 where no>90000;

--primary key 제약조건 제거 (인덱스 제거)
alter table emp3 drop constraint emp3_no_pk;
select * from user_indexes where table_name='EMP3';

--인덱스를 사용하지 않을 경우 자동 정렬이 되지 않음
select * from emp3 where no>90000;