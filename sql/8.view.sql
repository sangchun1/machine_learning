-- View : 테이블에 대한 가상의 테이블
-- View 생성 및 변경 : create or replace view 뷰이름 as select 명령어
create or replace view emp_v
as
    select empno, ename, job, sal, deptno
    from emp;

select * from emp_v;

-- View 삭제 : drop view 뷰이름
drop view emp_v;

-- 실습예제
--뷰 생성 및 변경
create or replace view test_v
as
    select empno, ename, e.deptno, dname
    from emp e, dept d
    where e.deptno = d.deptno; 

--생성된 뷰는 테이블처럼 사용 가능
select * from test_v; 

-- 테이블, 뷰 목록 확인
select * from tab;
--뷰의 세부 정보 확인(데이터 사전)
select * from user_views;