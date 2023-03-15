# 실습1---------------------------------------------------------------------------------------

# 20명의 신장과 체중 데이터
height <- c(179,166,175,172,173,167,169,172,172,179,161,174,166,176,182,175,177,167,176,177)
weight <- c(113,84,99,103,102,83,85,113,84,99,51,90,77,112,150,128,133,85,112,85)
plot(height, weight)

# 상관계수 계산
cor(height, weight)

# 기울기와 절편
slope <- cor(height, weight) * (sd(weight) / sd(height))
intercept <- mean(weight) - (slope * mean(height))
slope
intercept

# 단순회귀분석 모델 생성
# 체중 = 기울기x신장 + 절편
df <- data.frame(height, weight)
df

model <- lm(weight ~ height, data=df)
# 절편(Intercept) -478.816
# 기울기 3.347
model

# 키가 180인 사람의 체중 예측
model$coefficients[[2]]*180 + model$coefficients[[1]]

summary(model)

plot(height, weight)
abline(model, col='red')

weight

pred <- model$coefficients[[2]]*height + model$coefficients[[1]]
pred

sum(weight - pred) # 오차의 합계는 0

err <- (weight - pred)^2

sum(err) # 오차의 제곱합

sum(err/length(weight)) # 평균제곱오차(MSE, mean squared error)
# 비용함수(cost function) : 평균제곱오차를 구하는 함수

# 최적의 가중치(기울기)를 구하기 위한 계산(경사하강법, Gradient Descent)
# 여기서는 전체의 값이 아닌 1개의 값만 계산
x <- height[1]
y <- weight[1]
w <- seq(-1, 2.3, by=0.0001) # 가중치, by 간격
#w <- seq(-1, 2.3, by=0.1) #가중치, by 간격
pred <- x*w # 예측값
err <- (y-pred)^2 # 제곱오차
plot(err)
# 기울기가 증가하면 오차가 증가하고 기울기가 감소하면 오차가 감소한다
# 기울기가 0에 가까운 값이 최적의 기울기가 된다.
min(err) # 최소오차
i <- which.min(err)
paste('최적의 기울기=', w[i])

# 최적의 편향(절편)을 구하기 위한 계산
x <- height[1]
y <- weight[1]
w <- 0.6313 # 가중치
b <- seq(-3.2, 3.2, by=0.0001) # 편향
#b <- seq(-3.2, 3.2, by=0.1) # 편향
pred <- x*w + b # 예측값
err <- (y-pred)^2 # 제곱오차
plot(err)
# 기울기가 증가하면 오차가 증가하고 기울기가 감소하면 오차가 감소한다
# 기울기가 0에 가까운 값이 최적의 기울기가 된다.
min(err) # 최소오차
i <- which.min(err)
i
paste('최적의 편향=', b[i])

# 위의 계산을 통해 얻은 최적의 w, b를 적용한 회귀식
x <- height[1]
y <- weight[1]
w <- 0.6313
b <- -0.00269999999999992
pred <- x*w + b
y
pred

# 실습2---------------------------------------------------------------------------------------

regression <- read.csv("c:/data/regression/regression.csv", fileEncoding = 'utf-8')
head(regression)
tail(regression)

summary(regression)
hist(regression$height)
hist(regression$weight)

plot(regression$weight ~ regression$height, main="평균키와 몸무게", xlab="Height", 
     ylab="Weight")

cor(regression$height, regression$weight)

# lm( y ~ x ) x 독립변수, y 종속변수 (x가 한단위 증가할 때 y에게 미치는 영향)
r <- lm(regression$weight ~ regression$height)
plot(regression$weight ~ regression$height, main="평균키와 무게", xlab="Height", 
     ylab="Weight")
abline(r,col='red')

# 키가 180인 사람의 체중 예측
r$coefficients[[2]]*180 + r$coefficients[[1]]

summary(r)

# 실습3---------------------------------------------------------------------------------------

# 월별 전기생산금액(억원)
X <- c(3.52, 2.58, 3.31, 4.07, 4.62, 3.98, 4.29, 4.83, 3.71, 4.61, 3.90, 3.20)
# 월별 전기 사용량(백만kwh)
y <- c(2.48, 2.27, 2.47, 2.77, 2.98, 3.05, 3.18, 3.46, 3.03, 3.25, 2.67, 2.53)
plot(X,y)

# 상관계수 계간
cor(X,y)

# 단순회귀분석 모델 생성
# 전기소비량 = 기울기x전기생산량 + 절편
model <- lm(y ~ X)
# 절편(Intercept) 0.9196
# 기울기 0.4956
model

summary(model)
# Adjusted R-squared: 0.777 (모형의 설명력 77.7%)
# p-value가 0.05보다 작으므로 통계적으로 유의한 회귀모형

# 산점도
plot(X, y, main="전기생산량과 전기소비량", xlab="전기생산량", ylab="전기소비량")
# 회귀선
abline(model,col="red")

# 전기생산량이 4일 때의 전기소비량 예측
model$coefficients[[2]]*4 + model$coefficients[[1]]