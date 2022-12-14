## 교차분석
# 데이터프레임 생성
getwd()
setwd('C:/bigdataR/Part3')
data <- read.csv("cleanDescriptive.csv", header = T, fileEncoding = "euc-kr")
head(data)
x <- data$level2
y <- data$pass2
result <- data.frame(Level = x, Pass = y)
dim(result)

# 교차분석
table(result)                                       # 교차 분할표

install.packages("gmodels")
library(gmodels)                                    # CrossTable() 함수 사용
library(ggplot2)
head(diamonds)

CrossTable(x = diamonds$color, y = diamonds$cut)    # cut과 color에 대한 교차 분할표
"
     Cell Contents
|-------------------------|
|                       N |
| Chi-square contribution |
|           N / Row Total |
|           N / Col Total |
|         N / Table Total |
|-------------------------|

 
Total Observations in Table:  53940 

 
               | diamonds$cut 
diamonds$color |      Fair |      Good | Very Good |   Premium |     Ideal | Row Total | 
---------------|-----------|-----------|-----------|-----------|-----------|-----------|
             D |       163 |       662 |      1513 |      1603 |      2834 |      6775 | 
               |     7.607 |     3.403 |     0.014 |     9.634 |     5.972 |           | 
               |     0.024 |     0.098 |     0.223 |     0.237 |     0.418 |     0.126 | 
               |     0.101 |     0.135 |     0.125 |     0.116 |     0.132 |           | 
               |     0.003 |     0.012 |     0.028 |     0.030 |     0.053 |           | 
---------------|-----------|-----------|-----------|-----------|-----------|-----------|
             E |       224 |       933 |      2400 |      2337 |      3903 |      9797 | 
               |    16.009 |     1.973 |    19.258 |    11.245 |     0.032 |           | 
               |     0.023 |     0.095 |     0.245 |     0.239 |     0.398 |     0.182 | 
               |     0.139 |     0.190 |     0.199 |     0.169 |     0.181 |           | 
               |     0.004 |     0.017 |     0.044 |     0.043 |     0.072 |           | 
---------------|-----------|-----------|-----------|-----------|-----------|-----------|
             F |       312 |       909 |      2164 |      2331 |      3826 |      9542 | 
               |     2.596 |     1.949 |     0.333 |     4.837 |     0.049 |           | 
               |     0.033 |     0.095 |     0.227 |     0.244 |     0.401 |     0.177 | 
               |     0.194 |     0.185 |     0.179 |     0.169 |     0.178 |           | 
               |     0.006 |     0.017 |     0.040 |     0.043 |     0.071 |           | 
---------------|-----------|-----------|-----------|-----------|-----------|-----------|
             G |       314 |       871 |      2299 |      2924 |      4884 |     11292 | 
               |     1.575 |    23.708 |    20.968 |     0.473 |    30.745 |           | 
               |     0.028 |     0.077 |     0.204 |     0.259 |     0.433 |     0.209 | 
               |     0.195 |     0.178 |     0.190 |     0.212 |     0.227 |           | 
               |     0.006 |     0.016 |     0.043 |     0.054 |     0.091 |           | 
---------------|-----------|-----------|-----------|-----------|-----------|-----------|
             H |       303 |       702 |      1824 |      2360 |      3115 |      8304 | 
               |    12.268 |     3.758 |     0.697 |    26.432 |    12.390 |           | 
               |     0.036 |     0.085 |     0.220 |     0.284 |     0.375 |     0.154 | 
               |     0.188 |     0.143 |     0.151 |     0.171 |     0.145 |           | 
               |     0.006 |     0.013 |     0.034 |     0.044 |     0.058 |           | 
---------------|-----------|-----------|-----------|-----------|-----------|-----------|
             I |       175 |       522 |      1204 |      1428 |      2093 |      5422 | 
               |     1.071 |     1.688 |     0.090 |     1.257 |     2.479 |           | 
               |     0.032 |     0.096 |     0.222 |     0.263 |     0.386 |     0.101 | 
               |     0.109 |     0.106 |     0.100 |     0.104 |     0.097 |           | 
               |     0.003 |     0.010 |     0.022 |     0.026 |     0.039 |           | 
---------------|-----------|-----------|-----------|-----------|-----------|-----------|
             J |       119 |       307 |       678 |       808 |       896 |      2808 | 
               |    14.772 |    10.427 |     3.823 |    11.300 |    45.486 |           | 
               |     0.042 |     0.109 |     0.241 |     0.288 |     0.319 |     0.052 | 
               |     0.074 |     0.063 |     0.056 |     0.059 |     0.042 |           | 
               |     0.002 |     0.006 |     0.013 |     0.015 |     0.017 |           | 
---------------|-----------|-----------|-----------|-----------|-----------|-----------|
  Column Total |      1610 |      4906 |     12082 |     13791 |     21551 |     53940 | 
               |     0.030 |     0.091 |     0.224 |     0.256 |     0.400 |           | 
---------------|-----------|-----------|-----------|-----------|-----------|-----------|
"
CrossTable(x = data$level2, y = data$pass2)         # 부모학력과 자식진학에 대한 교차 분할표
"
     Cell Contents
  |-------------------------|
  |                       N |
  | Chi-square contribution |
  |           N / Row Total |
  |           N / Col Total |
  |         N / Table Total |
  |-------------------------|
  
  
  Total Observations in Table:  225 


   | data$pass2 
   data$level2 |      실패 |      합격 | Row Total | 
  -------------|-----------|-----------|-----------|
          고졸 |        40 |        49 |        89 |         # 관측치
               |     0.544 |     0.363 |           |         # 카이제곱의 결과 (기대비율)
               |     0.449 |     0.551 |     0.396 |         # 행 비율
               |     0.444 |     0.363 |           |         # 열 비율
               |     0.178 |     0.218 |           |         # 셀 비율
  -------------|-----------|-----------|-----------|
          대졸 |        27 |        55 |        82 | 
               |     1.026 |     0.684 |           | 
               |     0.329 |     0.671 |     0.364 | 
               |     0.300 |     0.407 |           | 
               |     0.120 |     0.244 |           | 
  -------------|-----------|-----------|-----------|
      대학원졸 |        23 |        31 |        54 | 
               |     0.091 |     0.060 |           | 
               |     0.426 |     0.574 |     0.240 | 
               |     0.256 |     0.230 |           | 
               |     0.102 |     0.138 |           | 
  -------------|-----------|-----------|-----------|
  Column Total |        90 |       135 |       225 |         # 전체 관측치
               |     0.400 |     0.600 |           |         # 열 비율
  -------------|-----------|-----------|-----------|
"

## 카이제곱 검정
CrossTable(x = diamonds$cut, y = diamonds$color, chisq = T)  
"
      Cell Contents
|-------------------------|
|                       N |
| Chi-square contribution |
|           N / Row Total |
|           N / Col Total |
|         N / Table Total |
|-------------------------|

 
Total Observations in Table:  53940 

 
             | diamonds$color 
diamonds$cut |         D |         E |         F |         G |         H |         I |         J | Row Total | 
-------------|-----------|-----------|-----------|-----------|-----------|-----------|-----------|-----------|
        Fair |       163 |       224 |       312 |       314 |       303 |       175 |       119 |      1610 | 
             |     7.607 |    16.009 |     2.596 |     1.575 |    12.268 |     1.071 |    14.772 |           | 
             |     0.101 |     0.139 |     0.194 |     0.195 |     0.188 |     0.109 |     0.074 |     0.030 | 
             |     0.024 |     0.023 |     0.033 |     0.028 |     0.036 |     0.032 |     0.042 |           | 
             |     0.003 |     0.004 |     0.006 |     0.006 |     0.006 |     0.003 |     0.002 |           | 
-------------|-----------|-----------|-----------|-----------|-----------|-----------|-----------|-----------|
        Good |       662 |       933 |       909 |       871 |       702 |       522 |       307 |      4906 | 
             |     3.403 |     1.973 |     1.949 |    23.708 |     3.758 |     1.688 |    10.427 |           | 
             |     0.135 |     0.190 |     0.185 |     0.178 |     0.143 |     0.106 |     0.063 |     0.091 | 
             |     0.098 |     0.095 |     0.095 |     0.077 |     0.085 |     0.096 |     0.109 |           | 
             |     0.012 |     0.017 |     0.017 |     0.016 |     0.013 |     0.010 |     0.006 |           | 
-------------|-----------|-----------|-----------|-----------|-----------|-----------|-----------|-----------|
   Very Good |      1513 |      2400 |      2164 |      2299 |      1824 |      1204 |       678 |     12082 | 
             |     0.014 |    19.258 |     0.333 |    20.968 |     0.697 |     0.090 |     3.823 |           | 
             |     0.125 |     0.199 |     0.179 |     0.190 |     0.151 |     0.100 |     0.056 |     0.224 | 
             |     0.223 |     0.245 |     0.227 |     0.204 |     0.220 |     0.222 |     0.241 |           | 
             |     0.028 |     0.044 |     0.040 |     0.043 |     0.034 |     0.022 |     0.013 |           | 
-------------|-----------|-----------|-----------|-----------|-----------|-----------|-----------|-----------|
     Premium |      1603 |      2337 |      2331 |      2924 |      2360 |      1428 |       808 |     13791 | 
             |     9.634 |    11.245 |     4.837 |     0.473 |    26.432 |     1.257 |    11.300 |           | 
             |     0.116 |     0.169 |     0.169 |     0.212 |     0.171 |     0.104 |     0.059 |     0.256 | 
             |     0.237 |     0.239 |     0.244 |     0.259 |     0.284 |     0.263 |     0.288 |           | 
             |     0.030 |     0.043 |     0.043 |     0.054 |     0.044 |     0.026 |     0.015 |           | 
-------------|-----------|-----------|-----------|-----------|-----------|-----------|-----------|-----------|
       Ideal |      2834 |      3903 |      3826 |      4884 |      3115 |      2093 |       896 |     21551 | 
             |     5.972 |     0.032 |     0.049 |    30.745 |    12.390 |     2.479 |    45.486 |           | 
             |     0.132 |     0.181 |     0.178 |     0.227 |     0.145 |     0.097 |     0.042 |     0.400 | 
             |     0.418 |     0.398 |     0.401 |     0.433 |     0.375 |     0.386 |     0.319 |           | 
             |     0.053 |     0.072 |     0.071 |     0.091 |     0.058 |     0.039 |     0.017 |           | 
-------------|-----------|-----------|-----------|-----------|-----------|-----------|-----------|-----------|
Column Total |      6775 |      9797 |      9542 |     11292 |      8304 |      5422 |      2808 |     53940 | 
             |     0.126 |     0.182 |     0.177 |     0.209 |     0.154 |     0.101 |     0.052 |           | 
-------------|-----------|-----------|-----------|-----------|-----------|-----------|-----------|-----------|

 
Statistics for All Table Factors

                                                    
Pearson's Chi-squared test                          # 귀무가설 기각 (상관이 없다는 결론) 
------------------------------------------------------------
  Chi^2 =  310.3179     d.f. =  24     p =  1.394512e-51    
"

# 일원 카이제곱 검정
# 적합도 검정
chisq.test(c(4,6,17,16,8,9))                                
"	
  Chi-squared test for given probabilities

data:  c(4, 6, 17, 16, 8, 9)                        #1) p < 0.05 이므로 귀무가설 기각 (이 주사위는 게임에 적합하지 않다.)
X-squared = 14.2, df = 5, p-value = 0.01439         #2) 14.2 > X^2(5) = 11.071이므로 귀무가설 기각
"
chisq.test(c(9,11,12,8,9,11))                                
"	
  Chi-squared test for given probabilities

data:  c(9, 11, 12, 8, 9, 11)                       #1) p > 0.05 이므로 귀무가설 채택 (이 주사위는 게임에 적합하다.)
X-squared = 1.2, df = 5, p-value = 0.9449           #2) 1.2 < X^2(5) = 11.071이므로 귀무가설 채택
"

#선호도 분석
data <- textConnection("스포츠음료 관측도수
                       1 41
                       2 30
                       3 51
                       4 71
                       5 61
                       ")
x <- read.table(data, header = T)
x
chisq.test(x$관측도수)
"
	Chi-squared test for given probabilities

data:  x$관측도수                                   #1) p < 0.05 이므로 귀무가설 기각 (스포츠음료에 대한 선호도 차이가 있다.)
X-squared = 20.488, df = 4, p-value = 0.0003999     #2) 20.488 > X^2(4) = 9.488 이므로 귀무가설 기각
"

# 이원 카이제곱 검정
# 독립성 검정
data <- read.csv("cleanDescriptive.csv", header = T, fileEncoding = "euc-kr")
x <- data$level2
y <- data$pass2
CrossTable(x,y,chisq = T)
"
   Cell Contents
|-------------------------|
|                       N |
| Chi-square contribution |
|           N / Row Total |
|           N / Col Total |
|         N / Table Total |
|-------------------------|

 
Total Observations in Table:  225 

 
             | y 
           x |      실패 |      합격 | Row Total | 
-------------|-----------|-----------|-----------|
        고졸 |        40 |        49 |        89 | 
             |     0.544 |     0.363 |           | 
             |     0.449 |     0.551 |     0.396 | 
             |     0.444 |     0.363 |           | 
             |     0.178 |     0.218 |           | 
-------------|-----------|-----------|-----------|
        대졸 |        27 |        55 |        82 | 
             |     1.026 |     0.684 |           | 
             |     0.329 |     0.671 |     0.364 | 
             |     0.300 |     0.407 |           | 
             |     0.120 |     0.244 |           | 
-------------|-----------|-----------|-----------|
    대학원졸 |        23 |        31 |        54 | 
             |     0.091 |     0.060 |           | 
             |     0.426 |     0.574 |     0.240 | 
             |     0.256 |     0.230 |           | 
             |     0.102 |     0.138 |           | 
-------------|-----------|-----------|-----------|
Column Total |        90 |       135 |       225 | 
             |     0.400 |     0.600 |           | 
-------------|-----------|-----------|-----------|

 
Statistics for All Table Factors


Pearson's Chi-squared test 
----------------------------------------------------------   # p > 0.05 이므로 귀무가설 채택 (두 변인 간에 관련성이 없다.)
Chi^2 =  2.766951     d.f. =  2     p =  0.2507057           # 2.766 < X^2(2) = 5.991 이므로 귀무가설 채택 
"

# 동질성 검정
data <- read.csv("homogenity.csv")
summary(data)
head(data)

data$method2[data$method == 1] <- "방법1"                    # method2 필드 리코딩
data$method2[data$method == 2] <- "방법2"
data$method2[data$method == 3] <- "방법3"

data$survey2[data$survey == 1] <- "1.매우만족"               # survey2 필드 리코딩
data$survey2[data$survey == 2] <- "2.만족"
data$survey2[data$survey == 3] <- "3.보통"
data$survey2[data$survey == 4] <- "4.불만족"
data$survey2[data$survey == 5] <- "5.매우불만족"

table(data$method2, data$survey2)                             # 교차 분할표
chisq.test(data$method2, data$survey2)
"
	Pearson's Chi-squared test

data:  data$method2 and data$survey2                          # p > 0.05 이므로 귀무가설 채택 (교육방법에 따라 만족도에 차이가 없다.)
X-squared = 6.5447, df = 8, p-value = 0.5865                  # 6.5447 < X^2(8) = 15.507 이므로 귀무가설 채택
"

# 12장 연습문제1
# H0 : 교육수준과 흡연율은 관계가 없다.
# H1 : 교육수준과 흡연율은 관계가 있다.
smoke <- read.csv("smoke.csv", header = T)                    # 파일 가져오기
head(smoke)
summary(smoke)

smoke$education2[smoke$education == 1] <- "대졸"              # 코딩 변경
smoke$education2[smoke$education == 2] <- "고졸"
smoke$education2[smoke$education == 3] <- "중졸"

smoke$smoking2[smoke$smoking == 1] <- "과다흡연"
smoke$smoking2[smoke$smoking == 2] <- "보통흡연"
smoke$smoking2[smoke$smoking == 3] <- "비흡연"

table(smoke$education2, smoke$smoking2)                       # 교차 분할표

CrossTable(smoke$education2, smoke$smoking2, chisq = T)       # 독립성 검정1
"
   Cell Contents
|-------------------------|
|                       N |
| Chi-square contribution |
|           N / Row Total |
|           N / Col Total |
|         N / Table Total |
|-------------------------|

 
Total Observations in Table:  355 

 
                 | smoke$smoking2 
smoke$education2 |  과다흡연 |  보통흡연 |    비흡연 | Row Total | 
-----------------|-----------|-----------|-----------|-----------|
            고졸 |        22 |        21 |         9 |        52 | 
                 |     1.476 |     0.006 |     1.998 |           | 
                 |     0.423 |     0.404 |     0.173 |     0.146 | 
                 |     0.190 |     0.149 |     0.092 |           | 
                 |     0.062 |     0.059 |     0.025 |           | 
-----------------|-----------|-----------|-----------|-----------|
            대졸 |        51 |        92 |        68 |       211 | 
                 |     4.671 |     0.801 |     1.633 |           | 
                 |     0.242 |     0.436 |     0.322 |     0.594 | 
                 |     0.440 |     0.652 |     0.694 |           | 
                 |     0.144 |     0.259 |     0.192 |           | 
-----------------|-----------|-----------|-----------|-----------|
            중졸 |        43 |        28 |        21 |        92 | 
                 |     5.568 |     1.996 |     0.761 |           | 
                 |     0.467 |     0.304 |     0.228 |     0.259 | 
                 |     0.371 |     0.199 |     0.214 |           | 
                 |     0.121 |     0.079 |     0.059 |           | 
-----------------|-----------|-----------|-----------|-----------|
    Column Total |       116 |       141 |        98 |       355 | 
                 |     0.327 |     0.397 |     0.276 |           | 
-----------------|-----------|-----------|-----------|-----------|

 
Statistics for All Table Factors


Pearson's Chi-squared test 
------------------------------------------------------------
Chi^2 =  18.91092     d.f. =  4     p =  0.0008182573 
"
chisq.test(smoke$education2, smoke$smoking2)                  # 독립성 검정2
"
	Pearson's Chi-squared test

data:  smoke$education2 and smoke$smoking2                    # p < 0.05 이므로 귀무가설 기각 (두 변인은 서로 독립이 아니다.)
X-squared = 18.911, df = 4, p-value = 0.0008183               # 18.911 > X^2(4) = 9.488 이므로 귀무가설 기각
"

# 12장 연습문제2
# H0 : 나이와 직위는 관련이 없다.
# H1 : 나이와 직위는 관련이 있다.
data <- read.csv("cleanData.csv", header = T,                 # 파일 가져오기
                 fileEncoding = "euc-kr")
head(data)

x <- data$position                                            # 변수 리코딩
y <- data$age3

table(x,y)
plot(x,y)                                                     # 산점도를 이용하여 관련성 체크

CrossTable(x,y,chisq = T)                                     # 독립성 검정1
"
   Cell Contents
|-------------------------|
|                       N |
| Chi-square contribution |
|           N / Row Total |
|           N / Col Total |
|         N / Table Total |
|-------------------------|

 
Total Observations in Table:  208 

 
             | y 
           x |         1 |         2 |         3 | Row Total | 
-------------|-----------|-----------|-----------|-----------|
           1 |         0 |         0 |        60 |        60 | 
             |    17.019 |    18.462 |    51.343 |           | 
             |     0.000 |     0.000 |     1.000 |     0.288 | 
             |     0.000 |     0.000 |     0.706 |           | 
             |     0.000 |     0.000 |     0.288 |           | 
-------------|-----------|-----------|-----------|-----------|
           2 |         0 |        30 |        25 |        55 | 
             |    15.601 |    10.105 |     0.283 |           | 
             |     0.000 |     0.545 |     0.455 |     0.264 | 
             |     0.000 |     0.469 |     0.294 |           | 
             |     0.000 |     0.144 |     0.120 |           | 
-------------|-----------|-----------|-----------|-----------|
           3 |         0 |        23 |         0 |        23 | 
             |     6.524 |    35.827 |     9.399 |           | 
             |     0.000 |     1.000 |     0.000 |     0.111 | 
             |     0.000 |     0.359 |     0.000 |           | 
             |     0.000 |     0.111 |     0.000 |           | 
-------------|-----------|-----------|-----------|-----------|
           4 |        23 |        11 |         0 |        34 | 
             |    18.496 |     0.028 |    13.894 |           | 
             |     0.676 |     0.324 |     0.000 |     0.163 | 
             |     0.390 |     0.172 |     0.000 |           | 
             |     0.111 |     0.053 |     0.000 |           | 
-------------|-----------|-----------|-----------|-----------|
           5 |        36 |         0 |         0 |        36 | 
             |    65.127 |    11.077 |    14.712 |           | 
             |     1.000 |     0.000 |     0.000 |     0.173 | 
             |     0.610 |     0.000 |     0.000 |           | 
             |     0.173 |     0.000 |     0.000 |           | 
-------------|-----------|-----------|-----------|-----------|
Column Total |        59 |        64 |        85 |       208 | 
             |     0.284 |     0.308 |     0.409 |           | 
-------------|-----------|-----------|-----------|-----------|

 
Statistics for All Table Factors


Pearson's Chi-squared test    
---------------------------------------------------------     # p < 0.05 이므로 귀무가설 기각 (두 변인은 서로 독립이 아니다.)
Chi^2 =  287.8957     d.f. =  8     p =  1.548058e-57         # 287.9 > X^2(8) = 15.507 이므로 귀무가설 기각
"
chisq.test(x,y)                                               # 독립성 검정2
"
	Pearson's Chi-squared test

data:  x and y                                                # p < 0.05 이므로 귀무가설 기각 (두 변인은 서로 독립이 아니다.)
X-squared = 287.9, df = 8, p-value < 2.2e-16                  # 287.9 > X^2(8) = 15.507 이므로 귀무가설 기각
"

# 12장 연습문제3
# H0 : 직업 유형에 따른 응답 정도는 차이가 없다.
# H1 : 직업 유형에 따른 응답 정도는 차이가 있다.
response <- read.csv("response.csv", header = T)              # 파일 가져오기
head(response)

response$job2[response$job == 1] <- "학생"                    # 변수 리코딩
response$job2[response$job == 2] <- "직장인"
response$job2[response$job == 3] <- "주부"

response$response2[response$response == 1] <- "무응답"
response$response2[response$response == 2] <- "낮음"
response$response2[response$response == 3] <- "높음"

table(response$job2, response$response2)                      # 교차 분할표
CrossTable(response$job2, response$response2)
"
   Cell Contents
|-------------------------|
|                       N |
| Chi-square contribution |
|           N / Row Total |
|           N / Col Total |
|         N / Table Total |
|-------------------------|

 
Total Observations in Table:  300 

 
              | response$response2 
response$job2 |      낮음 |      높음 |    무응답 | Row Total | 
--------------|-----------|-----------|-----------|-----------|
         주부 |        41 |        59 |         5 |       105 | 
              |     1.306 |     6.881 |     5.786 |           | 
              |     0.390 |     0.562 |     0.048 |     0.350 | 
              |     0.293 |     0.492 |     0.125 |           | 
              |     0.137 |     0.197 |     0.017 |           | 
--------------|-----------|-----------|-----------|-----------|
       직장인 |        62 |        53 |        10 |       125 | 
              |     0.230 |     0.180 |     2.667 |           | 
              |     0.496 |     0.424 |     0.080 |     0.417 | 
              |     0.443 |     0.442 |     0.250 |           | 
              |     0.207 |     0.177 |     0.033 |           | 
--------------|-----------|-----------|-----------|-----------|
         학생 |        37 |         8 |        25 |        70 | 
              |     0.575 |    14.286 |    26.298 |           | 
              |     0.529 |     0.114 |     0.357 |     0.233 | 
              |     0.264 |     0.067 |     0.625 |           | 
              |     0.123 |     0.027 |     0.083 |           | 
--------------|-----------|-----------|-----------|-----------|
 Column Total |       140 |       120 |        40 |       300 | 
              |     0.467 |     0.400 |     0.133 |           | 
--------------|-----------|-----------|-----------|-----------|
"
chisq.test(response$job2, response$response2)                 # 동질성 검정
"
	Pearson's Chi-squared test

data:  response$job2 and response$response2                   # p < 0.05 이므로 귀무가설 기각 (직업 간에 응답의 차이가 있다.)
X-squared = 58.208, df = 4, p-value = 6.901e-12               # 58.208 > X^2(4) = 9.488 이므로 귀무가설 기각
"
