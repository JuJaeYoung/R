# reshape2 활용

# 긴(long) 형식 -> 넓은(wide) 형식 

install.packages("reshape2")
library(reshape2)

data <- read.csv("C:/bigdataR/Part2/data.csv", header = T)
data                                                            # 긴(long) 형식 파일 불러오기

wide <- dcast(data, Customer_ID ~ Date, sum)
wide                                                            # 넓은(wide) 형식으로 변경

setwd("C:/bigdataR/Part2")
getwd()

write.csv(wide, "wide_.csv")                                    # 행이름 저장됨
write.csv(wide, "wide__.csv", row.names = F)                    # 행이름 제거 후 저장됨
wide <- read.csv("wide__.csv", header = T)
wide

colnames(wide)                                                  # 열이름 출력
colnames(wide) <- c("Customer_ID", "day1", "day2", "day3", "day4", "day5", "day6", "day7")
wide                                                            # 열이름 변경

long <- melt(wide, id = "Customer_ID")                          # 긴(long) 형식으로 변경
long

colnames(long)
colnames(long) <- c("Customer_ID","Date","Buy")
head(long)

smiths                                                          # 넓은(wide) 형식 파일 불러오기
long <- melt(smiths, id = 1:2)                                  # 긴(long) 형식으로 변경
long

dcast(long, subject + time ~ ...)                               # 넓은(wide) 형식으로 변경

airquality
str(airquality)

names(airquality) <- toupper(names(airquality))                 # 열이름 대문자로 변경
head(airquality)

air_melt <- melt(airquality, id = c("MONTH","DAY"), na.rm = T)  # "MONTH", "DAY"를 기준으로 묶는 긴(long) 형식
head(air_melt)

names(air_melt) <- tolower(names(air_melt))                     # 열이름 소문자로 변경
head(air_melt)

acast <- acast(air_melt, day ~ month ~ variable)                # 행 ~ 열 ~ 값 (3차원 구조)
acast

acast2 <- acast(air_melt, month ~ variable, sum, margins = T)   # 집합함수 적용
acast2
