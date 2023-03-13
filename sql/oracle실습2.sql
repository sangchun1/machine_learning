-- 테스트
select * from tab;

-- python에서 만든 테이블 확인
select * from iris;
desc iris;

-- 항공운항 테이블 생성
create table ontime (
  Year int,
  Month int,
  DayofMonth int,
  DayOfWeek int,
  DepTime  varchar(50),
  CRSDepTime int,
  ArrTime varchar(50),
  CRSArrTime int,
  UniqueCarrier varchar(5),
  FlightNum varchar(50),
  TailNum varchar(8),
  ActualElapsedTime varchar(50),
  CRSElapsedTime varchar(50),
  AirTime varchar(50),
  ArrDelay varchar(50),
  DepDelay varchar(50),
  Origin varchar(3),
  Dest varchar(3),
  Distance varchar(50),
  TaxiIn varchar(50),
  TaxiOut varchar(50),
  Cancelled varchar(50),
  CancellationCode varchar(1),
  Diverted varchar(1),
  CarrierDelay varchar(50),
  WeatherDelay varchar(50),
  NASDelay varchar(50),
  SecurityDelay varchar(50),
  LateAircraftDelay varchar(50)
);

-- ontime.ctl로 만든 테이블 확인
select * from ontime;

-- index 생성
create index year on ontime(year);
create index month on ontime(year,month);
create index day on ontime(year, month, dayofmonth);
create index dayofweek on ontime(dayofweek);
create index distance on ontime(distance);
create index uniquecarrier on ontime(uniquecarrier);
create index origin on ontime(origin);
create index dest on ontime(dest);

-- 탐색
select count(*) from ontime
where year=2007 and month=1 and dayofmonth=1;

-- 항공사 테이블 생성
create table carrier(
code varchar2(100),
description varchar2(500)
);

-- carrier.ctl로 만든 테이블 확인
select * from carrier;

-- index 생성
create index carrier_code on carrier(code);

-- 결측값 추가
update ontime set depdelay=0 where depdelay='NA';
commit;

-- 항공사별 출발지연시간 평균
select uniquecarrier, avg(depdelay)
from ontime
group by uniquecarrier;

-- 항공사 이름이 나오도록 join
update ontime set arrdelay=0 where arrdelay='NA';
commit;

-- 시간대별(10월, 월요일에 출발할 때 가장 좋은 시간대는?)
select a.year, a.uniquecarrier, c.description, count(*)
from ontime a, carrier c
where a.uniquecarrier = c.code and a.arrdelay>0
group by a.year, a.uniquecarrier, c.description
order by a.year, a.uniquecarrier, c.description;

-- 항공사별 출발 지연 시간 평균
select uniquecarrier, round(avg(depdelay),1)
from ontime
group by uniquecarrier;

-- 항공사별 도착 지연 시간 평균
select uniquecarrier, round(avg(arrdelay),1)
from ontime
group by uniquecarrier;

select * 
from (
    select rownum as rn, A.*
    from (
        select CRSDepTime, avg(arrdelay) arrdelay
        from ontime
        where month=10 and dayofweek = 1
        group by CRSDepTime
        order by arrdelay
    ) A
) where rn between 1 and 5