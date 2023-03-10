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

insert into product values (1,'����',1500,'���� ���Ե� �������� �Ƿ�ȸ���� �����ϴ�. ��Ÿ�� C�� ǳ���մϴ�.','lemon.jpg');
insert into product values (2,'������',2000,'��Ÿ�� C�� ǳ���մϴ�. ������ �ֽ��� ���ø� �����ϴ�.','orange.jpg');
insert into product values (3,'Ű��',3000,'��Ÿ�� C�� �ſ� ǳ���մϴ�. ���̾�Ʈ�� �̿뿡 �����ϴ�.','kiwi.jpg');
insert into product values (4,'����',5000,'��������� �ٷ� �����ϰ� �־� �׻�ȭ �ۿ��� �մϴ�.','grape.jpg');
insert into product values (5,'����',8000,'��Ÿ�� C�� �ö󺸳��̵带 �ٷ� �����ϰ� �ֽ��ϴ�.','strawberry.jpg');
insert into product values (6,'��',7000,'�ó��Ǹ��� �����ϰ� �־� ���� ���濡 ���ٰ� �մϴ�.','tangerine.jpg');
commit;

select * from product;

drop table dep;
drop table dep cascade constraints;
create table dep(
id varchar2(10) primary key,
name varchar2(15) not null,
loc varchar2(50)
);

insert into dep values('10', '������', '����');
savepoint a;
insert into dep values('20', 'ȫ����', '�λ�');
savepoint b;
insert into dep values('30', '������', '��õ');
select * from dep;

rollback to a;
select * from dep;
rollback;
commit;