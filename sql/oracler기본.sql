-- 기본형식
select * from emp order by empno;

-- distinct / all
/*
distinct: 중복된 데이터를 허용하지 않음
all: 중복된 데이터를 허용함
*/
select job from emp;
select all job from emp;
select distinct job from emp;

-- order by: 정렬 - asc, desc
select * from emp order by sal desc;

select * from emp
order by job, sal desc;

-- alis : 별칭
select ename 이름, job 직급, sal 급여
from emp
order by job, sal desc;

-- where : 검색 조건
select * from emp
where sal > 100 and sal < 400
order by sal desc;

-- 연산자의 종류
/*
산술연산자 : + , - , *, /
비교연산자 : = , != , > , > = , < , < =
논리연산자 : and, or, not
기타연산자: in, all, between, like, is null, is not null
*/
select ename, sal, deptno from emp
where deptno in (10, 20, 40);

select ename, sal, deptno from emp
where deptno = 10 or deptno = 20 or deptno = 40;

select ename, sal, deptno from emp
where deptno != 30;

select ename, sal from emp
where sal between 300 and 500;

select ename, sal from emp
where sal >= 300 and sal <= 500;

select ename from emp where ename like '박%';

select ename from emp where ename like '%성%';

select ename from emp where comm = null;
select ename from emp where comm is null;

select ename, comm from emp where comm != null;
select ename, comm from emp where comm is not null;

-- 결합연산자 : ||
select ename || '의 급여는 ' || sal || '입니다' from emp;

-- 연산자의 우선순위
/*
1순위: 비교연산자, SQL연산자, 산술연산자
2순위: not
3순위: and
4순위: or
괄호( ): 연산자 우선순위보다 우선함
*/
select empno, sal from emp
where not(sal > 200 and sal < 300)
order by sal;

select empno, sal from emp
where sal < = 200 or sal > = 300
order by sal;

select empno, sal from emp
where not sal > 200 and sal < 300
order by sal;

-- 실습문제
select * from emp;
/*
1. emp 테이블에서 입사일(hiredate)이 2015년 1월1일 이전인 
사원에 대해 사원의 이름(ename), 입사일, 부서번호(deptno)를 출력하시오.
*/

select ename 이름, hiredate 입사일, deptno 부서번호 from emp
where hiredate < '15/01/01'
order by hiredate;

/*
2. emp 테이블에서 부서번호가 20번이나 30번인 부서에 속한 
사원들에 대하여 이름, 직업코드(job), 부서번호를 출력하시오.
*/
select ename 이름, job 직업코드, deptno 부서번호 from emp
where deptno in (20, 30)
order by ename;