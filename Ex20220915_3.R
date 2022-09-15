## 코딩 변경
# 원래의 용도에 맞게 변경하는 과정.

# 가독성을 위해.. (읽기 쉽게)
dataset <- read.csv("dataset.csv", header = T)
dataset2 <- subset(dataset, price >= 2 & price <= 8)
dataset2 <- subset(dataset2, age >= 20 & age <= 69)

dataset2$resident2[dataset2$resident == 1] <- '1.서울특별시'    # 새로운 변수 resident2에 resident가 1이면 서울특별시 입력 
dataset2$resident2[dataset2$resident == 2] <- '2.인천광역시'    
dataset2$resident2[dataset2$resident == 3] <- '3.대전광역시'    
dataset2$resident2[dataset2$resident == 4] <- '4.대구광역시'    
dataset2$resident2[dataset2$resident == 5] <- '5.시구군'        
dataset2[c("resident","resident2")]

dataset2$job2[dataset2$job == 1] <- '공무원'                    # 새로운 변수 job2에 job이 1이면 공무원 입력
dataset2$job2[dataset2$job == 2] <- '회사원'
dataset2$job2[dataset2$job == 3] <- '개인사업'
dataset2[c("job","job2")]

# 척도 변경을 위해..
dataset2$age2[dataset2$age <= 30] <- '청년층'                   # 새로운 변수 age2에 age가 30 이하이면 청년층 입력
dataset2$age2[dataset2$age > 30 & dataset2$age <= 55] <- '중년층'
dataset2$age2[dataset2$age > 55] <- '장년층'
dataset2[c("age","age2")]

# 자료 처리를 위해 역순으로..
survey <- dataset2$survey                                       # 만족도 코딩 결과
csurvey <- 6 - survey                                           # 역코딩
dataset2$survey <- csurvey                                      # 덮어쓰기
head(dataset2)

getwd()
new_data <- read.csv("new_data.csv", header = T, fileEncoding = "euc-kr")
new_data                                                        # 한글이 포함된 파일 불러오기 방법

## 변수 간의 관계 분석..
# 범주형 vs 범주형
resident_gender <- table(new_data$resident2, new_data$gender2)
gender_resident <- table(new_data$gender2, new_data$resident2)

barplot(resident_gender, beside = T,                            # beside : 누적
        horiz = T, col = rainbow(5),                            # horiz : 가로(T), 세로(F)
        legend = row.names(resident_gender),                    # legend : 범례로 행이름 사용
        main = '성별에 따른 거주지역 분포 현황')                # main : 제목

barplot(gender_resident, beside = T,
        horiz = T, col = rep(c(2,4),5),
        legend = c("남자","여자"), 
        main = '거주지역별 성별 분포 현황')

# 연속형 vs 범주형
install.packages("lattice")
library(lattice)

densityplot(~age, data = new_data, groups = job2,
            # plot.points = T : 밀도
            # auto.key = T : 범례
            plot.points = T, auto.key = T)

# 연속형 vs 범주형 vs 범주형
densityplot(~price | factor(gender2),                           # 성별에 따른 직급별 구매비용 분석 
            data = new_data, groups = position2,
            plot.points = T, auto.key = T)

densityplot(~price | factor(position2),                         # 직급에 따른 성별 구매비용 분석 
            data = new_data, groups = gender2,
            plot.points = F, auto.key = T)

# 연속형 vs 연속형 vs 범주형
xyplot(price~age | factor(gender2),
       data = new_data)
