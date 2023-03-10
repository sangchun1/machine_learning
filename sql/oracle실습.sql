drop table product;
drop table product cascade constraints;
create table product (
product_id number, 
product_name varchar2(50),
price number default 0,
description clob,
picture_url varchar2(500),
primary key(product_id)
);

insert into product values (1,'레몬',1500,'레몬에 포함된 구연산은 피로회복에 좋습니다. 비타민 C도 풍부합니다.','lemon.jpg');
insert into product values (2,'오렌지',2000,'비타민 C가 풍부합니다. 생과일 주스로 마시면 좋습니다.','orange.jpg');
insert into product values (3,'키위',3000,'비타민 C가 매우 풍부합니다. 다이어트나 미용에 좋습니다.','kiwi.jpg');
insert into product values (4,'포도',5000,'폴리페놀을 다량 함유하고 있어 항산화 작용을 합니다.','grape.jpg');
insert into product values (5,'딸기',8000,'비타민 C나 플라보노이드를 다량 함유하고 있습니다.','strawberry.jpg');
insert into product values (6,'귤',7000,'시네피린을 함유하고 있어 감기 예방에 좋다고 합니다.','tangerine.jpg');
commit;

select * from product;

drop table dep;
drop table dep cascade constraints;
create table dep(
id varchar2(10) primary key,
name varchar2(15) not null,
loc varchar2(50)
);

insert into dep values('10', '영업팀', '서울');
savepoint a;
insert into dep values('20', '홍보팀', '부산');
savepoint b;
insert into dep values('30', '연구팀', '인천');
select * from dep;

rollback to a;
select * from dep;
rollback;
commit;