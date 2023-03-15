##############################################################################################

# R에 기본적으로 포함되는 데이터셋 목록
data()
# 데이터셋에 대한 도움말
# help(데이터셋이름)
help(attitude)

head(attitude)
tail(attitude)

# 다중회귀분석 모델 생성
model <- lm(rating ~ ., data = attitude)
model

# 분석결과 요약
summary(model)
# complaints, learning이 기여도가 높은 변수
# p-value가 0.05보다 작으므로 통계적으로 유의함
# 모델의 설명력(예측의 정확성) 66%

# 기여도가 낮은 항목을 제거함으로써 의미있는 회귀식을 구성하는 과정
reduced <- step(model, direction="backward")
# 최종적으로 complaints와 learning 2가지 변수 외에는 제거됨

# 최종결과 확인
summary(reduced)
# p-value가 0.05보다 작으므로 이 회귀모델은 통계적으로 유의함.
# 모델의 설명력(신뢰도,예측정확성) : 68%

##############################################################################################

# 다중공선성(Multicollinearity) : 독립변수끼리 강한 상관관계를 가지는 현상

# 다중공선성을 파악하기 위한 수치적 지표
# VIF(Variance Inflation Factor, 분산팽창인자)
# VIFi= 1 / ( 1 - R^2i)

library(car)

# 미국 미니애폴리스 지역의 총인구,백인비율,흑인비율,외국태생, 가계소득,
# 빈곤,대학졸업비율을 추정한 데이터셋
df <- MplsDemo
head(df)

# 독립적인 그래픽창에 그래프 출력
#win.graph()
plot(df[,-1])
# 독립변수들의 상관계수
cor(df[,2:7])

#install.packages('corrplot')
library(corrplot)
#win.graph()
corrplot(cor(df[,2:7]), method = "number")
# white 변수의 경우 다른 변수들과 상관관계가 높음(다중공선성이 의심됨)

model1 <- lm(collegeGrad ~ .-neighborhood, data=df)
summary(model1)
# 설명력은 81.86%로 좋은 모형이지만
# black(흑인비율), foreignBorn(외국태생) 변수의 회귀계수가 양수로 출력됨
# 실제 현상을 잘 설명하지 못하는 모형

# 다중공선성에 대해 확인이 필요한 경우
# 1. p-value가 유의하지 않은 경우
# 2. 회귀계수의 부호가 예상과 다른 경우
# 3. 데이터를 추가,제거시 회귀계수가 많이 변하는 경우

model <- lm(population ~ .-collegeGrad-neighborhood, data=df)
# ^{-1} -1승 중괄호를 안써도 됨
print(paste("population의 VIF : ", (1-summary(model)$r.squared)^{-1}))

# 다중공선성이 매우 높은 변수
model <- lm(white~.-collegeGrad-neighborhood,data=df)
print(paste("white의 VIF : ", (1-summary(model)$r.squared)^{-1}))

model <- lm(black~.-collegeGrad-neighborhood,data=df)
print(paste("black VIF의 : ", (1-summary(model)$r.squared)^{-1}))

model <- lm(foreignBorn~.-collegeGrad-neighborhood,data=df)
print(paste("foreignBorn의 VIF : ", (1-summary(model)$r.squared)^{-1}))

model <- lm(hhIncome~.-collegeGrad-neighborhood,data=df)
print(paste("hhIncome의 VIF : ", (1-summary(model)$r.squared)^{-1}))

model <- lm(poverty~.-collegeGrad-neighborhood,data=df)
print(paste("poverty의 VIF : ", (1-summary(model)$r.squared)^{-1}))

# 다중공선성을 계산해주는 함수
vif(model1)
# 다중공선성이 높은 white 변수 제거

model2 <- lm(collegeGrad~.-neighborhood-white,data=df)
summary(model2)
vif(model2)
# vif 수치가 많이 낮아졌고 특히 black의 수치도 많이 낮아졌음

##############################################################################################

# 종속변수
#   1978년 보스턴의 주택 가격
#   506개 타운의 주택 가격 중앙값 (단위 1,000 달러)
# 독립변수
#   CRIM: 범죄율
#   INDUS: 비소매상업지역 면적 비율
#   NOX: 일산화질소 농도
#   RM: 주택당 방 수
#   LSTAT: 인구 중 하위 계층 비율
#   B: 인구 중 흑인 비율
#   PTRATIO: 학생/교사 비율
#   ZN: 25,000 평방피트를 초과하는 거주 지역의 비율
#   CHAS: 찰스강의 경계에 위치한 경우는 1, 아니면 0
#   AGE: 1940년 이전에 건축된 주택의 비율
#   RAD: 고속도로까지의 거리
#   DIS: 고용지원센터의 거리
#   TAX: 재산세율

library(MASS)
head(Boston)
tail(Boston)

dim(Boston)

summary(Boston)

# 산점도 행렬
pairs(Boston)
plot(medv~crim, data=Boston, main="범죄율과 주택가격과의 관계", 
     xlab="범죄율", ylab="주택가격")

# 범죄율과의 상관계수 행렬
(corrmatrix <- cor(Boston)[1,]) # 첫번째 변수
# 범죄율이 높으면 주택가격이 떨어진다.

# 강한 양의 상관관계, 강한 음의 상관관계
corrmatrix[corrmatrix > 0.5 | corrmatrix < -0.5]

# 세율과의 상관계수 행렬
(corrmatrix <- cor(Boston)[10,])
# 세율이 높으면 주택가격이 떨어진다.

# 강한 양의 상관관계, 강한 음의 상관관계
corrmatrix[corrmatrix > 0.5 | corrmatrix < -0.5]

# CHAS: 찰스강의 경계에 위치한 경우는 1, 아니면 0
table(Boston$chas)

# 최고가로 팔린 주택들
(selftown <- Boston[Boston$medv == max(Boston$medv),])

# 최저가로 팔린 주택들
(seltown <- Boston[Boston$medv == min(Boston$medv),])

# 다중회귀분석 모델 생성
(model <- lm(medv ~ ., data = Boston))

# 분석결과 요약
summary(model)
# p-value가 0.05보다 작으므로 통계적으로 유의함
# 모델의 설명력(예측의 정확성) 73.3%

# 전진선택법과 후진제거법
# 후진제거법: 기여도가 낮은 항목을 제거함으로써 의미있는 회귀식을 구성하는 과정
reduced <- step(model, direction="backward")
# 최종적으로 선택된 변수들 확인

# 최종 결과 확인
summary(reduced)
# p-value가 0.05보다 작으므로 이 회귀모델은 통계적으로 유의함.
# 모델의 설명력(신뢰도,예측정확성) : 73.4%

#install.packages('olsrr')
library(olsrr)

# 전진선택법
#model2<-ols_step_forward_p(model)
model2 <- ols_step_forward_p(model,details=TRUE)
model2

# 후진제거법
model3 <- ols_step_backward_p(model,details=TRUE)
model3

##############################################################################################

df <- read.csv("c:/data/house_regress/data.csv")
head(df)
tail(df)

library(dplyr)
# Suburb, Address, Type, Method, SellerG, Date, CouncilArea, Regionname 필드 제거
df <- df %>% select(-Suburb, -Address, -Type, -Method, -SellerG, -Date, 
                    -CouncilArea, -Regionname)

dim(df)

# 결측값이 있는 행을 제거
df <- na.omit(df)
tail(df)

dim(df)

summary(df)

# 상관계수 행렬
(corrmatrix <- cor(df))

# 강한 양의 상관관계, 강한 음의 상관관계
corrmatrix[corrmatrix > 0.5 | corrmatrix < -0.5]

#install.packages("corrplot")
library(corrplot)
corrplot(cor(df), method="circle")

# 다중회귀분석 모델 생성
model <- lm(Price ~ ., data = df )
model

# 분석결과 요약
summary(model)
# p-value가 0.05보다 작으므로 통계적으로 유의함
# 모델의 설명력(예측의 정확성) : 0.4975

# 전진선택법과 후진제거법
# 후진제거법:기여도가 낮은 항목을 제거함으로써 의미있는 회귀식을 구성하는 과정
reduced <- step(model, direction="backward")
# 최종적으로 선택된 변수들 확인

# 최종 결과 확인
summary(reduced)
# p-value가 0.05보다 작으므로 이 회귀모델은 통계적으로 유의함.
# 모델의 설명력(신뢰도,예측정확성) : 0.4974

##############################################################################################

# 놀이동산 만족도

df <- read.csv("c:/data/rides/rides.csv")
head(df)
tail(df)

library(dplyr)
# 필드 제거
df <- df %>% select(-weekend)

head(df)

dim(df)

summary(df)

cor(df)

# 상관계수 행렬
(corrmatrix <- cor(df))

# 강한 양의 상관관계, 강한 음의 상관관계
corrmatrix[corrmatrix > 0.5 | corrmatrix < -0.5]

library(corrplot)
corrplot(cor(df), method="circle")

# 다중회귀분석 모델 생성
(model <- lm(overall ~ ., data = df))

# 분석결과 요약
summary(model)
# p-value가 0.05보다 작으므로 통계적으로 유의함
# 모델의 설명력(예측의 정확성) 0.6789

# 전진선택법과 후진제거법
# 후진제거법:기여도가 낮은 항목을 제거함으로써 의미있는 회귀식을 구성하는 과정
reduced <- step(model, direction="backward")
# 최종적으로 선택된 변수들 확인

# 최종 결과 확인
summary(reduced)
# p-value가 0.05보다 작으므로 이 회귀모델은 통계적으로 유의함.
# 모델의 설명력(신뢰도,예측정확성) : 0.6789

##############################################################################################

# 회귀분석 모형 저장, 불러오기

df <- read.csv("c:/data/rides/rides.csv")
head(df)

model<-lm(overall~num.child + distance + rides + games + wait + clean, data=df)
summary(model)

save(model, file="c:/data/R/rides_regress.model")

rm(list=ls()) # 현재 작업중인 모든 변수들을 제거

load("c:/data/R/rides_regress.model")

ls()

summary(model)