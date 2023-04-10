# 배깅: 동일한 크기의 샘플을 복원 추출, 같은 알고리즘의 복수의 모형을 만드는 앙상블 방법론
# Bootstrap + Aggregate 의 합성어로 복수의 모델을 이용하는 앙상블 기법
# 장점: 과적합 감소, 단점: 학습과 예측시간이 오래 걸림
# 회귀문제는 평균으로, 분류문제는 다수결로 판단하여 최종결과를 산출함
#install.packages('adabag')
library(adabag)
# 학습용 데이터(무작위로 100개 추출)
train <- sample(1:150, 100)
# mfinal 모형의 개수, maxdepth 최대 깊이, minsplit 분기를 위한 최소 샘플수
iris.bagging <- bagging(Species ~ ., data = iris[train,], mfinal = 5, 
                        control = rpart.control(maxdepth = 5, minsplit = 5))
iris.bagging$trees # 개별 모형의 결과
#############################################################
# 첫번째 모형의 트리 그래프
library(rpart.plot)
rpart.plot(iris.bagging$trees[[1]])
# 검증용 데이터셋을 입력하여 분류
predict(iris.bagging, iris[-train,])$class
# 오분류표(confusion matrix) 작성
tbl <- table(iris$Species[-train], predict(iris.bagging, iris[-train,])$class)
# 정분류율, 오분류율 계산
rate1 <- sum(tbl[row(tbl) == col(tbl)])/sum(tbl) #정분류율
rate2 <- 1-rate1 #오분류율
rate1
rate2