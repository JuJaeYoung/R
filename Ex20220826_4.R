num <- scan()  # 키보드로부터 읽기
num
sum(num)
name <- scan(what = character())  # 문자열 입력
name
df <- data.frame()  # 공백 데이터프레임 생성
df <- edit(df)  # 편집기 실행해서 데이터프레임 저장
df

getwd()
setwd("C:/bigdataR/")
student <- read.table(file = "student.txt")  # 기본 구분자(생략)는 공백 또는 탭
student
names(student) <- c("번호", "이름", "키", "몸무게")  # 열이름 수정
student
student1 <- read.table(file = "student1.txt",header = T)
student1

student1 <- read.table(file.choose(), header = T)  # 대화상자 발생
student1

student2 <- read.table(file.choose(), sep = ";", header = T)  # 구분자(;)
student2

student3 <- read.table(file.choose(), header = T, na.strings = "-")
student3

student4 <- read.csv(file.choose(), na.strings = "-", sep = ",")
student4

install.packages("readxl")
library(readxl)
st_excel <- read_excel(path = "studentexcel.xlsx", sheet = "Sheet1")
st_excel

titanic <- read.csv("https://vincentarelbundock.github.io/Rdatasets/csv/COUNT/titanic.csv")
titanic

dim(titanic)  # 행렬개수
str(titanic)
table(titanic$age)
table(titanic$class)
table(titanic$survived)

head(titanic)  # 상위 6개
tail(titanic)  # 하위 6개

tab <- table(titanic$sex, titanic$survived)  # 교차 분할표
tab

barplot(tab, col = rainbow(2), main = "성별에 따른 생존 여부")  # 막대차트

getwd()
write.table(titanic, "titanic.txt", row.names = FALSE, quote = FALSE)

write.csv(titanic, "titanic.csv", row.names = F)

install.packages("writexl")
library(writexl)

write_xlsx(x = titanic, path = "titanic.xlsx", col_names = T)

pop <- read.csv(file.choose(), header = T, sep = ",")
pop

str(pop)
summary(pop)
head(pop)
tail(pop)

pop$총인구수.명.
pop$행정구역.시군구.별

# 도를 조회하여 data1 변수에 저장
# "도$" => "도"로 끝나는 정보
x <- grep("도$", pop$행정구역.시군구.별)  # 조회대상의 행번호를 벡터로 반환
x
data1 <- pop[ x , 1:5 ] # x벡터의 행번호에 해당하는 데이터 추출
data1

# 광역시를 조회하여 data2 변수에 저장

y <- grep("광역시$", pop$행정구역.시군구.별)
data2 <- pop[ y , 1:5]
data2

# 세종특별자치시를 조회하여 data3 변수에 저장

z <- grep("자치시$", pop$행정구역.시군구.별)
data3 <- pop[ z , 1:5]
data3

# 서울특별시를 조회하여 data4 변수에 저장

w <- grep("특별시$", pop$행정구역.시군구.별)
data4 <- pop[ w , 1:5 ]
data4

# 행단위 병합

newdata <- rbind(data4,data1,data2,data3)
newdata

# 행정구역, 남자인구, 여자인구

df <- newdata[ , -c(2,3)]
df

df1 <- data.frame(행정구역=newdata$행정구역.시군구.별, 남자인구=newdata$남자인구수.명., 여자인구=newdata$여자인구수.명.)
df1
getwd()
setwd("C:/bigdataR")
write.csv(newdata, "newdata.csv", row.names = F)
write.csv(df1, "df.csv", row.names = F)

play <- read.csv(file.choose(), header = T, sep = ",")
play

d1 <- grep("특별시$",play$행정구역.시군구.별)
d11 <- play[ d1, -c(2,3,6)]
d2 <- grep("도$",play$행정구역.시군구.별)
d22 <- play[ d2, -c(2,3,6)]
d3 <- grep("광역시$",play$행정구역.시군구.별)
d33 <- play[ d3, -c(2,3,6)]
d4 <- grep("자치시$",play$행정구역.시군구.별)
d44 <- play[ d4, -c(2,3,6)]

add_data <- rbind(d11, d22, d33, d44)
add_data
add_data <- data.frame(행정구역=add_data$행정구역.시군구.별, 남자인구=add_data$남자인구수.명., 여자인구=add_data$여자인구수.명.)

write.csv(add_data, "month_6.csv", row.names = F)

# 시, 군 단위 순이동이 양수인 데이터를 저장 (행정구역, 순이동)

lol <- read.csv(file.choose(), header = T, sep = ",")       # 파일 불러오기
lol
c <- grep("시$",lol$행정구역.시군구.별)
c1 <- lol[ c , c(1,5) ]

d <- grep("군$",lol$행정구역.시군구.별)
d1 <- lol[ d , c(1,5) ]

data <- rbind(c1,d1)
data

df <- subset(data, data[2]>0)
df







