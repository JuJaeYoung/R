# 함수 정의

# 사용자 정의 함수
f3 <- function(x, y) {
  add <- x + y
  return(add)
}
result <- f3(1,2)
result

# 기술통계량을 계산하는 함수 정의
quakes
class(quakes)
help(quakes)

head(quakes)
tail(quakes)
q <- quakes$mag              # 지진강도를 벡터로 저장

summary(q)                   # 요약(최대, 최소, 사분위수 등)
table(q)                     # 빈도수

var_sd <- function(x){
  var <- sum((x-mean(x))^2) / (length(x) - 1)
  sd <- sqrt(var)
  cat("분산 : ", var, "\n")
  cat("표준편차 : ", sd, "\n")
}
var_sd(q)

data <- c(10, 20, 5, 4, 40, 7, NA, 6, 3, NA, 2, NA)
na <- function(x){
  # 1차 : NA 제거
  print(x)
  print(mean(x,na.rm = T))
  
  # 2차 : NA를 0으로 대체
  data <- ifelse(!is.na(x), x, 0)
  print(data)
  print(mean(data))
  
  # 3차 : NA를 평균으로 대체
  data2 <- ifelse(!is.na(x), x, round(mean(x,na.rm = T), 2))
  print(data2)
  print(mean(data2))
}
na(data)

install.packages("RSADBE")
library(RSADBE)
data("Bug_Metrics_Software")
Bug_Metrics_Software
Bug_Metrics_Software[,,1]   # 출시 전 버그
Bug_Metrics_Software[,,2]   # 출시 후 버그
dim(Bug_Metrics_Software)

rowSums(Bug_Metrics_Software[,,1])    # 출시 전 버그 합계(행별)
rowMeans(Bug_Metrics_Software[,,1])   # 출시 전 버그 평균(행별)
colSums(Bug_Metrics_Software[,,1])    # 출시 전 버그 합계(열별)
colMeans(Bug_Metrics_Software[,,1])   # 출시 전 버그 평균(열별)
