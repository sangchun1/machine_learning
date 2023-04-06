#부스팅: 여러개의 모형을 만들어 평균으로 성능 측정, 복원 추출(중복값 허용)
# 미리 정해진 개수의 모형을 사용하지 않고 하나의 모형에서 시작하여 개별 모형을 하나씩 추가하는 방법
# 다수결 방법이 아닌 개별 모형의 출력에 가중치를 조합한 값을판별함수로 사용
#C5.0 : 트리 알고리즘 중 성능이 우수한 알고리즘 중 하나
df<-read.csv("c:/data/ozone/ozone2.csv")
head(df)
#############################################################
library(dplyr)
# 필드 제거
df<-df %>% select(-Ozone)
#############################################################
#불균형 데이터셋
tbl<-table(df$Result)
tbl
barplot(tbl, beside = T, legend = T, col =
                       rainbow(2))
# under sampling
#install.packages("ROSE")
library(ROSE)
# method: under,over,both N: 샘플링 후의 샘플 개수(적은 쪽 x2) 또는 p=0.5 
# 50:50으로 선택
df_samp <- ovun.sample(Result ~ . ,data = df, seed=1, method =
                         "under", N=72*2)$data
tbl<-table(df_samp$Result)
tbl
#############################################################
library(caret)
#랜덤 시드 고정
set.seed(123)
#학습용:검증용 8:2로 구분
#list=FALSE, 인덱스값들의 리스트를 반환하지 않음
idx_train <- createDataPartition(y=df_samp$Result, p=0.8,
                                 list=FALSE)
#학습용
train <- df_samp[idx_train, ]
X_train <- train[, -1]
y_train <- train[, 1]
#검증용
test <- df_samp[-idx_train, ]
X_test <- test[, -1]
y_test <- test[, 1]
head(X_train)
head(y_train)
#############################################################
#install.packages('C50')
library(C50)
y_train<-as.factor(y_train)
# trials 최대 10개의 모형을 생성
model <- C5.0(y_train ~ ., data=X_train, trials=10)
summary(model)
# 트리 그래프

plot(model, uniform=T, main="Tree")
text(model, use.n=T, all=T, cex=.8)
#############################################################
# predict(트리모델, 학습용데이터셋)
pred <- predict(model,newdata=X_test)
pred
#############################################################
#분류 모델 평가를 위해 오분류표(confusion matrix) 출력
table(y_test, pred)
mean(y_test == pred)
#############################################################
y_test_f<-as.factor(y_test)
confusionMatrix(y_test_f, pred)