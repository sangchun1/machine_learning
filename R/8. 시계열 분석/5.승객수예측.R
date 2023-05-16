#시계열 관련 라이브러리
library(TTR)
library(forecast)
########################################
# 1949~1960 매월 항공기 탑승 승객수
ap<-AirPassengers
ap
########################################
#숫자형 자료를 시계열자료로 변환, time series
ap_ts <- ts(ap)
plot.ts(ap_ts)
#안정적인 시계열 자료가 아님 - 시간의 흐름에 따라 분산이 증가하는 추세임
########################################
#Seasonal, trend, remainder 요소로 분해한 그래프
#stl() 시계열 자료를 분해하는 함수
plot(stl(AirPassengers, s.window="periodic"))
########################################
#안정적인 시계열로 변환하는 작업(차분, 로그함수)
#시계열 데이터를 이동평균한 값을 생성
#안정적인 시계열 : 시간의 추이와 관계없이 평균,분산이 일정한 경우
#불안정적인 시계열 : 시계열을 안정적으로 변환한 후 분석 진행
ap_sma3 <- SMA(ap_ts, n=3)
plot.ts(ap_sma3)
########################################
#정상성(stationary) : 모든 시점에 평균이 일정한 특성
# 시간에 따라 확률적인 성분이 변하지 않는다는 가정, 정상성이 없으면 비시계열 자료로 분류됨
#차분(difference) : 현시점 자료에서 전시점 자료를 빼는 것
#평균이 일정하지 않은 시계열은 차분(difference)을 통해 정상화
#1차 차분을 통해 데이터를 정상화 하는 과정
ap_diff1 <- diff(ap_ts, differences = 1)
plot.ts(ap_diff1)
########################################
library(tseries)
#로그 후 차분한 자료를 adf.test 함수로 안정적인 시계열인지 확인하는 과정
adf.test(diff(log(ap_ts)), alternative="stationary", k=0)
#p-value가 0.05보다 작으므로 95% 신뢰수준 하에서 유의함(안정적인 시계열 자료임)
########################################
# ACF/PACF차트나 auto.arima 함수를 사용하여 최적화된 파라미터 도출
#ARIMA = AR + MA
auto.arima(ap_ts)
#가장 적절한 모형은 arima(4,1,2)
########################################
#arima(4,1,2)을 수행할 경우 arima(data, order=c(4,1,2))로 모형을 생성함
ap_arima <- arima(ap_ts, order = c(4,1,2)) # 차분을 통해 확인한 값 적용
#h 예측하고 싶은 수치
#미래예측함수
ap_fcast <- forecast(ap_arima, h = 5)
ap_fcast
plot(ap_fcast)
