library(arules)
data("Groceries")
Groceries
# 9835 transactions (rows) and 169 items (columns)
###############################################
summary(Groceries)
#가장 많은 상품 : whole milk 2513회
###############################################
#apriori알고리즘으로 연관규칙 찾기
# transactions 리스트 중에서 빈번하게 발생하는 아이템셋을 찾는 알고리즘
groc.rules <- apriori(Groceries, parameter=list(supp=0.01,
                                                conf=0.3, target="rules"))
#sorting and recoding items ... [88 item(s)] done [0.00s].
#=> 88개 아이템
#writing ... [125 rule(s)] done [0.00s].
#=> 125개 룰이 발견
###############################################
#규칙이 너무 적으면 지지도와 신뢰도를 낮춘다
#규칙이 너무 많으면 지지도와 신뢰도를 높인다
#상위 3개의 룰
as(head(sort(groc.rules,by=c('confidence','support')),n=3),'data.frame')
#{citrus fruit,root vegetables} => {other vegetables}(신뢰도 58.6%), 감귤류 과일,뿌리채소
#{tropical fruit,root vegetables} => {other vegetables}(신뢰도 58.4%), 열대과일,뿌리채소
#{curd,yogurt} => {whole milk}(신뢰도 58.2%), 두부,요거트
###############################################
#전체 규칙
inspect(groc.rules)
###############################################
inspect(subset(groc.rules,lift>3))
#[1] {beef} => {root vegetables} 0.01738688
#1.7%지지도(장바구니의 1.7%에서 해당 조합이 발생)
#3.04리프트(단독으로 판매되는것보다 3배 더 발생)
#제품진열이나 쿠폰발행시 고려하도록 제안할 수 있음
###############################################
library(arulesViz)
#method = "graph"
#물품들 간의 연관성 그래프
plot(groc.rules, method = "graph")
