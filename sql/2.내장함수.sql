-- 집계함수
/* count(), sum(), avg(), max(), min() */
select count(*) from emp;
select count(empno) from emp;
--null 제외하고 카운트
select count(comm) from emp;
select sum(sal) from emp;
select max(sal) from emp;
select min(sal) from emp;
select avg(sal) from emp;
select round(avg(sal),1) from emp;
select count(*),sum(sal),max(sal),min(sal),avg(sal) from emp;

-- 문자함수
-- concat( '문자열1', '문자열2')
select concat(ename, '의 직급은 '), job from emp;

select ename || '의 직급은 ' || job from emp;

-- replace( '문자열1', '문자열2', '문자열3')
select replace('java program', 'java', '자바') from dual;

-- substr( '문자열', 자리수, 글자수)
select substr('java program', 4, 3) from dual;

select ename from emp where substr(ename, 2, 1) = '철';

-- 날짜 함수
-- sysdate
select sysdate from dual;

-- add_months(날짜데이터, 숫자)
select add_months(sysdate, 3) from dual;
select add_months('2021/01/26', 3) from dual;
select add_months('2021/01/26', -3) from dual;
select hiredate, add_months(hiredate, 3) from emp
where hiredate between '2010/01/01' and '2020/12/31';

select sysdate + 100 from dual;
select sysdate - 100 from dual;

-- months between(날짜1, 날짜2)
select months_between('2021/05/25', '2021/01/05') from dual;

select ename, hiredate, months_between(sysdate, hiredate) 근무개월수 from emp;

-- to_char(날짜컬럼 or 날짜데이터, '출력형식')
/*
d: 요일코드(1~7)
day: 요일 문자열
dd: 1~31일
mm: 01~12월
yy: 두자리 연도
yyyy: 네자리 연도
hh: 1~12 시간제
hh24 : 24시간제
mi: 분
ss: 초
am,pm: 오전, 오후
*/
select to_char(sysdate, 'yyyy-mm-dd am hh:mi:ss day') from dual;

-- to_date( '날짜 형태의 문자열', '날짜 변환 포맷')
select to_date('2018-01-26', 'yyyy- mm- dd') from dual;

-- 숫자함수
-- 숫자변환 함수: to_number( '숫자 형태의 문자열')
--내부적으로 to_number()가 호출됨
select '100'+ 1 from dual;
select to_number('100')+ 1 from dual; 

-- trunc(숫자, 자리수) : 지정된 자리수 이하의 소수를 버림
select ename, trunc((sysdate- hiredate)/365) 근속연수 from emp; 

-- round(숫자, 자리수) : 반올림
select round(10.555555, 2) from dual;

-- ceil(숫자) : 올림
select ceil(10.1) from dual;

-- 조건검사 함수
-- nvl(컬럼, 대체값)
select pname, pay, bonus, pay*12 + bonus 연봉
from prof
where majorno= 101;

select pname, pay, bonus, pay*12 + nvl(bonus,0) 연봉
from prof
where majorno= 101;

-- decode(A, B, A == B일때의 값, A != B일때의 값)
select pname, majorno, decode(majorno, 101, '컴퓨터공학') 전공명
from prof;

-- 실습
select * from emp;
/*
1. 직원의 이름, 직급, 급여를 출력하시오.(월급이 300 이상인 직원만 출력합니다.)
*/
select ename 이름, job 직급, sal 급여 from emp
where sal >= 300
order by sal desc;

select ename || ' ' || job || '의 급여는 ' || sal || '입니다.' 급여설명 
from emp
where sal >= 300
order by sal desc;

/*
2. 직원의 이름과 근무개월수를 출력하시오.(근무개월수가 100개월 이상인 직원만 출력합니다.)
*/
select ename 이름, round(months_between(sysdate, hiredate)) 근무개월수 from emp
where months_between(sysdate, hiredate) > 100
order by 근무개월수 desc, 이름;

/*
3. 직원의 이름과 직급, 총 근무주(week)수를 출력하시오. (근무주수 내림차순, 근무주수가 같으면 이름에 대하여 오름차순 정렬합니다.)
*/
select ename 이름, job 직급, round((sysdate-hiredate)/7) "총 근무주"
from emp
order by "총 근무주" desc, 이름;
