library(arules)
# 데이터 로딩
data("Adult")
class(Adult) #트랜잭션 타입
###############################################
Adult
#48842 transactions (rows) and 115 items (columns)
###############################################
summary(Adult)
#가장 많은 횟수 : capital-loss=None 46560
# element (itemset/transaction) length distribution:
###############################################
# 연관규칙의 생성
# arules 패키지가 제공하는 apriori() 함수를 이용하여 연관 규칙을 생성
#apriori() 함수는 최소 지지도에 의해 가지치기를 하는 알고리즘
# 매개변수 / 의미 / 디폴트
# support : 규칙의 최소 지지도, 기본값 0.1
# confidence : 규칙의 최소 신뢰도, 기본값 0.8
# minlen : 규칙에 포함되는 최소 물품 수, 기본값 1
# maxlen : 규칙에 포함되는 최대 물품 수, 기본값 10
# smax : 규칙의 최대 지지도, 기본값 1
# 지지도 = 50%, 신뢰도 80%의 apriori 실행
rules <- apriori(Adult, parameter=list(support=0.5,
                                       confidence=0.8,
                                       target="rules"))
# 요약 보기
summary(rules)
#84개의 규칙을 찾아냄
###############################################
#상위 3개의 룰
as(head(sort(rules,by=c('confidence','support')),n=3),'data.frame')
#full-time 근무자는 자본 손실이 거의 없음(신뢰도 95.82%)
#민간부문고용주는 자본 손실이 거의 없음(신뢰도 95.6%)
#민간부문고용주+미국=>자본손실이 거의 없음(신뢰도 95.54%)
###############################################
inspect(rules)
#{hours-per-week=Full-time} => {native-country=United-States} 0.5179559 0.8852574 0.9864423 25298
#풀타임근무자이고 미국에서 일하는 사람 25298
library(arulesViz)
rules2<-subset(rules, lhs %in% c('hours-per-week=Full-time','capital-loss=None'))
rules2
inspect(sort(rules2,decreasing=T,by='count'))
plot(rules2, method = "graph")
