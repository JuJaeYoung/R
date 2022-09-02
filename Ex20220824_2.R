c(1:20)
1:20
c(1:40)
seq(1,10,2) # start, stop, step
seq(1,100,2)
rep(1:3,3) # range, times
rep(1:3, each = 3)

x <- c(1, 3, 5, 7)
y <- c(3, 5)
union(x,y)  # 합집합
setdiff(x,y)  # 차집합
intersect(x,y)  # 교잽합
x;y
age <- c(30,35,40)
names(age) <- c("홍길동", "이순신", "강감찬")
age
age <- NULL  # 변수 초기화


a <- c(1:50)
a
a[10:45]
a[19:length(a)-5]  # 첨자 연산 가능


a[1,2]  # 첨자는 1차원만 가능
v1 <- c(13, -5, 20:23, 12, -2:3)
v1
v1[1]
v1[c(2,4)]
v1[c(3:5)]
v1[c(4,5:8,7)]
v1[-1]  #1번째 데이터 제외
v1[c(-1)]
v1[-c(2,4)]
v1[-c(1)]

m <- matrix(1:10)  # 10행 1열
m
m <- matrix(c(1:10), nrow = 2)  # 2행 5열 - 열우선
m
m <- matrix(c(1:10),nrow = 2, byrow = T)  # 2행 5열 - 행우선
m

x1 <- c(5, 40, 50:52)
x2 <- c(30, 5, 6:8)
mr <- rbind(x1, x2)
mr

mc <- cbind(x1, x2)
mc

m3 <- matrix(10:19,2)
m3
m4 <- matrix(10:20,2)
mode(m3)
class(m3)
m3[1,]  # 1행 열모두
m3[,5]  # 행모두 5열
m3[2,3]  # 2행 3열
m3[1,c(2:5)]  # 1행 2,3,4,5열
x <- matrix(c(1:9), nrow=3, ncol = 3)
x

# apply : 함수를 지정하여 행단위 또는 열단위 각각 계산된 값 출력력

apply(x, 1, max)  # 행별 최댓값
apply(x,2,max)  # 열별 최댓값
apply(x, 1, mean)  # 행별 평균
apply(x, 2, mean)  # 열별 평균균
apply(x,1,min)  # 행별 최솟값
apply(x, 2, min)  # 열별 최솟값

length(x)
ncol(x)
nrow(x)

f1 <- function(num){
  num * 2
}

f1(10)
f1(c(1,2,3))
f1(matrix(c(1:6),nrow = 2))

f2 <- function(x){   # 사용자 정의 함수
  x * c(1, 2, 3)
  }
result <- f2(1)
result
result <- apply(x, 2, f2)
result
result <- apply(x, 1, f2)
result

vec <- c(1:12)
arr <- array(vec, c(3, 2, 2))  # 3행 2열 2개 면
arr

arr[1,1,2]
arr[,,1]
arr[,,2]

no <- c(1, 2, 3)
name <- c("hong", "lee", "kim")
pay <- c(150, 250, 300)
vemp <- data.frame(No = no, Name = name, Pay = pay)  # data.frame(이름 = 변수, 이름 = 변수 , ...) 
vemp

getwd()
setwd("C:/bigdataR")
getwd()

csvtemp <- read.csv('emp.csv', header = T)
csvtemp

name <- c("사번", "이름", "급여")
csv2 <- read.csv('emp2.csv', header = F, col.names = name)
csv2
csv2$사번
csv2$이름  # 컬럼명 참조($ 사용)
csv2$급여

str(csv2)  # 데이터프레임 구조
ncol(csv2)  # 열갯수
nrow(csv2)  # 행갯수
names(csv2) 
csv2[3,2]
csv2[c(3),c(2)]
summury(csv2)
summary(csv2)

