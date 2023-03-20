-- stud, major 테이블을 조인하여 이름, 학과코드, 학과이름을 출력하시오.
select sname, s.majorno, mname
from stud s, major m
where s.majorno = m.majorno;

-- emp 테이블의 사원번호와 dept 테이블의 부서명을 조인하여 출력하시오.
select empno, ename, dname
from emp e, dept d
where e.deptno = d.deptno;

-- 학생, 학과, 교수 테이블을 조인하여 학생이름, 학과이름, 지도교수이름을 출력하시오
select sname, mname, pname
from stud s, major m, prof p
where s.majorno = m.majorno and s.profno=p.profno;

-- self join : 참조해야 할 컬럼이 자신의 테이블에 있는 다른 컬럼인 경우에 사용하는 조인
select a.empno 사번, a.ename 이름, b.empno 매니저사번, b.ename 매니저
from emp a, emp b
where a.mgr = b.empno;

-- outer join: 한쪽 테이블에만 자료가 있을 경우에 출력되도록 하려면 외부 조인을 해야 함
select sname, pname
from stud s, prof p
where s.profno= p.profno;

select sname, pname
from stud s left outer join prof p
    on s.profno= p.profno;

select sname, s.majorno, pname
from stud s, prof p
where s.profno = p.profno(+);


-- ANSI 조인
select empno , dname
from emp e inner join dept d
    on e.deptno = d.deptno;

-- left outer join
select sname, s.majorno, pname
from stud s left outer join prof p
    on s.profno = p.profno;
 
select sname, s.majorno, pname
from stud s, prof p
where s.profno = p.profno(+);

-- right outer join
select sname, s.majorno, pname
from stud s right outer join prof p
    on s.profno = p.profno;
    
select sname, s.majorno, pname
from stud s, prof p
where s.profno(+) = p.profno;

-- full outer join
select sname, s.majorno, pname
from stud s left outer join prof p
    on s.profno = p.profno
union all

select sname, s.majorno, pname
from stud s right outer join prof p
    on s.profno = p.profno;
    
-- 실습예제
-- 테이블 조인 예베(상품테이블, 판매테이블)
-- 1. 상품테이블( 상품코드, 상품명, 단가, 제조사, 제조일자 )
drop table product;
create table product (
product_code varchar2(20) not null primary key,
product_name varchar2(50) not null,
price number default 0,
company varchar2(50),
make_date date default sysdate
);

insert into product values ('A1', '아이폰', 900000, '애플', '2017-03-01');
insert into product values ('A2', '갤럭시노트', 1000000, '삼성', '2017-08-01');
insert into product values ('A3', '갤럭시탭', 1200000, '삼성', '2017-10-01');

select * from product;

-- 2. 판매 테이블(상품코드, 판매수량)
create table product_sales (
product_code varchar2(20) not null,
amount number default 0
);

insert into product_sales values ('A1', 100);
insert into product_sales values ('A2', 200);
insert into product_sales values ('A3', 300);

select * from product_sales;

-- 상품테이블과 판매테이블을 조인
-- 상품코드, 상품이름, 제조사, 단가, 수량, 금액
select p.product_code, product_name, price, company, amount, price*amount money, make_date
from product p, product_sales s
where p.product_code = s.product_code;

-- ANSI join
select p.product_code, product_name, price, company, amount, price*amount money, make_date
from product p inner join product_sales s
    on p.product_code = s.product_code;

-- View(뷰, 가상테이블)
create or replace view product_sales_v
as
select p.product_code, product_name, price, company, amount, price*amount money, make_date
from product p, product_sales s
where p.product_code = s.product_code; 

-- 뷰를 테이블처럼 활용 가능
select * from product_sales_v
where company='삼성';

-- 실습문제
select * from emp;
select * from dept;
/*
1. emp와 dept 테이블을 조인하여 사원이름, 부서명, 급여를 출력하시오.
*/
select ename 사원이름, dname 부서명, sal 급여
from emp e, dept d
where e.deptno = d.deptno;

/* 
2. 직급이 ‘사원’인 사원이름, 부서명을 출력하시오.
*/
select ename 사원이름, dname 부서명
from emp e join dept d
    on e.deptno = d.deptno
where job = '사원';

/* 
3. 이름이 ‘손기철’인 사원의 부서명을 출력하시오.
*/
select dname 부서명
from emp e join dept d
    on e.deptno = d.deptno
where ename = '손기철';

/* 
4. emp테이블에 있는 empno, mgr을 이용하여 서로의 관계를 다음과 같이 출력하시오. “박종수의 매니저는 박성환이다”
*/
select a.ename || '의 매니저는 ' || b.ename || '이다' 관계
from emp a, emp b
where a.mgr = b.empno;