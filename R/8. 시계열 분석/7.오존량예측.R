df<-read.csv('c:/data/ozone/ozone2.csv')
head(df)
dim(df)
########################################
library(TTR)
library(forecast)
########################################
#숫자형 자료를 시계열자료로 변환, time series
ozone_ts <- ts(df[1])
plot.ts(ozone_ts)
########################################
#시계열 데이터를 이동평균한 값을 생성합니다.
#안정적인 시계열:시간의 추이와 관계없이 평균,분산이 일정한 경우
#불안정적인 시계열=>차분을 통해 시계열을 안정적으로 변환한 후 분석 진행
ozone_sma3 <- SMA(ozone_ts, n=3)
plot.ts(ozone_sma3)
########################################
#정상성(stationary) : 모든 시점에 평균이 일정한 특성
# 시간에 따라 확률적인 성분이 변하지 않는다는 가정, 정상성이 없으면 비시계열 자료로 분류됨
#차분(difference) : 현시점 자료에서 전시점 자료를 빼는 것
#평균이 일정하지 않은 시계열은 차분(difference)을 통해 정상화
#1차 차분을 통해 데이터를 정상화 하는 과정
ozone_diff1 <- diff(ozone_ts, differences = 1)
plot.ts(ozone_diff1)
########################################
library(tseries)
#로그 후 차분한 자료를 adf.test 함수로 안정적인 시계열인지 확인하는 과정
adf.test(diff(log(ozone_ts)), alternative="stationary", k=0)
#p-value가 0.05보다 작으므로 95% 신뢰수준 하에서 유의함(안정적인 시계열 자료임)
########################################
#가장 적절한 arima 모델을 추천해주는 함수
auto.arima(ozone_ts)
#가장 적절한 모형은 arima(1,1,1)
########################################
#arima(1,1,1)을 수행할 경우 arima(data, order=c(1,1,1))로 모형을 생성함
ozone_arima <- arima(ozone_ts, order = c(1,1,1)) # 차분을 통해 확인한 값 적용
#미래예측함수
ozone_fcast <- forecast(ozone_arima, h = 5)
ozone_fcast
plot(ozone_fcast)
########################################
# acf, pacf 함수를 사용하는 경우
acf(ozone_ts, lag.max = 20) # 6
pacf(ozone_ts, lag.max = 20) # 3
ozone_arima2<- arima(ozone_ts, order=c(6,1,3))
ozone_fcast<- forecast(ozone_arima2, h=5)
plot(ozone_fcast)