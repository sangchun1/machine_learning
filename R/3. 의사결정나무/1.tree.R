# 의사결정나무 모형의 종류
# tree : 불순도의 척도로 엔트로피 사용
# rpart : tree()의 과적합 문제를 해결한 모형, CART에 기반한 모형
# CART(Classification And Regression Trees) gini 계수가 작아지는
# 방향으로 움직이며 gini 계수를 가장 많이 감소시켜 주는 변수가
# 영향력이 큰 변수가 됨
# 반복적으로 두개의 자식 노드를 생성하기 위해 모든 변수를 사용하여 
# 데이터를 나누는 방식
# ctree : 별도로 가지치기를 할 필요가 없음, 변수의 개수는 31개로 제한됨
# C4.5, C5.0: 가장 최근의 트리 알고리즘, 샘플 개수가 적을 경우 
# 분류가 잘 안되는 단점
df <- read.csv("c:/data/ozone/ozone2.csv")
head(df)
#############################################################
library(dplyr)
# 필드 제거
df <- df %>% select(-Ozone,-Month,-Day)
#############################################################
#불균형 데이터셋
tbl <- table(df$Result)
tbl
barplot(tbl, beside = T, legend = T, col = rainbow(2))
#############################################################
# under sampling
library(ROSE)
# method: under,over,both N: 샘플링 후의 샘플 개수(적은 쪽 x2) 또는 p=0.5 
# 50:50으로 선택
df_samp <- ovun.sample(Result ~ . ,data = df, seed = 1, method = "under", 
                       N = 72*2)$data
table(df_samp$Result)
#############################################################
library(caret)
# 랜덤 시드 고정
set.seed(123)
# 학습용:검증용 8:2로 구분
# list=FALSE, 인덱스값들의 리스트를 반환하지 않음
idx_train <- createDataPartition(y = df_samp$Result, p = 0.8, list = FALSE)
# 학습용
train <- df_samp[idx_train, ]
X_train <- train[, -1]
y_train <- train[, 1]
# 검증용
test <- df_samp[-idx_train, ]
X_test <- test[, -1]
y_test <- test[, 1]
head(X_train)
head(y_train)
#############################################################
#install.packages('tree')
library(tree)
model <- tree(Result ~ ., data=train)
model # 트리 모형이 만든 규칙들
#############################################################
# 트리 그래프
plot(model, uniform = T, main = "Tree")
text(model, use.n = T, all = T, cex = .8)
#############################################################
#교차검증을 통해 분산이 가장 낮은 가지의 수가 선택됨
trees <- cv.tree(model, FUN = prune.tree )
trees
plot(trees)
# 노드가 7개일 때 분산이 가장 낮음
#############################################################
# 가지치기(노드 7개)
ptrees <- prune.tree(model, best = 7)
plot(ptrees); text(ptrees, pretty = 0)
#############################################################
library(e1071)
pred <- predict(ptrees, X_test, type = 'vector')
pred
# 0.5보다 크면 1, 아니면 0으로 설정
result <- ifelse(pred > 0.5, 1, 0)
y_test_f <- as.factor(y_test)
result_f <- as.factor(result)
confusionMatrix(result_f, y_test_f)