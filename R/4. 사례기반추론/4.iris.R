df<-read.csv("c:/data/iris/iris.csv")
head(df)
tail(df)
#######################################################
library(dplyr)
# 필드 제거
df<-df %>% select(-Name)
head(df)
dim(df)
summary(df)
#######################################################
#상관계수 행렬
(corrmatrix <- cor(df))
library(corrplot)
corrplot(cor(df), method="circle")
#######################################################
library(caret)
#랜덤 시드 고정
set.seed(123)
#학습용:검증용 8:2로 구분
#list=FALSE, 인덱스값들의 리스트를 반환하지 않음
idx_train <- createDataPartition(y=df$Species, p=0.8, list=FALSE)
#학습용
train <- df[idx_train, ]
X_train <- train[, -5]
y_train <- train[, 5]
#검증용
test <- df[-idx_train, ]
X_test <- test[, -5]
y_test <- test[, 5]
head(X_train)
head(y_train)
#######################################################
library(class)
#k값을 1~10까지 증가시켜 가면서 최적의 k값을 찾는 과정
#분류 정확도를 저장할 비어있는 벡터
acc <- NULL
for( i in c(1:10) ){
  set.seed(123) #재현성을 위해 설정
  pred <- knn(train=X_train, test=X_test, cl=y_train, k=i)
  acc <- c(acc, mean(y_test == pred))
}
#차트를 그리기 위해 데이터프레임으로 변환
df <- data.frame(k=c(1:10), accuracy=acc)
# k에 따른 분류 정확도 그래프 그리기
plot(accuracy ~ k, data = df, type = "o", pch = 20, main = "최적의 k값", ylim=c(0,1), col="red")
# 그래프에 k 라벨링 하기
with(df, text(accuracy ~ k, labels = c(1:10), pos = 1, cex = 0.7))
#######################################################
# 분류 정확도가 가장 높으면서 가장 작은 k는?
n<-min(df[df$accuracy %in% max(acc), "k"])
df[n,]
#######################################################
# knn 모델 생성
set.seed(123)
pred <- knn(train=X_train, test=X_test, cl=y_train, k=n)
tbl<-table(y_test, pred)
tbl
mean(y_test == pred)