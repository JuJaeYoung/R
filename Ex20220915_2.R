# EDA 
#
#

dataset <- read.csv("dataset.csv", header = T)                  # 데이터 불러오기
dataset

print(dataset)                                                  # 콘솔창 출력
View(dataset)                                                   # 새로운 뷰어창 출력
head(dataset)                                                   # 상위 6개
tail(dataset)                                                   # 하위 6개

attributes(dataset)                                             # names(열), row.names(행), class
str(dataset)                                                    # 자료구조, 관측치와 변수 개수
summary(dataset)                                                # 기술통계량

dataset$age                                                     # 데이터 셋에서 age 변수값 출력
dataset$resident                                                # 데이터 셋에서 resident 변수값 출력
length(dataset$age)                                             # age 데이터 수 확인

x <- dataset$gender
y <- dataset$price

plot(dataset$price)                                             # plot함수 : y축이 기본, x축은 index(도수)로 지정

dataset["gender"]
dataset$gender
dataset[2]
dataset[ , 2]
dataset[ , c(2, 4:6, 3, 1)]
dataset[c(2:4), ]

## 결측치 처리

#1 결측치 제거
summary(dataset$price)                                          # 결측치 확인 방법
sum(dataset$price, na.rm = T)                                   # 결측치 빼고 합계
price2 <- na.omit(dataset$price)                                # 결측치 제거
sum(price2)                                                     # 결측치 제거 후 합계

#2 0 으로 대체
x <- dataset$price
dataset$price_0 <- ifelse(is.na(x),0,x)                         # x에서 na이면 0으로, 아니면 x값 (새로운 열 추가)
dataset$price_0 <- ifelse(!is.na(x),x,0)                        # x에서 na가 아니면 x값, na이면 0으로 (새로운 열 추가)

#3 평균값으로 대체
m <- round(mean(x, na.rm = T),2)                                # 소수 둘째자리 반올림한 평균
dataset$price_mean <- ifelse(!is.na(x),x,m)                     # x에서 na가 아니면 x값, na이면 평균값으로 (새로운 열 추가)         

dataset[1:50, c("price","price_0","price_mean")]                # 확인

## 극단치 처리

#1 범주형 변수 극단치 처리
table(dataset$gender)

dataset <- subset(dataset, gender == 1 | gender == 2)           # 성별 1 또는 2 부분집합
dataset
length(dataset$gender)
pie(table(dataset$gender))

#2 연속형 변수의 극단치 처리
dataset <- read.csv("dataset.csv", header = T)

summary(dataset$price)
dataset2 <- subset(dataset, price >= 2 & price <= 8)            # 가격 2 이상 8 이하 부분집합
stem(dataset2$price)

summary(dataset2$age)                                           # 251개 (NA 16개 포함)
dataset2 <- subset(dataset2, age >= 20 & age <= 69)             # 나이 20 이상 69 이하 부분집합 (결측치 제거 가능)
length(dataset2$age)                                            # 235개 (NA 제거)

boxplot(dataset2$age, col = "red")                              # 정제된 age 분포 확인
boxplot(dataset$price)                                          # 극단치 확인
boxplot(dataset$price)$stats                                    # 최소,1사,중앙,3사,최대 값 출력
dataset_sub <- subset(dataset,price >= 2.1 & price <= 7.9)      # 정상범위 확인 후 정제
summary(dataset_sub$price)
