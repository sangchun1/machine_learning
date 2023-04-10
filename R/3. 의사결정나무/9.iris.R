df <- read.csv("c:/data/iris/iris.csv")
head(df)
tail(df)
#############################################################
library(dplyr)
# 필드 제거
df <- df %>% select(-Name)
head(df)
dim(df)
summary(df)
#############################################################
#상관계수 행렬
(corrmatrix <- cor(df))
#############################################################
library(corrplot)
corrplot(cor(df), method = "circle")
#############################################################
library(caret)
# 랜덤 시드 고정
set.seed(123)
# 학습용:검증용 8:2로 구분
# list=FALSE, 인덱스값들의 리스트를 반환하지 않음
idx_train <- createDataPartition(y = df$Species, p = 0.8, list = FALSE)
# 학습용
train <- df[idx_train, ]
X_train <- train[, -5]
y_train <- train[, 5]
# 검증용
test <- df[-idx_train, ]
X_test <- test[, -5]
y_test <- test[, 5]
head(X_train)
head(y_train)
#############################################################
#install.packages("party")
#install.packages("e1071")
library(party)
# 기계학습 모델 생성
model <- ctree(Species ~ ., data = train)
model
#############################################################
plot(model)
#############################################################
# predict(트리모델, 학습용데이터셋)
pred <- predict(model, newdata = X_train)
# 분류 모델 평가를 위해 오분류표(confusion matrix) 출력
table(y_train, round(pred))
mean(round(pred) == y_train)
#############################################################
# predict(트리모델, 검증용데이터셋)
pred <- predict(model, newdata = X_test)
# 분류 모델 평가를 위해 오분류표(confusion matrix) 출력
table(y_test, round(pred))
mean(round(pred) == y_test)
#############################################################
# 랜덤 포레스트 모형
library(randomForest)
set.seed(1)
# mtry 변수의 개수, ntree 트리의 개수, importance=T 변수의 중요도로 모델 생성
model <- randomForest(Species ~ ., data = train,
                      mtry = floor(sqrt(ncol(train))), ntree = 5, importance = T)
model
#############################################################
# predict(학습용데이터셋)
pred <- predict(model, newdata=X_train)
# 분류 모델 평가를 위해 오분류표(confusion matrix) 출력
table(y_train, round(pred))
mean(round(pred) == y_train)
# 표준화 전 64.2%
#############################################################
# predict(검증용데이터셋)
pred <- predict(model, newdata = X_test)
# 분류 모델 평가를 위해 오분류표(confusion matrix) 출력
table(y_test, round(pred))
mean(round(pred) == y_test)
# 표준화 전 64.2%
#############################################################
importance(model) # 특성의 중요도
# %IncMSE 정확도, IncNodePurity 중요도
varImpPlot(model)