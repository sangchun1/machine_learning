# 1) 결측값 처리----------------------------------------------------------------

df <- read.csv("c:/data/ozone/ozone.csv")
head(df)
# 결측값 여부 확인
is.na(df)

# 특정 필드의 결측값 확인
is.na(df$Ozone)

# Ozone 필드에 결측값이 있는 행
df[is.na(df$Ozone),]

# 결측값의 개수
sum(is.na(df))

# 특정 필드의 결측값 개수
sum(is.na(df$Ozone))

# 각 샘플의 모든 필드가 NA가 아닐 때 TRUE
# 샘플에 결측값이 하나라도 있으면 FALSE
complete.cases(df)

# 결측값이 없는 샘플 출력
df[complete.cases(df),]

# 결측값이 있는 샘플 출력
df[!complete.cases(df),]

# 결측값이 있으므로 계산이 안됨
mean(df$Ozone)

# 결측값을 제외하고 계산
mean(df$Ozone, na.rm = T)
# 1~2번 필드의 중위수 계산
mapply(median, df[1:2], na.rm=T)

# 결측값을 제외
df2 <- na.omit(df)
df2

# 결측값을 0으로 대체
df3 <- df
df3[is.na(df)] <- 0
df3

# 특정한 필드만 0으로 대체
df4 <- df
df4$Ozone[is.na(df4$Ozone)] <- 0
df4

# 결측값을 평균값으로 대체
df5 <- df
m1 <- mean(df[,1], na.rm = T)
m2 <- mean(df[,2], na.rm = T)
df5[,1][is.na(df[,1])] <- m1
df5[,2][is.na(df[,2])] <- m2
df5

# 결측값 시각화 패키지
#install.packages('VIM')
#install.packages('mice')
library(VIM)
library(mice)

#win.graph()
md.pattern(df)
# Ozone 필드에만 결측값이 있는 샘플 35개
# Solar.R 필드에만 결측값이 있는 샘플 5개
# 2개 필드에 결측값이 있는 샘플 2개

# 결측값의 개수 표시
#win.graph()
# prop=T 백분율로 표시, prop=F 샘플개수로 표시
aggr(df, prop = F, numbers = T)

# 결측값의 위치를 시각적으로 표현(red: 결측값, dark: 빈도수가 높은 값)
#win.graph()
matrixplot(df)

# 2) 스케일링-------------------------------------------------------------------

df <- read.csv("c:/data/rides/rides.csv")
head(df)

# 범주형 변수는 팩터 자료형으로 변환 후 스케일링 수행
df$weekend <- as.factor(df$weekend)
df$weekend

#install.packages("reshape")
library(reshape)
# melt() 필드 1개를 variable,value 로 여러 행으로 만드는 함수(차원변경)
meltData <- melt(df[2:7])
#win.graph()
boxplot(data=meltData, value~variable)

# 평균 0, 표준편차 1로 만드는 작업
# 스케일링: 표준편차를 1로 만드는 작업
# 센터링: 평균을 0으로 만드는 작업
# 정규화된 데이터를 data.frame형태로 변경
df_scaled <- as.data.frame(scale(df[2:7])) #스케일링과 센터링
df_scaled

meltData <- melt(df_scaled)
#win.graph()
boxplot(data=meltData, value~variable)

# caret 패키지(Classification And Regression Training):분류,
#   회귀 문제를 풀기 위한 다양한 도구 제공
#install.packages('caret')
library(caret)

df <- read.csv("c:/data/rides/rides.csv")

meltData <- melt(df[2:7])
#win.graph()
boxplot(data=meltData, value~variable)

# 평균 0, 표준편차 1로 스케일링
prep <- preProcess(df[2:7], c("center", "scale"))
df_scaled2 <- predict(prep, df[2:7])
head(df_scaled2)

meltData <- melt(df_scaled2)
#win.graph()
boxplot(data=meltData, value~variable)

# range: 0~1 정규화
prep <- preProcess(df[2:7], c("range"))
df_scaled3 <- predict(prep, df[2:7])
head(df_scaled3)

meltData <- melt(df_scaled3)
#win.graph()
boxplot(data=meltData, value~variable)

# 3) 이상치 처리----------------------------------------------------------------

df <- read.csv("c:/data/rides/rides.csv")
head(df)
#install.packages('car')
library(car)
# 회귀분석 모형
model <- lm(overall~num.child + distance + rides + games +
            wait + clean, data=df)
summary(model)
# 설명력 68.27%

# 1. 아웃라이어
# 잔차가 2배 이상 크거나 2배 이하로 작은 경우
outlierTest(model)
# 이상치 데이터 발견 - 184번 샘플(Bonferonni p value가 0.05보다 작은 값)
# rstudent - Studentized Residual - 잔차를 잔차의 표준편차로 나눈 값
# unadjusted p-value : 다중 비교 문제가 있는 p-value
# 본페로니 p - 여러 개의 가설 검정을 수행할 때 다중 비교 문제로 인해 귀무가설을 기각하게 될
# 확률이 높아지는 문제를 교정한 p-value

# 184번 샘플을 제거한 모형
model2 <- lm(overall~num.child + distance + rides + games +
             wait + clean, data=df[-184,])
model2
summary(model2)
# 설명력이 68.27% => 68.76%로 개선됨

# 2. 영향 관측치(influential observation) : 모형의 인수들에 불균형한 영향을 미치는 관측치
# 영향 관측치를 제거하면 더 좋은 모형이 될 수 있음
# Cook's distance(레버리지와 잔차의 크기를 종합하여 영향력을 판단하는 지표)를 이용하여
# 영향 관측치를 찾을 수 있음
# 레버리지(leverage) : 실제값이 예측값에 미치는 영향을 나타낸 값
# x축: Hat-Values(큰 값은 지렛점)
# y축: Studentized Residuals(표준화 잔차) : 잔차를 표준오차로 나눈 값
#win.graph()
influencePlot(model)
# 184,103,227,367,373
# 2보다 큰 값, -2보다 작은 값들은 2배 이상 떨어져있는 이상치)
# 레버리지와 잔차의 크기가 모두 큰 데이터들은 큰 원으로 표현(영향력이 큰 데이터들)
# 184,103,227,367,373

model3 = lm(overall~num.child + distance + rides + games +
            wait + clean, data=df[c(-184,-103,-367,-373),])
model3
summary(model3)
# 설명력 69.48%