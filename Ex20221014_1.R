## 요인 분석과 상관관계 분석

## 요인 분석
## 공통요인으로 변수 통제
# 6개 과목의 점수(5점 만점 = 5점 척도)
s1 <- c(1,2,1,2,3,4,2,3,4,5)                          # 자연과학
s2 <- c(1,3,1,2,3,4,2,4,3,4)                          # 물리화학
s3 <- c(2,3,2,3,2,3,5,3,4,2)                          # 인문사회
s4 <- c(2,4,2,3,2,3,5,3,4,1)                          # 신문방송
s5 <- c(4,5,4,5,2,1,5,2,4,3)                          # 응용수학
s6 <- c(4,3,4,4,2,1,5,2,4,2)                          # 추론통계
name <- 1:10                                          # 각 과목의 문제에 대한 문항 이름

subject <- data.frame(s1,s2,s3,s4,s5,s6)
str(subject)

# 주성분 분석
pc <- prcomp(subject)                                 
summary(pc)
# Importance of components:
#                          PC1    PC2     PC3     PC4     PC5     PC6
# Standard deviation     2.389 1.5532 0.87727 0.56907 0.19315 0.12434
# Proportion of Variance 0.616 0.2603 0.08305 0.03495 0.00403 0.00167  
# Cumulative Proportion  0.616 0.8763 0.95936 0.99431 0.99833 1.00000  <- 보통 누적 변동량이 80% 이상이 되는 값 찾기!! (2번째 성분까지)

plot(pc)                                              # 주성분 분석 시각화

# 고유값과 고유벡터를 이용한 요인 수 분석
en <- eigen(cor(subject))                              
en$values                                             # $values : 고유값
en$vectors                                            # $vectors : 고유벡터

plot(en$values, type='o')                             # 시각화 <- 급격하게 변하는 구간 채택 or 고유값이 1 이상

#상관성으로 공통요인 추출
cor(subject)                                          # s1,s2 / s3,s4 / s5,s6
#             s1          s2         s3         s4         s5         s6
# s1  1.00000000  0.86692145 0.05847768 -0.1595953 -0.5504588 -0.6262758
# s2  0.86692145  1.00000000 0.06745441 -0.0240123 -0.6349581 -0.7968892
# s3  0.05847768  0.06745441 1.00000000  0.9239433  0.3506967  0.4428759
# s4 -0.15959528 -0.02401230 0.92394333  1.0000000  0.4207582  0.4399890
# s5 -0.55045878 -0.63495808 0.35069667  0.4207582  1.0000000  0.8733514
# s6 -0.62627585 -0.79688923 0.44287589  0.4399890  0.8733514  1.0000000

# 베리멕스 회전법 (분산을 극대화 -> 더욱 분명하게 구분 가능)
result <- factanal(subject, factors = 2, rotation = "varimax")
result
# Call:
# factanal(x = subject, factors = 2, rotation = "varimax")
# 
# Uniquenesses:
#    s1    s2    s3    s4    s5    s6 
# 0.250 0.015 0.005 0.136 0.407 0.107 
# 
# Loadings:
#    Factor1 Factor2
# s1  0.862         
# s2  0.988         
# s3          0.997 
# s4 -0.115   0.923 
# s5 -0.692   0.338 
# s6 -0.846   0.421 
# 
#                Factor1 Factor2
# SS loadings      2.928   2.152
# Proportion Var   0.488   0.359
# Cumulative Var   0.488   0.847
# 
# Test of the hypothesis that 2 factors are sufficient.
# The chi square statistic is 11.32 on 4 degrees of freedom.
# The p-value is 0.0232                              # p-value < 0.05 이므로 요인수가 부족하다는 의미.. 요인수 늘려서 다시 분석 수행!

result <- factanal(subject, factors = 3, rotation = "varimax", scores = "regression")
result                                               # scores = "regression" : 요인점수 활용!
# Call:
# factanal(x = subject, factors = 3, scores = "regression", rotation = "varimax")
# 
# Uniquenesses:
#    s1    s2    s3    s4    s5    s6 
# 0.005 0.056 0.051 0.005 0.240 0.005 
# 
# Loadings:
#    Factor1 Factor2 Factor3
# s1 -0.379           0.923 
# s2 -0.710   0.140   0.649 
# s3  0.236   0.931   0.166 
# s4  0.120   0.983  -0.118 
# s5  0.771   0.297  -0.278 
# s6  0.900   0.301  -0.307 
# 
#                Factor1 Factor2 Factor3
# SS loadings      2.122   2.031   1.486
# Proportion Var   0.354   0.339   0.248
# Cumulative Var   0.354   0.692   0.940
#                                                    
# The degrees of freedom for the model is 0 and the fit was 0.7745 

result$loadings                                     # 기본 요인적재량
print(result, digits = 2, cutoff = 0.5)             # 요인부하량 0.5 이상, 소수점 2자리

# 요인점수를 이용한 요인적재량 시각화
result$scores                                       # 요인점수

#1 Factor1, Factor2
plot(result$scores[ , c(1,2)], main = "Factor1과 Factor2 요인점수 행렬")
text(result$scores[ , 1], result$scores[ , 2], labels = name, cex = 0.7, pos = 3, col = "blue")
points(result$loadings[ , c(1,2)], pch = 19, col = "red")
text(result$loadings[ , 1], result$loadings[ , 2], labels = rownames(result$loadings), cex = 0.8, pos = 3, col = "red")

#2 Factor1, Factor3
plot(result$scores[ , c(1,3)], main = "Factor1과 Factor3 요인점수 행렬")
text(result$scores[ , 1], result$scores[ , 3], labels = name, cex = 0.7, pos = 3, col = "blue")
points(result$loadings[ , c(1,3)], pch = 19, col = "red")
text(result$loadings[ , 1], result$loadings[ , 3], labels = rownames(result$loadings), cex = 0.8, pos = 3, col = "red")

#3 Factor2, Factor3
plot(result$scores[ , c(2,3)], main = "Factor2과 Factor3 요인점수 행렬")
text(result$scores[ , 2], result$scores[ , 3], labels = name, cex = 0.7, pos = 3, col = "blue")
points(result$loadings[ , c(2,3)], pch = 19, col = "red")
text(result$loadings[ , 2], result$loadings[ , 3], labels = rownames(result$loadings), cex = 0.8, pos = 3, col = "red")

# 3차원 산점도
library(scatterplot3d)
Factor1 <- result$scores[ ,1]
Factor2 <- result$scores[ ,2]
Factor3 <- result$scores[ ,3]

d3 <- scatterplot3d(Factor1, Factor2, Factor3, type = "p")

loading1 <- result$loadings[ ,1]
loading2 <- result$loadings[ ,2]
loading3 <- result$loadings[ ,3]
d3$points3d(loading1, loading2, loading3, bg = "red", pch = 21, cex = 2, type = "h")

# 상관관계 분석
app <- data.frame(subject$s5, subject$s6) # 응용과학
soc <- data.frame(subject$s3, subject$s4) # 사회과학
nat <- data.frame(subject$s1, subject$s2) # 자연과학

app_science <- round((app$subject.s5 + app$subject.s6) / ncol(app), 2)
soc_science <- round((soc$subject.s3 + soc$subject.s4) / ncol(soc), 2)
nat_science <- round((nat$subject.s1 + nat$subject.s2) / ncol(nat), 2)

subject_factor_df <- data.frame(app_science, soc_science, nat_science)
cor(subject_factor_df)
#             app_science soc_science nat_science
# app_science   1.0000000  0.43572654 -0.68903024
# soc_science   0.4357265  1.00000000 -0.02570212
# nat_science  -0.6890302 -0.02570212  1.00000000


## 잘못 분류된 요인 제거로 변수 정제
# spss 데이터 활용
install.packages("memisc")
library(memisc)

data.spss <- as.data.set(spss.system.file("drinking_water.sav"))
drinking_water <- data.spss[1:11]
drinking_water_df <- as.data.frame(drinking_water)
drinking_water_df

result2 <- factanal(drinking_water_df, factors = 3, rotation = "varimax")
result2                                               # 요인분석 
# Call:
# factanal(x = drinking_water_df, factors = 3, rotation = "varimax")
# 
# Uniquenesses:                                       # 0.5보다 작으면 유효
#    Q1    Q2    Q3    Q4    Q5    Q6    Q7    Q8    Q9   Q10   Q11 
# 0.321 0.238 0.284 0.447 0.425 0.373 0.403 0.375 0.199 0.227 0.409 
# 
# Loadings:
#     Factor1 Factor2 Factor3                         # 만족도, 친밀도, 적절성
# Q1  0.201   0.762   0.240                           # Q8~11   Q1~3(4) Q5~7 
# Q2  0.172   0.813   0.266                           # Q4 타당성 의심.
# Q3  0.141   0.762   0.340  
# Q4  0.250   0.281   0.641  
# Q5  0.162   0.488   0.557  
# Q6  0.224   0.312   0.693  
# Q7  0.235   0.219   0.703  
# Q8  0.695   0.225   0.304  
# Q9  0.873   0.122   0.155  
# Q10 0.852   0.144   0.161  
# Q11 0.719   0.152   0.225  
# 
#                Factor1 Factor2 Factor3
# SS loadings      2.772   2.394   2.133
# Proportion Var   0.252   0.218   0.194
# Cumulative Var   0.252   0.470   0.664
# 
# Test of the hypothesis that 3 factors are sufficient.
# The chi square statistic is 40.57 on 25 degrees of freedom.
# The p-value is 0.0255

dw_df <- drinking_water_df[-4]                       # 타당성 의심되는 Q4 제거
dw_df

s <- data.frame(dw_df$Q8, dw_df$Q9, dw_df$Q10, dw_df$Q11)
c <- data.frame(dw_df$Q1, dw_df$Q2, dw_df$Q3)
p <- data.frame(dw_df$Q5, dw_df$Q6, dw_df$Q7)

satisfaction <- round((s$dw_df.Q8 + s$dw_df.Q9 + s$dw_df.Q10 + s$dw_df.Q11) / ncol(s), 2)
closeness <- round((c$dw_df.Q1 + c$dw_df.Q2 + c$dw_df.Q3) / ncol(c), 2)
pertinence <- round((p$dw_df.Q5 + p$dw_df.Q6 + p$dw_df.Q7) / ncol(p), 2)

drinking_water_factor_df <- data.frame(satisfaction, closeness, pertinence)
colnames(drinking_water_factor_df) <- c("제품만족도", "제품친밀도", "제품적절성")
cor(drinking_water_factor_df)
#            제품만족도 제품친밀도 제품적절성
# 제품만족도  1.0000000  0.4047543  0.4825335
# 제품친밀도  0.4047543  1.0000000  0.6344751
# 제품적절성  0.4825335  0.6344751  1.0000000


## 상관관계 분석
product <- read.csv("product.csv", header = T, fileEncoding = "euc-kr")
str(product)
sd(product$제품_친밀도);sd(product$제품_적절성);sd(product$제품_만족도)

cor(product$제품_친밀도, product$제품_적절성)        # r = 0.4992086
cor(product$제품_친밀도, product$제품_만족도)        # r = 0.497145
cor(product$제품_적절성, product$제품_만족도)        # r = 0.7668527
cor(product, method = "pearson")                     # 피어슨 상관계수
#             제품_친밀도 제품_적절성 제품_만족도
# 제품_친밀도   1.0000000   0.4992086   0.4671450
# 제품_적절성   0.4992086   1.0000000   0.7668527
# 제품_만족도   0.4671450   0.7668527   1.0000000

# 상관계수 시각화
install.packages("corrgram")
library(corrgram)

corrgram(product)
corrgram(product, upper.panel = panel.conf)          # 위쪽에 상관계수 추가
corrgram(product, lower.panel = panel.conf)          # 아래쪽에 상관계수 추가

# 차트에 밀도곡선, 상관성, 유의확률(별표) 추가하기
install.packages("PerformanceAnalytics")
library(PerformanceAnalytics)
chart.Correlation(product, histogram = , pch = "+")


# 14장 연습문제1
library(memisc)
data.spss <- as.data.set(spss.system.file("drinking_water_example.sav"))
drinking_water_exam <- data.spss[1:7]
drinking_water_exam_df <- as.data.frame(drinking_water_exam)
str(drinking_water_exam_df)

result <- factanal(drinking_water_exam_df, factors = 2, rotation = "varimax", scores = "regression")
result$loadings                                      # Factor1 : 제품만족도 , Factor2 : 제품친밀도

colnames(result$loadings) <- c("제품만족도", "제품친밀도")

plot(result$scores[ , c(1,2)], main = "제품친밀도와 제품만족도 간 요인분석")
points(result$loadings[ , c(1,2)], pch = 19, col = "red")
text(result$loadings[ , 1], result$loadings[ , 2], labels = rownames(result$loadings), cex = 0.8, pos = 3, col = "red")
                                                     # Q1~3 / Q4~7

# 14장 연습문제2
s <- data.frame(drinking_water_exam_df$Q4, drinking_water_exam_df$Q5, drinking_water_exam_df$Q6, drinking_water_exam_df$Q7)
c <- data.frame(drinking_water_exam_df$Q1, drinking_water_exam_df$Q2, drinking_water_exam_df$Q3)

satisfaction <- round((s$drinking_water_exam_df.Q4 + s$drinking_water_exam_df.Q5 + s$drinking_water_exam_df.Q6 + s$drinking_water_exam_df.Q7) / ncol(s), 2)
closeness <- round((c$drinking_water_exam_df.Q1 + c$drinking_water_exam_df.Q2 + c$drinking_water_exam_df.Q3) / ncol(c), 2)

drinking_water_exam_factor_df <- data.frame(satisfaction, closeness)
colnames(drinking_water_exam_factor_df) <- c("제품만족도", "제품친밀도")
cor(drinking_water_exam_factor_df)
#            제품만족도 제품친밀도
# 제품만족도  1.0000000  0.4047543
# 제품친밀도  0.4047543  1.0000000















