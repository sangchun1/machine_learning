--drop table emp;
CREATE TABLE emp ( 
  empno     number primary key, 
  ename     varchar2(50), 
  job       varchar2(50), 
  mgr       number, 
  hiredate  date default sysdate, 
  sal       number,
  comm      number, 
  deptno    number);

insert into emp values (7369,'이철수','사원',7902,'2010-12-17',300,null,20);
insert into emp values (7499,'이민수','대리',7698,'2011-02-20',360,300,30);
insert into emp values (7521,'박종수','대리',7698,'2012-02-22',425,500,30);
insert into emp values (7566,'임성민','팀장',7839,'2011-04-02',597,null,20);
insert into emp values (7654,'나호석','대리',7698,'2011-09-28',425,1400,30);
insert into emp values (7698,'박성환','팀장',7839,'2021-05-01',585,null,30);
insert into emp values (7782,'손기철','팀장',7839,'2021-06-09',545,null,10);
insert into emp values (7788,'박기호','부장',7566,'2007-04-17',600,null,20);
insert into emp values (7839,'김철수','대표',null,'2011-11-17',900,null,10);
insert into emp values (7844,'송명준','대리',7698,'2011-09-08',450,0,30);
insert into emp values (7876,'황선태','사원',7788,'2017-05-23',310,null,20);
insert into emp values (7900,'박민철','사원',7698,'2011-12-03',395,null,30);
insert into emp values (7902,'박희성','부장',7566,'2011-12-03',700,null,20);
insert into emp values (7934,'최철수','사원',7782,'2012-01-23',330,null,10);


--drop table dept;
CREATE TABLE dept (
  deptno   number primary key, 
  dname    varchar2(50));

insert into dept values (10,'교육팀');
insert into dept values (20,'홍보팀');
insert into dept values (30,'기획팀');
insert into dept values (40,'전산팀');




--drop table prof ;
create table prof(
 profno number primary key,
 pname  varchar2(10) not null, 
 position varchar2(20) not null,
 pay number(3) not null,
 hiredate  date not null,
 bonus number(4) ,
 majorno  number(3)
);

insert into prof
values(1001,'조재철','정교수',550,'2007-06-23',100,101);

insert into prof
values(1002,'박철호','부교수',380,'2016-01-30',60,101);

insert into prof
values (1003,'송기영','조교수',270,'2019-03-22',null,101);

insert into prof
values (2001,'양희선','조교수',250,'2017-09-01',null,102);

insert into prof
values (2002,'김영준','부교수',350,'2015-11-30',80,102);

insert into prof
values (2003,'주영호','정교수',490,'2008-04-29',90,102);

insert into prof
values (3001,'김대진','정교수',530,'2005-10-23',110,103);

insert into prof
values (3002,'나연수','조교수',330,'2018-07-01',50,103);

insert into prof
values (3003,'김현욱','조교수',290,'2019-02-24',null,103);

insert into prof
values (4001,'심상수','정교수',570,'2001-10-23',130,201);

insert into prof
values (4002,'최선영','조교수',330,'2019-08-30',null,201);

insert into prof
values (4003,'박원희','조교수',310,'2019-12-01',50,202);

insert into prof
values (4004,'차영철','조교수',260,'2019-01-28',null,202);

insert into prof
values (4005,'이지성','정교수',500,'2005-09-18',80,203);

insert into prof 
values (4006,'전민호','조교수',220,'2020-06-28',null,301);

insert into prof
values (4007,'허영선','부교수',290,'2011-05-23',30,301);

--drop table major ;
create table major
( majorno number(3) primary key ,
  mname varchar2(30) not null
);

insert into major values (101,'컴퓨터공학');

insert into major values (102,'데이터사이언스');

insert into major values (103,'소프트웨어공학');

insert into major values (201,'전자공학');

insert into major values (202,'기계공학');

insert into major values (203,'화학공학');

insert into major values (301,'문헌정보학');

--drop table stud ;
create table stud
( studno number primary key,
  sname   varchar2(10) not null,
  grade number ,
  majorno number,
  profno  number);

insert into stud values (201811,'서정욱',4,101,1001);

insert into stud values (201812,'이재수',4,102,2001);

insert into stud values (201813,'이민경',4,103,3002);

insert into stud values (201814,'김종욱',4,201,4001);

insert into stud values (201815,'박동수',4,202,4003);

insert into stud values (201911,'김선영',3,101,1002);

insert into stud values (201912,'신연경',3,102,2002);

insert into stud values (201913,'오누리',3,202,4003);

insert into stud values (201914,'구자영',3,301,4007);

insert into stud values (201915,'이세현',3,101,4001);

insert into stud values (202011,'송지선',2,101,1002);

insert into stud values (202012,'박진욱',2,102,2001);

insert into stud values (202013,'김광선',2,201,4002);

insert into stud values (202014,'이문호',2,201,4003);

insert into stud values (202015,'박정호',2,301,4007);

insert into stud values (202111,'최윤나',1,101,null);

insert into stud values (202112,'김은수',1,101,null);

insert into stud values (202113,'최영민',1,201,null);

insert into stud values (202114,'박주현',1,102,null);

insert into stud values (202115,'강영준',1,101,null);



commit;

select * from stud;
select * from major;
select * from emp;
select * from dept;
select * from prof;