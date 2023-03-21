-- groupby : 특정한 컬럼을 기준으로 집계된 데이터를 보기 위한 명령어
--  (select절의 컬럼은 집계함수를 제외하고 모두 group by절에 명시해야 함)
-- emp 테이블에서 부서코드별로 급여정보 출력
select deptno, count(*), sum(sal), avg(sal), min(sal), max(sal)
from emp
group by deptno
order by dpetno;

select e.deptno, dname, count(*), sum(sal), avg(sal), min(sal), max(sal)
from emp e, dept d
where e.deptno = d.deptno
group by e.deptno, dname
order by deptno;

-- 전공코드별로 교수들의 평균 급여
select majorno, round(avg(pay),2)
from prof
group by majorno
order by majorno;

select p.majorno, mname, round(avg(pay),2)
from prof p, major m
where p.majorno = m.majorno
group by p.majorno, mname
order by p.majorno;

-- 전공코드별, 직급별 평균 급여
select majorno, position, round(avg(pay),2)
from prof
group by majorno, position
order by majorno, position;

-- having : group by의 결과 중에서 조건에 맞는 행을 선택하기 위한 명령어
-- 교수의 평균 급여가 450 이상인 전공과 평균급여 출력
select mname, round(avg(pay),2)
from prof p, major m
where p.majorno = m.majorno
group by mname
having avg(pay) >= 450;

-- 실습문제
select * from stud;
select * from major;
select * from prof;
/*
1. stud 테이블과 major 테이블을 조인한 후 전공코드별로 집계하여 전공코드, 전공이름, 학생수를 출력하시오.
*/
select s.majorno, mname, count(*)
from stud s, major m
where s.majorno = m.majorno
group by s.majorno, mname;

/*
2. 지도교수사번, 지도교수이름, 지도학생수를 출력하시오.(stud 테이블과 prof 테이블을 조인하여 지도교수 사번별로 집계)
*/
select p.profno, pname, count(*)
from prof p, stud s
where p.profno = s.profno
group by p.profno, pname;

/*
3. 교수 중에서 급여총액(급여+ 보너스)이 가장 높은교수와 가장 낮은 교수, 급여총액의 평균금액을 출력하시오.(전공코드별로 집계)
*/
select majorno, max(pay+nvl(bonus,0)), min(pay+nvl(bonus,0)), round(avg(pay+nvl(bonus,0)),2)
from prof
group by majorno;