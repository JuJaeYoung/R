## 기계 학습

## 지도 학습
getwd()
setwd("C:/bigdataR")

# 단순 회귀 분석 (lm 함수)
# 선형성, 정규성, 독립성, 등분산성, 다중 공선성 만족 !

# 연구가설 : 제품적절성은 제품만족도에 영향을 미친다.
# 귀무가설 : 제품적절성은 제품만족도와 관련이 없다.
product <- read.csv("product.csv", header = T, fileEncoding = "euc-kr")
y <- product$제품_만족도                               # 종속변수
x <- product$제품_적절성                               # 독립변수
df <- data.frame(x,y)
result.lm <- lm(formula = y ~ x, data = df)            # 단순 선형회귀 모델 생성
result.lm
# Call:
# lm(formula = y ~ x, data = df)
# 
# Coefficients:
# (Intercept)            x  
#      0.7789       0.7393                             # y = 0.7789 + 0.7393 * x    

fitted.values(result.lm)[1:2]                          # 1,2 번째 값 적합값 확인
result.lm$residuals[1:2]                               # 1,2 번째 값 잔차 확인

plot(formula = y ~ x, data = df)                       # 산점도 시각화
result.lm <- lm(formula = y ~ x, data = df)
abline(result.lm, col = 'red')                         # 회귀선 시각화

summary(result.lm)
# Call:
# lm(formula = y ~ x, data = df)
# 
# Residuals:
#      Min       1Q   Median       3Q      Max 
# -1.99669 -0.25741  0.00331  0.26404  1.26404 
# 
# Coefficients:
#             Estimate Std. Error t value Pr(>|t|)    
# (Intercept)  0.77886    0.12416   6.273 1.45e-09 ***            # 절편
# x            0.73928    0.03823  19.340  < 2e-16 ***            # 기울기
# ---
# Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 0.5329 on 262 degrees of freedom
# Multiple R-squared:  0.5881,	Adjusted R-squared:  0.5865       # R^2 = 0.588 : 58.8% 만큼 설명.
# F-statistic:   374 on 1 and 262 DF,  p-value: < 2.2e-16         # 영향을 미친다.
                                                       

# 다중 회귀 분석 (다중 공선성 고려)

# 연구가설 : 제품적절성과 제품친밀도는 제품만족도에 영향을 미친다.
# 귀무가설 : 제품적절성과 제품친밀도는 제품만족도와 관련이 없다.
y <- product$제품_만족도                               # 종속변수
x1 <- product$제품_친밀도                              # 독립변수1
x2 <- product$제품_적절성                              # 독립변수2
df <- data.frame(x1,x2,y)

result.lm <- lm(formula = y ~ x1 + x2, data = df)
result.lm
# Call:
# lm(formula = y ~ x1 + x2, data = df)
# 
# Coefficients:
# (Intercept)           x1           x2  
#     0.66731      0.09593      0.68522                # y = 0.66731 + 0.09593 * x1 + 0.68522 * x2  

# 다중 공선성 확인
install.packages("car")
library(car)
vif(result.lm)                                         # 분산팽창요인(VIF) : 10이상이면 문제 의심.
#       x1       x2 
# 1.331929 1.331929                                    # (VIF < 10) 문제없음.

summary(result.lm)
# Call:
# lm(formula = y ~ x1 + x2, data = df)
# 
# Residuals:
#      Min       1Q   Median       3Q      Max 
# -2.01076 -0.22961 -0.01076  0.20809  1.20809 
# 
# Coefficients:
#             Estimate Std. Error t value Pr(>|t|)    
# (Intercept)  0.66731    0.13094   5.096 6.65e-07 ***
# x1           0.09593    0.03871   2.478   0.0138 *  
# x2           0.68522    0.04369  15.684  < 2e-16 ***
# ---
# Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 0.5278 on 261 degrees of freedom
# Multiple R-squared:  0.5975,	Adjusted R-squared:  0.5945 
# F-statistic: 193.8 on 2 and 261 DF,  p-value: < 2.2e-16         # 영향을 미친다. 


# 주요 실습 과정
#1 다중 공선성 문제 해결
data(iris)
model <- lm(formula = Sepal.Length ~ Sepal.Width + Petal.Length + Petal.Width, data = iris)
vif(model)
#  Sepal.Width Petal.Length  Petal.Width 
#     1.270815    15.097572    14.234335               # (VIF > 10) 다중공선성 의심이 된다. => 상관분석을 통해 변수 간 영향을 파악.
sqrt(vif(model)) > 2                                   # 2 이상이면 다중 공선성 의심.

cor(iris[ , -5])
#              Sepal.Length Sepal.Width Petal.Length Petal.Width
# Sepal.Length    1.0000000  -0.1175698    0.8717538   0.8179411
# Sepal.Width    -0.1175698   1.0000000   -0.4284401  -0.3661259
# Petal.Length    0.8717538  -0.4284401    1.0000000   0.9628654
# Petal.Width     0.8179411  -0.3661259    0.9628654   1.0000000  # Petal.Length 와 Petal.Width 0.9629 너무 높다..

#2 회귀모델 생성
x <- sample(1:nrow(iris), 0.7 * nrow(iris))            # 인덱스 랜덤 추출
train <- iris[x, ]                                     # 학습데이터 선정 (70%)
test <- iris[-x, ]                                     # 검정데이터 선정 (30%)

model <- lm(formula = Sepal.Length ~ Sepal.Width + Petal.Length, data = iris)
                                                       # 다중공선성 제거한 회귀분석 실행
                                                       # y = 2.2491 + 0.5955 * x1 + 0.4719 * x2
summary(model)
# Call:
# lm(formula = Sepal.Length ~ Sepal.Width + Petal.Length, data = iris)
# 
# Residuals:
#      Min       1Q   Median       3Q      Max 
# -0.96159 -0.23489  0.00077  0.21453  0.78557 
# 
# Coefficients:
#              Estimate Std. Error t value Pr(>|t|)    
# (Intercept)   2.24914    0.24797    9.07 7.04e-16 ***
# Sepal.Width   0.59552    0.06933    8.59 1.16e-14 ***
# Petal.Length  0.47192    0.01712   27.57  < 2e-16 ***
# ---
# Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 0.3333 on 147 degrees of freedom
# Multiple R-squared:  0.8402,	Adjusted R-squared:  0.838 
# F-statistic: 386.4 on 2 and 147 DF,  p-value: < 2.2e-16        # 영향을 미친다.

#3 회귀방정식 도출
head(train, 1)
Y = 2.2491 + 0.5955 * 3 + 0.4719 * 1.4                  # 다중 회귀방정식 적용. 예측값
Y
4.8 - Y                                                 # 잔차 = 관측값 - 예측값

#4 예측치 생성
pred <- predict(model, test)                            # 테스트 데이터로 평가(예측값)
pred

#5 회귀모델 평가
cor(pred, test$Sepal.Length)                            # 0.9093227 = 예측값과 관측값 상관관계


# 잔차분석과 다중 공선성 검사를 통해 회귀분석의 기본 가정을 충족하는지 확인.
formula <- Sepal.Length ~ Sepal.Width + Petal.Length + Petal.Width
model <- lm(formula = formula, data = iris)
model

#1 독립성 검정 (p-value > 0.05 이면 독립성.)
install.packages("lmtest")                              
library(lmtest)
dwtest(model)
# 	Durbin-Watson test
# 
# data:  model
# DW = 2.0604, p-value = 0.6013                         # p-value > 0.05 이므로 독립성을 띈다.
# alternative hypothesis: true autocorrelation is greater than 0

#2 등분산성 검정
# 잔차와 적합값의 분포 비교 (분산이 일정, 적합값의 크기에 따라 잔차가 변화없어야 함)
plot(model, which = 1)

#3 정규성 검정
res <- residuals(model)                                 # 회귀분석 결과 중에서 잔차 저장  
shapiro.test(res)                                      
# 	Shapiro-Wilk normality test
# 
# data:  res
# W = 0.99559, p-value = 0.9349                         # p-value > 0.05 이므로 정규성.
plot(model, which = 2)
qqnorm(res)

#4 다중공선성 검사
vif(model)                                              # 10이상이면 의심.. 두 변수 중 하나 제거하여 회귀모델 다시 생성.

help(read.csv)
# 로지스틱 회귀분석
weather <- read.csv("weather.csv", stringsAsFactors = F)               # 회귀분석에서는 숫자형이 필요하기에 Factor형으로 변환 x (T 하면 1,2로 변환되어 읽음)
weather_df <- weather[c(-212, -222, -272, -301, -349), c(-1,-6,-8,-14)]# 결측치 5개 제거
weather_df$RainTomorrow[weather_df$RainTomorrow == "Yes"] <- 1         # 로짓 변환.
weather_df$RainTomorrow[weather_df$RainTomorrow == "No"] <- 0
weather_df$RainTomorrow <- as.numeric(weather_df$RainTomorrow)

idx <- sample(1:nrow(weather_df), nrow(weather_df) * 0.7)
train <- weather_df[idx , ]
test <- weather_df[-idx , ]
weather_model <- glm(RainTomorrow ~ ., data = train, family = 'binomial')
                                                        # y ~ . : 종속변수 말고 나머지 전부 다 독립변수 지정.
weather_model                                           # 로지스틱 회귀, 이항분포 사용
summary(weather_model)

pred <- predict(weather_model, newdata = test, type = "response")
pred                                                    # 예측 결과는 0~1 사이 확률값으로..

result_pred

result_pred <- ifelse(pred >= 0.5, 1, 0)
table(result_pred)
table(result_pred, test$RainTomorrow)                   # 예측값과 관측값 비교
# result_pred  0  1
#           0 TP FN       
#           1 FP TN       

install.packages("ROCR")
library(ROCR)
pr <- prediction(pred, test$RainTomorrow)
prf <- performance(pr, measure = "tpr", x.measure = "fpr")
plot(prf)

## 분류분석
# 의사결정 트리
install.packages("party")
library(party)

formula <- Temp ~ Solar.R + Wind + Ozone
air_ctree <- ctree(formula = formula, data = airquality) # 의사결정나무
air_ctree
plot(air_ctree)

set.seed(1234)                                           # 시드값을 적용하면 랜덤 값이 동일하게 생성. 같은 알고리즘.
idx <- sample(1:nrow(iris), nrow(iris) * 0.7)            
train <- iris[idx, ]                                     # 학습데이터
test <- iris[-idx, ]                                     # 검정데이터
formula <- Species ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width
iris_ctree <- ctree(formula = formula, data = train)
iris_ctree
plot(iris_ctree, type = "simple")
plot(iris_ctree)

pred <- predict(iris_ctree, test)
table(pred, test$Species)
(16 + 15 + 12) / nrow(test)                              # accuracy  

install.packages("cvTools")
library(cvTools)
cross <- cvFolds(nrow(iris), K = 3, R = 2)               # K겹 교차 검정 (3겹, 2회 반복)
cross

R <- 1:2
K <- 1:3
CNT <- 0
ACC <- numeric()

for(r in R){
  cat('\n R = ', r, '\n')
  for(k in K){
    
    # test 생성
    datas_idx <- cross$subsets[cross$which == k, r]
    test <- iris[datas_idx, ]
    cat('test : ', nrow(test), '\n')
    
    # train 생성
    formula <- Species ~ .
    train <- iris[-datas_idx, ]
    cat('train : ', nrow(train), '\n')
    
    # model 생성
    model <- ctree(Species ~ ., data = train)
    pred <- predict(model, test)
    t <- table(pred, test$Species)
    print(t)
    
    # 분류정확도 추가
    CNT <- CNT + 1
    ACC[CNT] <- (t[1, 1] + t[2, 2] + t[3, 3]) / sum(t)
  } # inntero for k
  
} # outer for r


#  R =  1 
# test :  50 
# train :  100 
#             
# pred         setosa versicolor virginica
#   setosa         12          0         0
#   versicolor      2         17         1
#   virginica       0          1        17
# test :  50 
# train :  100 
#             
# pred         setosa versicolor virginica
#   setosa         17          0         0
#   versicolor      0         18         1
#   virginica       0          2        12
# test :  50 
# train :  100 
#             
# pred         setosa versicolor virginica
#   setosa         19          0         0
#   versicolor      0         11         3
#   virginica       0          1        16
# 
#  R =  2 
# test :  50 
# train :  100 
#             
# pred         setosa versicolor virginica
#   setosa         16          0         0
#   versicolor      0         17         2
#   virginica       0          1        14
# test :  50 
# train :  100 
#             
# pred         setosa versicolor virginica
#   setosa         15          0         0
#   versicolor      0         17         2
#   virginica       0          1        15
# test :  50 
# train :  100 
#             
# pred         setosa versicolor virginica
#   setosa         19          0         0
#   versicolor      0         12         0
#   virginica       0          2        17

# iris 를 활용하여 로지스틱 회귀분석
str(iris)

iris$Species <- as.numeric(iris$Species)
idx_iris <- sample(1:nrow(iris), nrow(iris) * 0.7)
train_iris <- iris[idx_iris, ]
test_iris <- iris[-idx_iris, ]
iris_model <- glm(Species ~ ., data = iris, family = 'binomial')
