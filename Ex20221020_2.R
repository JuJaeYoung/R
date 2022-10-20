## 비지도학습
# 계층적 군집 분석
x <- matrix(1:9, nrow = 3, by = T)
x
dist <- dist(x, method = "euclidean")                    # 유클리디안 거리 계산
dist

install.packages("cluster")
library(cluster)
hc <- hclust(dist)                                       # 클러스터링 적용
plot(hc)                                                 # 덴드로그램 출력 (군집분석 시각화)

setwd("C:/bigdataR")
interview <- read.csv("interview.csv", header = T, fileEncoding = "euc-kr")
interview_df <- interview[c(2:7)]
idist <- dist(interview_df)                              # 유클리디안 거리 계산
hc <- hclust(idist)
plot(hc, hang = -1)                                      # 군집분석 시각화. 음수값 제외
rect.hclust(hc, k = 3, border = "red")                   # 3개의 그룹, 빨간색 박스 표시
idist
                                                         # 그룹 내 동질적, 그룹 간 이질적
g1 <- subset(interview, no == 108 | no == 110 | no == 107 | no == 112 | no == 115)
g2 <- subset(interview, no == 102 | no == 101 | no == 104 | no == 106 | no == 113)
g3 <- subset(interview, no == 105 | no == 114 | no == 109 | no == 103 | no == 111)
summary(g1)
summary(g2)
summary(g3)

# 비계층적 군집 분석 (군집의 수를 미리 알고 있을 때)
library(ggplot2)
data("diamonds")
t <- sample(1:nrow(diamonds), 1000)                      # 1000개 랜덤 추출
test <- diamonds[t, ]
mydia <- test[c("price", "carat", "depth", "table")]

result <- hclust(dist(mydia), method = "average")        # 평균 거리 이용. 계층적 군집 분석
result
plot(result, hang = -1)

result2 <- kmeans(mydia, 3)                              # 3개 군집 수 적용. 비계층적 군집 분석
result2$cluster                                          # 각 케이스에 대한 소속 군집 생성 (1, 2, 3)
mydia$cluster <- result2$cluster

cor(mydia[ , -5], method = "pearson")                    # 상관계수 보기
plot(mydia[, -5])                                        # 변수간 산점도 보기

install.packages("mclust")
library(mclust)
install.packages("corrgram")
library(corrgram)
corrgram(mydia[ , -5], upper.panel = panel.conf)         # 상관계수 시각화
corrgram(mydia[ , -5], lower.panel = panel.conf)

plot(mydia$carat, mydia$price, col = mydia$cluster)      # 군집 별 색상 다르게
points(result2$centers[ , c("carat", "price")], col = c(3,1,2), pch = 8, cex = 5)   # 군집의 중심점

# 연관분석
