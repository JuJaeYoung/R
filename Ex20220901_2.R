# 제어문

# 연산자
# 산술연산자
num1 <- 100
num2 <- 20

result <- num1 / num2             # 나눗셈
result
result <- num1 %% num2            # 나머지
result
result <- num1 ^ 2                # 거듭제곱
result

# 관계연산자
# == EQ , != NE , > GT , < LT , >= GE , <= LE
# 결과는 참, 거짓으로!

# 논리 연산자
# & and , | or , ! not , xor() 배타적 논리합
# 결과는 참, 거짓으로!

# 조건문
# if() , ifelse(), switch(), which()
x <- 50; y <- 4; z <- x * y
if(x * y >= 40){                                            # 조건
  cat("x * y의 결과는 40 이상입니다.\n")                    # 조건이 참이면
  cat("x * y = ", z)
} else{
  cat("x * y의 결과는 40 미만입니다. x * y = ", z, "\n")    # 조건이 거짓이면
}

score <- scan()
score
result <- "노력"
if(score >= 80){
  result <- "우수"
}
cat("당신의 학점은", result, score)

ifelse(score >= 80, "우수", "노력")                      # 조건문을 함수로 구현
# 벡터데이터에서는 반복문 없이 한번에 처리 가능!

switch("name", id = "hong", name = "홍길동")             # switch(찾을 변수명, ... ) => 해당되는 변수의 값을 출력(검색)
switch("A", A = 12, B = 15, C = 11)

name <- c("kim", "lee", "park", "choi")
which(name == "lee")                                     # which(조건) => 조건을 만족하는 벡터원소의 위치(인덱스) 출력

# 반복문(for)
# 1~10 합
sum = 0
for(i in c(1:10)){
  sum = sum + i
}
cat("1~10까지 합은",sum,"입니다.")

sum = 0
n <- c(1:10)
for(i in n){
  sum = sum + i
}
cat("1~10까지 합은",sum,"입니다.")

name <- c(names(pop))                                   # names() : 데이터프레임의 열 이름 추출
name
for(i in name){
  print(i)
}

score <- c(85, 95, 98)
name <- c("홍길동", "이순신", "강감찬")

i <- 1                                                  # 인덱스
for ( s in score){                                      # score의 개수만큼 반복 
  cat(i, s, name[i], "\n")
  i <- i + 1
}

for (i in 100){
  cat(i)
}

# 반복분(while)
i <- 0
while(i < 10){
  i <- i + 1
  print(i)
}
