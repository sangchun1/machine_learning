#데이터베이스 생성
create database pyweb;

use pyweb;

#페이지나누기를 위한 저장 프로시저 작성
DELIMITER $$
drop procedure if exists loopInsert$$

create procedure loopInsert()
begin
	declare i int default 1;
	delete from board_board;
	while i <= 991 do
		insert into board_board (IDX, writer, TITLE,	CONTENT, hit, post_date,filesize,down)
		values (i, concat('kim',i), concat('제목',i), concat('내용 ',i),0,now(),0,0);
		set i = i + 1;
	END while;
END$$

DELIMITER $$

call loopInsert

select * from board_board;