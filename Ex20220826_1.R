df <- data.frame(x = c(1:5), y = seq(2,10,2), z = c('a','b','c','d','e'))
df
df$x
str(df) # 데이터 타입
summary(df)  # 기술통계
df[ c(2,3) ,  ]  # 행 또는 열 정보 생략시 전체를 의미(콤마는 무조건 넣기 !!)
df[ c(2,3), c(1)]
apply(df[,c(1,2)],2,sum)  # apply( 데이터프레임 , 행/열 , 1(행방향)/2(열방향) , 함수)
apply(df[,c(1,2)],1,sum)
apply(df[,c(1,2)],2,max)
x1 <- subset(df,x >= 3)  # df에서 x열이 3보다 큰 데이터를 x1에 저장
x1
y1 <- subset(df, y <= 8)
y1
xyand <- subset(df, x>=2 & y<=6)  # &(and) 연산
xyand
xyor <- subset(df, x>=2 | y<=6)  # |(or) 연산
xyor
sid <- c('A', 'B', 'C', 'D')
score <- c(90,80,70,60)
subject <- c('컴퓨터', '국어국문', '소프트웨어', '유아교육')  
student <- data.frame(sid,score,subject)  
student  
student[ , c(2,3)]  
subset(student,score>70)  
class(student)  
mode(student)
str(student)
str(student$sid)  # sid열의 구조
height <- data.frame(id = c(1,2), h = c(180,175))
weight <- data.frame(id = c(1,2), w = c(80,75))
height; weight
user <- merge(height, weight, by.x = 'id', by.y = 'id')
user

member <- list(
  name = c('홍길동', '유관순'), age = c(35,25),
  address = c('한양', '충남'), gender = c('남자', '여자'),
  htype = c('아파트', '오피스텔')
)
member
member$name
class(member)
mode(member)
member$name[1]
member$name[2]
member$age[1] <- 45  # 존재하는 변수에 대해 수정
member$id <- 'hong'  # 존재하지 않는 변수에 대해 추가
member$pwd <- '1234'
member$age <- 35
member$age <- NULL  # 삭제
member
member$name[3] <- '주재영'  # 존재하는 변수에 대해 추가
member

