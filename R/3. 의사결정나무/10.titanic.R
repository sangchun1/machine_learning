# 로지스틱 회귀분석 예제 : # 성별(Sex), 나이(Age), 객실등급
# (Pclass), 요금(Fare)이 생존에 어느 정도의 영향을 미쳤는가?
df <- read.csv("c:/data/titanic/train3.csv")
head(df)
tail(df)
dim(df)
summary(df)
#############################################################
# 상관계수 행렬
(corrmatrix <- cor(df))
#############################################################
library(corrplot)
corrplot(cor(df), method = "circle")
#############################################################
# 불균형 데이터셋
tbl <- table(df$Survived)
tbl
barplot(tbl, beside = TRUE, legend = TRUE, col = rainbow(2))
#############################################################
# under sampling
#install.packages("ROSE")
library(ROSE)
df_samp <- ovun.sample(Survived ~ . ,data = df, seed=1, method = "under", N = 342*2)$data
tbl <- table(df_samp$Survived)
tbl
#############################################################
library(caret)
# 랜덤 시드 고정
set.seed(123)
# 학습용:검증용 8:2로 구분
# list=FALSE, 인덱스값들의 리스트를 반환하지 않음
idx_train <- createDataPartition(y = df_samp$Survived, p = 0.8, list = FALSE)
# 학습용
train <- df_samp[idx_train, ]
X_train <- train[, -7]
y_train <- train[, 7]
# 검증용
test <- df_samp[-idx_train, ]
X_test <- test[, -7]
y_test <- test[, 7]
head(X_train)
head(y_train)
#############################################################
#install.packages("party")
#install.packages("e1071")
library(party)
# 기계학습 모델 생성
model <- ctree(Survived ~ ., data = train)
model
#############################################################
plot(model)
#############################################################
plot(model,type='simple')
#############################################################
# n=132 샘플수
# y=0.947 1일 확률(여기서는 생존률)
# 여성
#   1,2등석 : 94.7% 생존
#   3등석
#     요금 23 <= : 73.7% 생존
#     요금 23 > : 사망
# 남성
#   1등석 : 43% 생존
#   2,3등석
#     12세 > : 17%
#     12세 <=
#       동승자(형제) 무 : 100%
#       동승자(형제) 유 : 14%
# sibsp 동승자(형제,배우자)
# parch 동승자(부모,자녀)
#############################################################
# 예측값을 0~1 사이로 설정
pred <- predict(model, newdata = X_train, type = 'response')
# 0.5보다 크면 1, 아니면 0으로 설정
result <- ifelse(pred > 0.5, 1, 0)
# 예측정확도
mean(y_train == result)
# 오분류표 출력
table(y_train, result)
#############################################################
# 예측값을 0~1 사이로 설정
pred <- predict(model, newdata = X_test, type = 'response')
# 0.5보다 크면 1, 아니면 0으로 설정
result <- ifelse(pred > 0.5, 1, 0)
# 예측정확도
mean(y_test == result)
# 오분류표 출력
table(y_test, result)
#############################################################
#랜덤 포레스트 모형
library(randomForest)
set.seed(1)
# mtry 변수의 개수, ntree 트리의 개수, importance=T 변수의 중요도로 모델 생성
model <- randomForest(Survived ~ ., data = train, mtry = floor(sqrt(ncol(train))),
                      ntree = 100, importance = T)
model
#############################################################
# predict(학습용데이터셋)
pred <- predict(model, X_train)
# 0.5보다 크면 1, 아니면 0으로 설정
result <- ifelse(pred > 0.5, 1, 0)
head(pred)
head(y_train)
# 분류 모델 평가를 위해 오분류표(confusion matrix) 출력
table(y_train, result)
mean(result == y_train)
#############################################################
# predict(검증용데이터셋)
pred <- predict(model, X_test)
# 0.5보다 크면 1, 아니면 0으로 설정
result <- ifelse(pred > 0.5, 1, 0)
head(pred)
head(y_test)
# 분류 모델 평가를 위해 오분류표(confusion matrix) 출력
table(y_test, result)
mean(result == y_test)
#############################################################
importance(model) # 특성의 중요도
# %IncMSE 정확도, IncNodePurity 중요도
varImpPlot(model)