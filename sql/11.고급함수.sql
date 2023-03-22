-- 1. nvl : null에 대한 대체값을 지정하는 함수
--  nvl(A,B) A의 값이 null이면 B, null이 아니면 A

-- 사원이름, 직책, 커미션(커미션이 null이면 sal의 3% 적용)
select ename, job, sal, comm, sal*0.03 커미션
from emp
where comm is null;

select ename, job, sal, comm, nvl(comm, sal*0.03) 커미션
from emp;

-- 사원이름, 직책, 연봉
select ename, job, sal, comm, sal*12 + comm 연봉
from emp;

select ename, job, sal, comm, sal*12 + nvl(comm,0) 연봉
from emp;

-- 2. decode(A, B, C, D) : A,B가 같으면 C, 다르면 D   

-- 커미션이 있는 직원은 5%를 적용하고 null인 직원은 3%를 적용하여 보너스 계산
select ename,deptno,comm, sal*decode(comm, null, 0.03,0.05)
from emp;

-- 급여가 400만원 이상이면 A등급, 300만원 이상이면 B등급, 200만원 이상이면 C등급, 100만원 이상이면 D등급, 100만원 미만이면 E등급
select ename, sal,
decode(trunc(sal/100), 0,'E',
                        1,'D',
                        2,'C',
                        3,'B',
                        'A') from emp;
                        
-- 성적
create table score (
    student_no varchar2(20) primary key,
    name varchar2(20) not null,
    kor number default 0,
    eng number default 0,
    mat number default 0
);

--레코드 입력
insert into score values ('1','kim',90,80,70);
insert into score values ('2','park',78,75,74);
insert into score values ('3','hong',99,89,79);
insert into score values ('4','choi',100,100,100);
insert into score values ('5','choi',100,100,99);

--round(실수값, 소수이하자리수)
select name, kor, eng, mat, (kor+eng+mat) 총점, 
    round((kor+eng+mat)/3,2) 평균, 
    decode(trunc(((kor+eng+mat)/3)/10), 10,'A', 9,'A',8,'B',7,'C',6,'D','F') 등급
from score;

-- 3. case : 복잡한 조건문을 처리할 때 사용하는 함수

-- 교수이름, 직위, 급여총액(pay+bonus) 계산
select pname, position,
    case when position='정교수' then (pay+nvl(bonus,0))*1.1 
        when position='부교수' then (pay+nvl(bonus,0))*1.07 
        when position='조교수' then (pay+nvl(bonus,0))*1.05 
        else pay+nvl(bonus,0)
    end 급여
from prof
order by 급여 desc;

-- 성적
select name, kor, eng, mat, kor+eng+mat 총점, 
    round((kor+eng+mat)/3,2) 평균, 
    case
        when (kor+eng+mat)/3 >= 90 then 'A'
        when (kor+eng+mat)/3 >= 80 then 'B'
        when (kor+eng+mat)/3 >= 70 then 'C'
        when (kor+eng+mat)/3 >= 60 then 'D'
        else 'F'
    end 등급
from score;

-- 4. rank : 순위를 구하는 함수
-- rank() over
-- dense_rank() over ? 동률 순위 무시
-- partition by ? 그룹에 대한 순위

-- 전체 사원의 부서번호, 이름, 급여, 급여순위
select deptno, ename, sal,
    rank() over(order by sal desc) 순위
from emp;

-- dense_rank() 동률 순위를 무시
select deptno, ename, sal,
    dense_rank() over(order by sal desc) 순위
from emp;

-- 전체 사원의 부서번호, 이름, 급여, 해당 부서별 순위
select deptno, ename, sal,
    rank() over(partition by deptno order by sal desc) 순위
from emp;