# 데이터를 R로 로딩
flour <- c( 3, -2, -1, 0, 1, -2)  # 밀가루 사용
diet <- c(-4, 1, -3, -5, -2, -8)  # 다이어트약 사용
total <- c(flour, diet)           # 12명의 데이터
# 히스토그램
#win.graph()
hist(total)

#ann=F 축의 라벨을 표시하지 않음
#density() 확률밀도 그래프
#win.graph()
plot(density(flour), xlim=c(-8,8), ylim=c(0,0.2), lty=1, ann=F)
par(new=T) # 2개의 그래프를 하나에 출력
plot(density(diet), xlim=c(-8,8), ylim=c(0,0.2), lty=2)
legend(4, 0.2, c("flour", "diet"), lty=1:2, ncol=1) # 범례  

# 밀도 그래프(density)
# 히스토그램은 막대 구간의 너비에 따라 모양이 달라질 수 있음
# 밀도 그래프는 막대의 너비를 가정하지 않고 모든 점에서 데이터의 밀도를 추정하는
# 커널 밀도 추정kernel density estimation 방식을 사용하여 이러한 문제를 보완함
# density(커널밀도를 추정할 데이터)
# rug(숫자벡터) : 그래프의 x축에 데이터를 1차원으로 표시

#win.graph()
plot(density(iris$Sepal.Width))

# 히스토그램 위에 밀도 그래프를 선으로 표시할 수 있음
#win.graph()
hist(iris$Sepal.Width, freq=F)
lines(density(iris$Sepal.Width))

# 밀도 그래프에 rug() 함수를 이용하여 실제 데이터의 위치를 x축 위에 표시한 그래프
# jitter() 데이터의 중첩
#win.graph()
plot(density(iris$Sepal.Width))
rug(jitter(iris$Sepal.Width))

# Jitter : 같은 값을 가지는 데이터가 같은 좌표에 겹쳐서 표시되지 않도록
# 데이터에 약간의 노이즈를 추가하는 방법

iris$Sepal.Width
jitter(iris$Sepal.Width)

# 박스플롯
boxplot(flour, diet, names=c("flour","diet"))

# 기초 통계량 계산
# 합계
sum(total)
# quantile 분위수
quantile(total)
# 0%    25%   50%   75%   100%
# -8.00 –3.25 -2.00 0.25  3.00
fivenum(total) # min, 1Q, median, 3Q, max
# fivenum과 quantile 계산 방식이 다름
# -8.0 -3.5 -2.0 0.5 3.0
cor(flour, diet) # 상관계수

summary(total)

#################################################################################

# 커피 판매량 데이터
cafe <- read.csv('c:/data/cafe/data.csv')
# 자료 정렬
sort(cafe$Coffees)

# 1) 최대, 최소값

# 정렬된 값 중 첫번째 값
sort(cafe$Coffees)[1]
# 내림차순 정렬
sort(cafe$Coffees, decreasing = TRUE)
# 내림차순 정렬된 값 중 첫번째 값
sort(cafe$Coffees, decreasing = TRUE)[1]
# 최소값
min( cafe$Coffees )
# 최대값
max( cafe$Coffees )
# 하루 주문량은 3~48잔임을 알 수 있음

# 2) 최빈값(mode) : 가장 많이 관찰된 값, 가장 빈도가 높은 값

# seq(0,50,by=10) 0~50까지 10씩 증가
# right=F : 마지막 값은 선택하지 않음
table(cut(cafe$Coffees, breaks=seq(0, 50, by=10), right=F))
# 0~9잔: 9, 10~19잔: 8, 20~29잔: 17, 30~39잔: 11, 40~49잔: 2

ca <- cafe$Coffees
stem(ca)
# 줄기-잎 그림: 자료를 순서대로 나열한 후 적당한 단위로 나눠 줄기 부분을 만들고 각 값을 줄기
# 부분에 붙인 그림

ca
# 각 진도별 빈도수가 출력됨 = 3잔은 1회, 4잔은 4회
table(ca)
max(table(ca))
# 최빈값은 4임을 알 수 있다.

# 3) 평균값
ca <- cafe$Coffees
# 평균값 계산
mean(ca)

# ca 변숭 결측값 덧붙임(NA = Not Available
ca <- c(ca, NA)
tail(ca, n=5)
# 결측값이 있으므로 평균값이 계산되지 않음
mean( ca )
# 결측값을 제외하고 평균 계산
mean( ca, na.rm=T )

# 4) 중앙값, 중위수(median) - 자료 전체의 중심 위치값

ca <- cafe$Coffees
ca

# 오름차순 정렬
sort(ca)

# 중앙값
median( ca )

# 분산, 표준편차
height <- c(164, 166, 168, 170, 172, 174, 176)
# 평균값
mean(height)
# 중앙값
median(height)
# 편차(deviation) : 개별 관찰값과 평균과의 차이
# 편차값을 모두 더하면 0이 되므로 의미가 없고 제곱을 해야 한다.
height.dev <- height - mean(height)
height.dev
sum(height.dev)

# 분산(variance, 편차 제곱의 평균)
var( height )

# 표준편차
sd( height )

coffee <- cafe$Coffees
juice <- cafe$Juices

# 커피 판매량 평균값
( coffee.m <- mean( coffee ) )
# 커피 판매량의 표준편차
( coffee.sd <- sd( coffee ) )
# 스 판매량 평균값
( juice.m <- mean( juice ) )
# 쥬스 판매량의 표준편차
( juice.sd <- sd( juice ) )

# 커피 판매량의 변동계수
( coffee.cv <- round( coffee.sd / coffee.m, 3) )

# 쥬스 판매량의 변동계수(표준편차를 평균으로 나눈 값)
( juice.cv <- round( juice.sd / juice.m, 3) )

#표준편차값을 보면 커피가 훨씬 크지만 변동계수를 볼 때 쥬스가 더
#크다. 즉, 쥬스 판매량의 변동폭이 더 크다는 것을 알 수 있다.

# 6) 사분위수 범위와 상자도표

quantile(coffee)
# 25%가 되는 값(제1사분위수, Q1) 12, 50%가 되는 값(제2사분위수,Q2) 23, 
# 75%가 되는 값(제3사분위수, Q3) 30, 100%가 되는 값(제4사분위수, Q4)

# 사분위수 범위(InterQuartile Range, Q3 - Q1)
IQR(coffee)

boxplot(coffee, main="커피 판매량에 대한 상자도표")
# 상자의 아랫변 Q1, 상자중앙의 굵은 선 Q2, 상자의 윗변 Q3

d <- matrix(c(coffee,juice), 47, 2)
d
#win.graph()
boxplot(d,names=c('coffee','juice'))

boxplot(coffee, juice, names=c('커피판매량','주스판매량'))