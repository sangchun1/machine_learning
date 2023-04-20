SHOW DATABASES;
CREATE DATABASE myweb;
USE myweb;
SELECT * FROM gs25;
SELECT * FROM temperature;

use myweb;
#테이블 2개
#text 타입을 varchar 500으로 변환,오래걸림
#약 270만여건
select count(*) from gs25;
select * from gs25 limit 10;
#서울특별시,인천광역시,경기도
select distinct sido from gs25;
#오래걸림(실행하지 않음)
select sido,count(*)
from gs25
group by sido;
#seoul, incheon, gyungi 변수 추가
alter table gs25 add seoul char(1) default '0';
update gs25 set seoul='1' where sido='서울특별시';
alter table gs25 add incheon char(1) default '0';
update gs25 set incheon='1' where sido='인천광역시';
alter table gs25 add gyungi char(1) default '0';
update gs25 set gyungi='1' where sido='경기도';
select * from gs25 limit 10;
select * from gs25 where sido='경기도' limit 10;
select * from gs25 where sido='인천광역시' limit 10;
#male, female 변수 추가
alter table gs25 add male char(1) default '0';
update gs25 set male='1' where gender='M';
alter table gs25 add female char(1) default '0';
update gs25 set female='1' where gender='F';
select * from gs25 where male='1' limit 10;
select * from gs25 where female='1' limit 10;
#연령대 00~19, 20~39, 40~59, 60~99
select distinct age from gs25;
alter table gs25 add age10 char(1) default '0';
update gs25 set age10='1' where age='00~19';
alter table gs25 add age2030 char(1) default '0';
update gs25 set age2030='1' where age='20~39';
alter table gs25 add age4050 char(1) default '0';
update gs25 set age4050='1' where age='40~59';
alter table gs25 add age60 char(1) default '0';
update gs25 set age60='1' where age='60~99';
select * from gs25 limit 10;
#12개 품목, 과자,라면,마스크,맥주,면도기,생리대,생수,숙취해소
제,스타킹,아이스크림,우산,탄산음료,
select distinct category from gs25 order by category;
#식료품
alter table gs25 add food char(1) default '0';
update gs25 set food='1' where category in ('과자','라면','아
이스크림');
#음료
alter table gs25 add drink char(1) default '0';
update gs25 set drink='1' where category in ('맥주','생수','탄
산음료');
#잡화
alter table gs25 add product char(1) default '0';
update gs25 set product='1' where category in ('마스크','면도
기','생리대','숙취해소제','스타킹','우산');
select * from gs25 limit 10;
#서울 25개구
select distinct gu from gs25 where seoul='1' order by gu;
#인천 10개구
select distinct gu from gs25 where incheon='1' order by gu;
#경기 26개시군구
select distinct gu from gs25 where gyungi='1' order by gu;
#온도 테이블
select * from temperature;
alter table temperature add gyungi char(1) default '0';
update temperature set gyungi='1' where pvn_nm='경기도';
alter table temperature add seoul char(1) default '0';
update temperature set seoul='1' where pvn_nm='서울특별시';
alter table temperature add incheon char(1) default '0';
update temperature set incheon='1' where pvn_nm='인천광역시';
#최종 명령어
select *
from gs25 g, temperature t
where g.tm= t.tm limit 10;
select
g.seoul,g.incheon,g.gyungi,male,female,age10,age2030,age4050,age60,food,drink,product,
max_ta,max_ws,min_ta,avg_ta,avg_rhm,avg_ws,sum_rn,amount
from gs25 g, temperature t
where g.tm= t.tm and g.sido=t.pvn_nm and g.gu=t.bor_nm
limit 10;
select * from temperature limit 10;
alter table gs25 add index gs25_tm (tm);
alter table gs25 add index gs25_gu (gu);
alter table temperature add index temperature_tm (tm);
alter table temperature add index temperature_gu (bor_nm);
select
g.seoul,g.incheon,g.gyungi,male,female,age10,age2030,age4050,age60,food,drink,product,
max_ta,max_ws,min_ta,avg_ta,avg_rhm,avg_ws,sum_rn,amount
from gs25 g, temperature t
where g.tm= t.tm and g.sido=t.pvn_nm and g.gu=t.bor_nm
limit 100;
select count(*)
from gs25 g, temperature t
where g.tm= t.tm and g.sido=t.pvn_nm and g.gu=t.bor_nm;
drop table mart1;
drop table mart2;
drop table mart3;
create table mart1 as
select
g.seoul,g.incheon,g.gyungi,male,female,age10,age2030,age4050,age60,food,drink,product,
max_ta,max_ws,min_ta,avg_ta,avg_rhm,avg_ws,sum_rn,amount
from gs25 g, temperature t
where g.tm= t.tm and g.sido=t.pvn_nm and g.gu=t.bor_nm
and g.sido='서울특별시'
limit 10000;
create table mart2 as
select
g.seoul,g.incheon,g.gyungi,male,female,age10,age2030,age4050,age60,food,drink,product,
max_ta,max_ws,min_ta,avg_ta,avg_rhm,avg_ws,sum_rn,amount
from gs25 g, temperature t
where g.tm= t.tm and g.sido=t.pvn_nm and g.gu=t.bor_nm
and g.sido='인천광역시'
limit 10000;
create table mart3 as
select
g.seoul,g.incheon,g.gyungi,male,female,age10,age2030,age4050,age60,food,drink,product,
max_ta,max_ws,min_ta,avg_ta,avg_rhm,avg_ws,sum_rn,amount
from gs25 g, temperature t
where g.tm= t.tm and g.sido=t.pvn_nm and g.gu=t.bor_nm
and g.sido='경기도'
limit 10000;
drop table mart;
create table mart as
select * from mart1
union all
select * from mart2
union all
select * from mart3;
#수량 평균 이상 이하로 추가
alter table mart add class char(1) default '0';
select avg(amount) from mart;
update mart set class='1' where amount>=92.7299;
#실행결과에서 우클릭, 격자행 내보내기 - delimited text 선택,
파일이름 지정
select * from mart;
#파일을 에디터로 열어서 \N을 0으로 바꾸어 저장