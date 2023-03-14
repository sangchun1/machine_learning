CREATE DATABASE ontime;

SHOW DATABASES;

USE ontime;
CREATE TABLE ontime (
  Year INT,
  Month INT,
  DayofMonth INT,
  DayOfWeek INT,
  DepTime INT,
  CRSDepTime INT,
  ArrTime INT,
  CRSArrTime INT,
  UniqueCarrier VARCHAR(5),
  FlightNum INT,
  TailNum VARCHAR(8),
  ActualElapsedTime INT,
  CRSElapsedTime INT,
  AirTime INT,
  ArrDelay INT,
  DepDelay INT,
  Origin VARCHAR(3),
  Dest VARCHAR(3),
  Distance INT,
  TaxiIn INT,
  TaxiOut INT,
  Cancelled INT,
  CancellationCode VARCHAR(1),
  Diverted VARCHAR(1),
  CarrierDelay INT,
  WeatherDelay INT,
  NASDelay INT,
  SecurityDelay INT,
  LateAircraftDelay INT
);

SHOW TABLES;

# 평균출발지연시간
SELECT uniquecarrier, AVG(depdelay)
FROM ontime
GROUP BY uniquecarrier;

# 항공사별 도착 지연 시간 평균
select uniquecarrier, avg(arrdelay)
from ontime
group by uniquecarrier;


SELECT * FROM ozone;

# ozone 평균
SELECT AVG(Ozone) FROM ozone;

UPDATE ozone SET ozone=(42.12931034482759)
WHERE ozone IS NULL;

# solar.r 평균
SELECT AVG(`Solar.R`) FROM ozone;

UPDATE ozone SET `Solar.R`=(185.93150684931507)
WHERE `Solar.R` IS NULL;