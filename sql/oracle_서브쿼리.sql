-- 메인 쿼리와 독립적인 서브쿼리
-- 월급을 가장 적게 받는 사원
select min(sal) from emp;

select * from emp
where sal = 300;

select * from emp
where sal = (select min(sal) from emp);

-- 사원들의 평균 월급보다 많은 급여를 받는 사원이름, 부서명, 급여
select (avg) from emp;

select ename, dname, sal
from emp e, dept d
where e.deptno = d.deptno
    and sal > (select avg(sal from emp);

-- 기획팀 직원들의 (부서코드:30) 최고급여보다 높은 월급을 받는 사원이름, 부서이름, 급여
select max(sal) from emp
where deptno = 30;

select ename, dname
from emp e, dept d
where e.deptno = d.deptno
    and sal > (select max(sal) from emp where deptno = 30);
    
-- 메인쿼리와 연관성이 있는 서브쿼리
-- 사원이름, 부서코드, 부서명
--  (조인으로 처리한 경우)
select ename, e.deptno, dname
from emp e, dept d
where e.deptno = d.deptno;

--  (서브쿼리로 처리한 경우)
select ename, deptno,
    (select dname from dept where deptno = e.deptno) dname
from emp e;

-- 사원이 근무하는 부서의 평균 급여보다 적은 급여를 받는 직원이름, 급여, 부서번호

-- 4. 인라인 뷰(inline view) : from절에 위치한 서브쿼리
--평균금액보다는 높고 최고금액보다는 낮은 월급을 받는 사원들
select empno, ename, sal, round(e2.avgs) e2.maxs
from emp, 
    select avg(sal) avgs, max(sal) maxs from emp) e2
where sal > e2.avgs and sal < e2.maxs
order by sal desc;

-- 직급(job)이 "사원"인 사람들의 사원명, 직급, 부서명
select ename, job, dname
from
    (select ename, job, deptno form emp where job = '사원') e,
    dept d
where e.deptno = d.deptno;

-- scalar 서브쿼리 : 한개의 행, 한개의 컬럼을 반환하는 서브쿼리 
-- 사원 이름, 급여, 소속 부서의 평균급여
select ename, sal,
    (select avg(sal) from emp) avg_sal,
    (select avg(sal) from emp
        where deptno = e.deptno) dept_avg_sal
from emp e;

-- 실습문제
/*
1. 조재철 교수보다 나중에 입사한 교수명, 입사일, 전공명을 출력하시오.
*/
select pname, hiredate, mname
from prof p, major m
where p.majorno = m.majorno
    and hiredate > (select hiredate from prof where pname='조재철');

/*
2. 심상수 교수보다 나중에 입사한 교수 중에서 박철호 교수보다 월급을 적게 받는 교수명, 급여, 입사일을 출력하시오.
*/
select pname, pay, hiredate
from prof
where hiredate > (select hiredate from prof where pname='심상수')
    and pay < (select pay from prof where pname='박철호');