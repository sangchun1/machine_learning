# 부스팅: 미리 정해진 개수의 모형을 사용하지 않고
# 하나의 모형에서 시작하여 개별 모형을 하나씩 추가하는 방법
# 다수결 방법이 아닌 개별 모형의 출력에 가중치를 조합한 값을 판별함수로 사용
#install.packages('gbm')
library(MASS)
library(gbm)
set.seed(1)
train <- sample(1:nrow(Boston),nrow(Boston)/2)
# 부스팅 모형, 트리개수 100개
boost.boston <- gbm(medv ~ ., data = Boston[train,], n.trees = 100)
# 변수의 영향력 그래프
summary(boost.boston)
#############################################################
# 가장 영향력이 큰 변수 2개
# rm : 방의 수, 양의 상관관계
plot(boost.boston, i = "rm")
#lstat : 인구 중 하위 계층 비율, 음의 상관관계
plot(boost.boston, i = "lstat")
#############################################################
boston.test <- Boston[-train, "medv"]
# 검증용 데이터셋을 입력하여 얻은 예측값
pred <- predict(boost.boston, newdata = Boston[-train,], n.trees = 100)
mean((pred-boston.test)^2)
# 오차 약 22000달러