## 집단 간 차이 분석

## 추정과 검정
# 모평균의 신뢰구간
n <- 10000
xbar <- 165.1
s <- 2
low <- xbar - 1.96 * (s / sqrt(n))
high <- xbar + 1.96 * (s / sqrt(n))
low;high

# 표본오차
(low - xbar) * 100
(high - xbar) * 100

# 모비율의 신뢰구간
# A반도체 회사의 150명을 표본조사해서 90명이 여자임을 확인했다.
# 이 회사 전체의 여자 비율을 구간추정하세요. (95%)
n <- 150
p <- 90 / 150
low <- p - 1.96 * sqrt(p * (1-p) / n)
high <- p + 1.96 * sqrt(p * (1-p) / n)
low;high

## 단일 집단 검정
# 단일 집단 비율 검정
setwd("C:/bigdataR")
data <- read.csv("one_sample.csv", header = T)
head(data)
x <- data$survey
table(x)

install.packages("prettyR")
library(prettyR)                                     # freq() 사용
freq(x)                                              # 빈도수, 비율 계산 함수

binom.test(14, 150, p = 0.2)
# Exact binomial test
# 
# data:  14 and 150                                  # 귀무가설 기각. '불만족에 차이가 있다.'
# number of successes = 14, number of trials = 150, p-value = 0.0006735
# alternative hypothesis: true probability of success is not equal to 0.2
# 95 percent confidence interval:
#   0.05197017 0.15163853                            # 신뢰구간
# sample estimates:
#   probability of success 
# 0.09333333                                         # 추정량
                                                     # alternative : 양측(기본)/단측 , conf.level : 신뢰수준
binom.test(14, 150, p = 0.2, alternative = "two.sided", conf.level = 0.95)
binom.test(14, 150, p = 0.2, alternative = "greater", conf.level = 0.95)
binom.test(14, 150, p = 0.2, alternative = "less", conf.level = 0.95)
                                                     # 귀무가설 기각. '2019년 보다 불만족 수가 낮아졌다' 를 채택

# 단일 집단 평균 검정(단일표본 T-검정)
data <- read.csv("one_sample.csv", header = T)
str(data)
x <- data$time
summary(x)                                           # NA 41개
x1 <- na.omit(x)                                     # NA 제거
mean(x1)                                             # => mean(x, na.rm = T) 같은 표현

shapiro.test(x1)                                     # 정규성 검정
# Shapiro-Wilk normality test                        # 정규분포와 다르지 않다 라는 귀무가설을 채택해야 함. (p-value > 0.05)
# 
# data:  x1
# W = 0.99137, p-value = 0.7242                      # p > 0.05 이므로 귀무가설 채택 (정규분포이다.)

par(mfrow = c(1,2))                                  # 정규분포 시각화
hist(x1)
qqnorm(x1)
qqline(x1, lty = 1, col = "blue")

t.test(x1, mu = 5.2, alternative = "two.sided", conf.level = 0.95)     # 평균 사용 시간에 차이가 있다.
t.test(x1, mu = 5.2, alternative = "greater", conf.level = 0.95)       # 평균 사용 시간보다 길다.
t.test(x1, mu = 5.2, alternative = "less", conf.level = 0.95)          # 평균 사용 시간보다 짧지 않다.

qt(7.083e-05, 108)                                   # qt( p값 , 자유도 ) : 귀무가설을 기각할 수 있는 임계값 제시
                                                     # t > 3.946073 이상이면 귀무가설 기각

## 두 집단 검정
# 두 집단 비율 검정
# 교육방법에 따른 만족도 차이
data <- read.csv("two_sample.csv", header = T)
head(data)
x <- data$method                                     # 교육 방법(1,2) -> NA 없음
y <- data$survey                                     # 불만족(0), 만족(1)
table(x,y,useNA = "ifany")                           # useNA = "ifany" : 결측치까지 출력

# 두 집단 비율 차이 검정
prop.test(c(110,135), c(150,150), alternative = "two.sided", conf.level = 0.95)                    
                                                     # 1집단 150명 중 110명 만족, 2집단 150명 중 135명 만족.
                                                     # p < 0.05 이므로 귀무가설 기각 (교육방법에 따른 만족도에 차이가 있다.)
prop.test(c(110,135), c(150,150), alternative = "greater", conf.level = 0.95)      
prop.test(c(110,135), c(150,150), alternative = "less", conf.level = 0.95)

# 두 집단 평균 검정 (독립 표본 t-검정)
data <- read.csv("two_sample.csv", header = T)
head(data)
summary(data)                                        # score - NA 73개
result <- subset(data, !is.na(score), c(method, score))              
head(result)                                         # 결측치 제거 (전처리)
                                                     # !is.na(score) : score 에서 Na가 아닌 것만 , c(method, score) : 두 변수만 출력
a <- subset(result, method == 1)                     # PT 교육
b <- subset(result, method == 2)                     # 코딩 교육
a1 <- a$score
b1 <- b$score
mean(a1)
mean(b1)
var.test(a1, b1)                                     # p-value 가 0.05 보다 큼. 두 집단 간 분포의 모양이 동질성 있다.
t.test(a1, b1)                                       # p-value 가 0.05 보다 작음. 두 집단 간 평균 차이가 있다.
t.test(a1, b1, alternative = "greater")              # p-value 가 0.05 보다 큼. a집단이 b집단보다 평균이 더 크지 않다.
t.test(a1, b1, alternative = "less")                 # p-value 가 0.05 보다 작음. a집단이 b집단보다 평균이 더 작다.  

# 대응 두 집단 평균 검정 (대응 표본 t-검정)
# 교수법 적용 전 후 비교
data <- read.csv("paired_sample.csv", header = T)
summary(data)                                        # after - NA 4개
result <- subset(data, !is.na(after), c(before, after))
head(result)
x <- result$before
y <- result$after
mean(x)
mean(y)
var.test(x,y)                                        # var.test() : p-value > 0.05 이므로 두 집단 간 분포의 모양이 동질적이다.
t.test(x, y, paired = T, alternative = "two.sided", conf.int = T, conf.level = 0.95)
                                                     # paired = T : 두 집단을 비교한다는 설정.
                                                     # p-value 가 0.05 보다 작음. 두 집단 간 평균 차이가 있다.

# 세 집단 검정
# 세 집단 비율 검정
data <- read.csv("three_sample.csv", header = T)
head(data)
method <- data$method
survey <- data$survey
table(method, survey)
prop.test(c(34,37,39),c(50,50,50))                   # p-value > 0.05 이므로 세 교육 간 만족도 차이가 없다.

# 분산분석(F-검정)
data <- read.csv("three_sample.csv", header = T)
data <- subset(data, !is.na(score), c(method, score))
par(mfrow = c(1,2))
plot(data$score)                                     # outlier 체크
barplot(data$score)                                  # outlier 체크 - 3개
mean(data$score)                                     # 정제 전 평균
data2 <- subset(data, score <= 14)
mean(data2$score)                                    # 정제 후 평균
par(mfrow = c(1,1))
boxplot(data2$score)                                 # 정제 된 데이터는 박스 차트를 이용하여 확인.

data2$method2[data2$method == 1] <- "방법1"
data2$method2[data2$method == 2] <- "방법2"
data2$method2[data2$method == 3] <- "방법3"
x <- table(data2$method2)                            # 교육 방법별 빈도수
y <- tapply(data2$score, data2$method2, mean)        # 교육 방법에 따른 시험성적 평균
df <- data.frame(교육방법 = x, 성적 = y)
df

bartlett.test(score ~ method, data = data2)          # 세 집단 간의 분포 형태가 동질하다.
result <- aov(score ~ method2, data = data2)
names(result)
summary(result)                                      # p-value < 0.05 이므로 세 가지 교육 방법 간의 평균에 차이가 있다.
TukeyHSD(result)                                     # 집단별로 평균의 차에 대한 비교
plot(TukeyHSD(result))                               # 사후검정 시각화 (방법2 > 방법3 > 방법1)


# 13장 연습문제1
# H0 : 프로모션 진행 후 구매비율 <= 기존 구매비율
# H1 : 프로모션 진행 후 구매비율 > 기존 구매비율
data1 <- read.csv("hdtv.csv", header = T)
head(data1)
x1 <- data1$buy
summary(x1)                                          # 결측치 없음.
table(x1)                                            # 구매x : 40 , 구매 : 10
freq(x1)                                             # 비율
binom.test(10, 50, p=0.15, alternative = "greater", conf.level = 0.95)                           
# 	Exact binomial test
# 
# data:  10 and 50                                   # p-value > 0.05 이므로 기존 구매비율보다 향상되었다고 할 수 있다.
# number of successes = 10, number of trials = 50, p-value = 0.2089
# alternative hypothesis: true probability of success is greater than 0.15
# 95 percent confidence interval:
#  0.1127216 1.0000000
# sample estimates:
# probability of success 
#                    0.2 


# 13장 연습문제2
# H0 : 우리나라 중학교 2학년 여학생 평균 신장 ≠ A 중학교 2학년 여학생 평균 신장
# H1 : 우리나라 중학교 2학년 여학생 평균 신장 ＝ A 중학교 2학년 여학생 평균 신장
data2 <- read.csv("student_height.csv", header = T)
head(data2)
x2 <- data2$height
length(x2)                                           # 50개 자료
mean(x2)                                             # 표본평균 신장
shapiro.test(x2)                                     

# 	Shapiro-Wilk normality test
# 
# data:  x2
# W = 0.88711, p-value = 0.0001853                   # p-value < 0.05 이므로 정규성을 띄지 않다는 결론.

wilcox.test(x2, mu=148.5, alternative = "two.sided", conf.level = 0.95)
                                                     
# 	Wilcoxon signed rank test with continuity correction
# 
# data:  x2
# V = 826, p-value = 0.067                           # p-value > 0.05 이므로 평균 차이가 없다는 결론.
# alternative hypothesis: true location is not equal to 148.5


# 13장 연습문제3
# H0 : 성별에 따른 진학한 대학 만족도 차이가 없다.
# H1 : 성별에 따른 진학한 대학 만족도 차이가 있다.
data3 <- read.csv("two_sample.csv", header = T)
x3 <- data3$gender                                   # 성별  
y3 <- data3$survey                                   # 만족도
table(x3)
table(x3,y3)                                         # 남 만족 : 138 , 여 만족 : 107
prop.test(c(138, 107), c(174, 126), alternative = "two.sided", conf.level = 0.95)

# 	2-sample test for equality of proportions with continuity correction
# 
# data:  c(138, 107) out of c(174, 126)              # p-value > 0.05 이므로 성별에 따라 진학한 대학에 대해 만족도 차이가 있다.  
# X-squared = 1.1845, df = 1, p-value = 0.2765
# alternative hypothesis: two.sided
# 95 percent confidence interval:
#  -0.14970179  0.03749599
# sample estimates:
#    prop 1    prop 2 
# 0.7931034 0.8492063


# 13장 연습문제4
# H0 : 교육 방법에 따라 시험성적 차이가 없다.
# H1 : 교육 방법에 따라 시험성적 차이가 있다.
data4 <- read.csv("twomethod.csv", header = T)
head(data4)
summary(data4)
data4 <- subset(data4, !is.na(score), c(method, score))   # 결측치 제거
x4 <- subset(data4, method == 1)
y4 <- subset(data4, method == 2)
x4 <- x4$score                                       # 방법1 성적
y4 <- y4$score                                       # 방법2 성적
mean(x4)                                             # 방법1 평균 : 16.40909
mean(y4)                                             # 방법2 평균 : 29.22857
var.test(x4,y4)                                      # 동질성 검정
# 	F test to compare two variances
# 
# data:  x4 and y4                                   # p-value > 0.05 이므로 두 분포가 동질성을 가진다고 결론.
# F = 1.0648, num df = 21, denom df = 34, p-value = 0.8494
# alternative hypothesis: true ratio of variances is not equal to 1
# 95 percent confidence interval:
#  0.502791 2.427170
# sample estimates:
# ratio of variances 
#            1.06479
t.test(x4,y4,alternative = "two.sided", conf.level = 0.95)
# 	Welch Two Sample t-test
# 
# data:  x4 and y4                                   # p-value < 0.05 이므로 교육 방법에 따라 시험성적 차이가 있다고 결론.
# t = -5.6056, df = 43.705, p-value = 1.303e-06
# alternative hypothesis: true difference in means is not equal to 0
# 95 percent confidence interval:
#  -17.429294  -8.209667
# sample estimates:
# mean of x mean of y 
#  16.40909  29.22857 

