## 기술통계분석
getwd()
setwd("C:/bigdataR/Part3")
data <- read.csv("descriptive.csv", header = T)
head(data)
dim(data)                          # 행, 열 개수
length(data)                       # 열 개수
length(data$resident)              # 행 개수 (특정 열을 기준으로 실행해야 함)
str(data)                          # 데이터 구조
summary(data)                      # null 개수 포함

# 명목척도
summary(data$gender)               # 평균 의미 x, 이상치 발견
table(data$gender)                 # 명목척도에서는 이상치 찾기 쉬움
data <- subset(data, gender == 1 | gender == 2)        # subset(데이터, 조건)
x <- table(data$gender)
barplot(x)                         # 범주형 데이터 시각화 -> 막대차트
y <- prop.table(x)                 # 비율 (상대도수)
round(y*100,2)                     # 백분율로 출력

# 서열척도
length(data$level)
summary(data$level)                # 이상치 확인
table(data$level)                  # 1:고졸, 2:대졸, 3:대학원졸 -> 변수 리코딩하면 가독성 ↑
x1 <- table(data$level)            # 빈도수 저장
barplot(x1)

# 등간척도
survey <- data$survey      
table(survey)                      # 항목별 빈도수 확인 (의미있음)
summary(survey)                    # 이상치 확인 외 의미없음
x1 <- table(survey)                # 빈도수 저장
pie(x1)                            # 빈도수 이용한 시각화 -> 파이차트
hist(survey)                       # 히스토그램을 그리려면 원본으로 !
hist(x1)                           # 빈도수로 그리면 x 범주 이상해짐

# 비율척도
summary(data$cost)                 # 이상치 발견
plot(data$cost)                    # 이상치 발견
data <- subset(data, cost >= 2 & cost <= 10)         # subset(데이터, 조건)
x <- data$cost
mean(x)

# 대표값 
mean(x)                            # 평균
median(x)                          # 중앙값
quantile(x, 1/4)                   # 제1사분위수
quantile(x, 2/4)                   # 제2사분위수
quantile(x, 3/4)                   # 제3사분위수
quantile(x, 4/4)                   # 제4사분위수

x.t <- table(x)                    # x의 빈도수
class(x.t)                         # class 형
max(x.t)                           # 최빈값

x.m <- rbind(x.t)                  # 2개의 행 병합
class(x.m)                         # matrix 형
str(x.m)
which(x.m[ 1 , ] == 18)            # 검색조건에 부합되는 열이름과 index 반환 (행렬에서 찾는법)
x.df <- as.data.frame(x.m)
which(x.df[ 1 , ] == 18)           # 검색조건에 부합되는 index 반환 (데이터프레임에서 찾는법)
x.df[1,19]
attributes(x.df)
names(x.df[19])

# 산포도
x
var(x)                             # 분산
sd(x)                              # 표준편차
sqrt(var(data$cost, na.rm = T))    # 표준편차

# 빈도분석
table(data$cost)                   # 연속형 변수의 빈도분석
hist(data$cost)                    # 히스토그램 시각화
plot(data$cost)                    # 산점도 시각화

data$cost2[data$cost >= 1 & data$cost <= 3] <- 1     # 연속형 변수의 범주화
data$cost2[data$cost >= 4 & data$cost <= 6] <- 2     # 연속형 변수의 범주화
data$cost2[data$cost >= 7] <- 3                      # 연속형 변수의 범주화
table(data$cost2)
par(mfrow = c(1,2))                # 1행2열로 그리겠다
barplot(table(data$cost2))         # 막대차트 시각화
pie(table(data$cost2))             # 파이차트 시각화
par(mfrow = c(1,1))                # 되돌리기

# 비대칭도
install.packages("moments")
library(moments)
cost <- data$cost
skewness(cost)                     # 왜도 (기울어진 정도)
kurtosis(cost)                     # 첨도 (뾰족한 정도)
hist(cost)                         # 확률질량 히스토그램
hist(cost, freq = F)               # 확률밀도 히스토그램
lines(density(cost), col = 'blue') # 확률밀도 추세선
x <- seq(0,8,0.1)
curve(dnorm(x, mean(cost), sd(cost)),                # 정규분포 곡선 
      col = 'red', add = T)

# 기술통계량 추가정보
attach(data)                       # data$ 생략 가능 !!
length(cost)
summary(cost)
detach(data)                       # attach 풀기

test <- c(1:5, NA, 10:20)
min(test)                          # NA가 있으면 오류 발생 (min, max, range, mean, ...)
min(test, na.rm = T)               # na.rm = T으로 해결

# 기술통계량 구하기
# 거주지역 리코딩, 비율계산
data$resident2[data$resident == 1] <- "특별시"
data$resident2[data$resident >= 2 & data$resident <= 4] <- "광역시"
data$resident2[data$resident == 5] <- "시구군"

x <- table(data$resident2)         # 거주지 빈도수
prop.table(x)                      # 비율 (상대도수)
y <- prop.table(x)
round(y*100,2)                     # 백분율 적용

# 성별 리코딩, 비율계산
data$gender2[data$gender == 1] <- "남자"
data$gender2[data$gender == 2] <- "여자"
x <- table(data$gender2)
y <- prop.table(x)
round(y*100,2)

# 나이 리코딩, 비율계산
data$age2[data$age <= 45] <- "중년층"
data$age2[data$age >= 46 & data$age <= 59] <- "장년층"
data$age2[data$age >= 60] <- "노년층"
x <- table(data$age2)
y <- prop.table(x)
round(y*100,2)

# 학력수준 리코딩, 비율계산
data$level2[data$level == 1] <- "고졸"
data$level2[data$level == 2] <- "대졸"
data$level2[data$level == 3] <- "대학원졸"
x <- table(data$level2)
y <- prop.table(x)
round(y*100,2)

# 합격여부 리코딩, 비율계산
data$pass2[data$pass == 1] <- "합격"
data$pass2[data$pass == 2] <- "불합격"
x <- table(data$pass2)
y <- prop.table(x)
round(y*100,2)

head(data)


# 연습문제2
# 조건1
par(mfrow = c(2,2))
x <- table(data$type)
barplot(x)
pie(x)

y <- table(data$pass)
barplot(y)
pie(y)
par(mfrow = c(1,1))

# 조건2
summary(data$age)
z <- data$age
mean(z)
sd(z)
skewness(z)
kurtosis(z)
hist(z, freq = F)
lines(density(z), col = 'blue')
zz <- seq(40,69,0.1)
curve(dnorm(zz, mean(z), sd(z)), col = 'red', add = T)
