age <- 36
name <- "홍길동"
names <- c("홍길동", "이순신", "유관순")
names
names[1]
names[1:2]
names[1,3]
names[2:3]
names[-2]
int <- 20
int
rm.int <- True
rm.int
rm.int = T
int.rm = T
num1 <- 20 #scalar 값 저장
str1 <- "홍길동"
bool1 <- TRUE
sum(10, 20, 30)
sum(10, 20, 30, NA)
sum(10, 20, 30, NA, na.rm = T)


is.numeric(num1)
is.character(str1)
is.logical(bool1)

x <- c(1, 2, "3")
x
result <- x * 3  # 벡터와 스칼라의 곱은 벡터
result <- as.numeric(x) * 3  # 문자를 숫자형으로 변환 후 곱셈
result
result1 <- as.integer(x) * 3
result1

mode(num1)
mode(result)
mode(str1)
mode(x)
class(x)

date1 <- as.Date("20/02/28", "%y/%m/%d")
remove(a)
remove(rm.int)
remove(int.rm)
mode(date1)
class(date1)

date2 <- "2022-08-24 10:10:10"
class(date2)
date2 <- as.Date("2022-08-24 10:10:10", "%Y-%m-%d %H:%M:%S")
date2
class(date2)

args(max)
max(10,20,30,NA)
max(10,20,30,NA,na.rm = T)

getwd()