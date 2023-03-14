CREATE DATABASE web;

USE web;

-- varchar 자료형은 한글이 깨질 수 있으므로 nvarchar 자료형 (유니코드 가변문자열)을 사용함
CREATE TABLE product (
product_id INT,
product_name NVARCHAR(50),
price INT DEFAULT 0,
description NVARCHAR(4000),
picture_url NVARCHAR(500),
PRIMARY KEY(product_id)
);

-- 테이블에 값 채워넣기
INSERT INTO product VALUES (1, '레몬', 1500, '레몬에 포함된 구연산은 피로회복에 좋습니다. 비타민 C도 풍부합니다.', 'lemon.jpg');
INSERT INTO product VALUES (2, '오렌지', 2000, '비타민 C가 풍부합니다. 생과일 주스로 마시면 좋습니다.', 'orange.jpg');
INSERT INTO product VALUES (3, '키위', 3000, '비타민 C가 매우 풍부합니다. 다이어트나 미용에 좋습니다.', 'kiwi.jpg');
INSERT INTO product VALUES (4, '포도', 5000, '폴리페놀을 다량 함유하고 있어 항산화 작용을 합니다.', 'grape.jpg');
INSERT INTO product VALUES (5, '딸기', 8000, '비타민 C나 플라보노이드를 다량 함유하고 있습니다.', 'strawberry.jpg');
INSERT INTO product VALUES (6, '귤', 7000, '시네피린을 함유하고 있어 감기 예방에 좋다고 합니다.', 'tangerine.jpg');

SELECT * FROM product;

-- 항공운항데이터 실습

--ontime 테이블은 SQL Management로 불러옴
SELECT * FROM ontime; -- 시간 오래 걸림

--NA 값을 0으로 수정
UPDATE ontime SET depdelay=0 WHERE depdelay='NA';
UPDATE ontime SET arrdelay=0 where arrdelay='NA';

--인덱스 만들기
CREATE INDEX year ON ontime(year);
CREATE INDEX month ON ontime(year,month);
CREATE INDEX day ON ontime(year, month, dayofmonth);
CREATE INDEX dayofweek ON ontime(dayofweek);
CREATE INDEX distance ON ontime(distance);
CREATE INDEX uniquecarrier ON ontime(uniquecarrier);
CREATE INDEX origin ON ontime(origin);
CREATE INDEX dest ON ontime(dest);

--carriers 테이블은 SQL Management로 불러옴
SELECT * FROM carriers;

--인덱스 추가
CREATE INDEX carrier_code ON carriers(code);

--항공사별 출발지연시간 평균
SELECT uniquecarrier, AVG(CAST(depdelay AS INT))
FROM ontime
GROUP BY uniquecarrier;

--항공사 이름이 나오도록 join
SELECT YEAR, uniquecarrier, description, COUNT(arrdelay)
FROM ontime a, carriers c
WHERE a.uniquecarrier=REPLACE(c.code, '"', '') AND arrdelay > 0
GROUP BY YEAR, uniquecarrier, description
ORDER BY YEAR, uniquecarrier, description;