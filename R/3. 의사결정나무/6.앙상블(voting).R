# 다수결 voting
# 의사결정나무의 단점:
#   과적합 문제
#   샘플이 적을 경우 샘플링에 의해 모형의 예측력이 크게 변하는 불안정성
# 앙상블 기법: 주어진 자료로 여러 개의 예측 모델을 만들어 조합하여 하나의 최종 예측 모델을 만드는 방법
#   bootstrap : raw data 에서 랜덤 복원추출을 통해 만든 동일한 크기의 자료들
#   voting : 여러 개의 모델로부터 산출된 결과를 합쳐 다수결에 의해 최종 결과로 선택
#install.packages('party')
library(party)
# bootstrap data 생성
data_boot1 <- iris[sample(1:nrow(iris), replace = T), ]
data_boot2 <- iris[sample(1:nrow(iris), replace = T), ]
data_boot3 <- iris[sample(1:nrow(iris), replace = T), ]
data_boot4 <- iris[sample(1:nrow(iris), replace = T), ]
data_boot5 <- iris[sample(1:nrow(iris), replace = T), ]
#############################################################
# Modeling
tree1 <- ctree(Species ~ ., data_boot1)
tree2 <- ctree(Species ~ ., data_boot2)
tree3 <- ctree(Species ~ ., data_boot3)
tree4 <- ctree(Species ~ ., data_boot4)
tree5 <- ctree(Species ~ ., data_boot5)
plot(tree1)
#############################################################
pred1 <- predict(tree1, iris)
pred2 <- predict(tree2, iris)
pred3 <- predict(tree3, iris)
pred4 <- predict(tree4, iris)
pred5 <- predict(tree5, iris)
#############################################################
# 각각의 예측 결과를 취합
test <- data.frame(Species = iris$Species, pred1, pred2, pred3, pred4, pred5)
head(test)
#############################################################
# 5개 모형의 결과를 취합하여 최종 결과를 voting
myfunc <- function(x) {
  result <- NULL
  for (i in 1:nrow(x)) {
    xtab <- table(t(x[i, ]))
    print(xtab)
    # versicolr 1 / virginica 4 라면 다수결로 virginica로 채택
    rvalue <- names(sort(xtab, decreasing = T)[1])
    result <- c(result, rvalue)
  }
  return(result)
}
#############################################################
test$result <- myfunc(test[, 2:6])
test$result<-as.factor(test$result)
confusionMatrix(test$result, test$Species)