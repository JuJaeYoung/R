# 데이터 조작 (필터링 추출 주로 다룸)

install.packages("dplyr")
library(dplyr)
install.packages("hflights")
library(hflights)

iris %>% head()                                   # head(iris) 동일

hflights_df <- tbl_df(hflights)                   # 그리드(테이블) 형식으로 저장
hflights_df

hflights_df <- hflights %>% tbl_df()              # tbl_df(hflights) 동일

dim(hflights_df)
dim(hflights)
filter(hflights_df, Month == 1 & DayofMonth == 2)                 
                                                  # 1월 2일 데이터 필터링
hflights %>% tbl_df() %>% filter(Month == 1 & DayofMonth == 2)    
                                                  # 1월 2일 데이터 필터링 (파이프)
filter(hflights_df, Month == 1 | Month == 2)
                                                  # 1월 or 2월 데이터 필터링
hflights %>% tbl_df() %>% filter(Month == 1 | Month == 2)
                                                  # 1월 or 2월 데이터 필터링 (파이프)
arrange(hflights_df, Year, Month, DepTime, ArrTime)
                                                  # year, month, deptime, arrtime 순으로 오름차순 정렬
hflights %>% tbl_df() %>% arrange(Year, Month, DepTime, ArrTime)
                                                  # year, month, deptime, arrtime 순으로 오름차순 정렬 (파이프)

select(hflights_df, Year, Month, DepTime, ArrTime)
                                                  # year, month, deptime, arrtime 조회
hflights %>% tbl_df() %>% select(Year, Month, DepTime, ArrTime)
                                                  # year, month, deptime, arrtime 조회 (파이프)
select(hflights_df, Year:ArrTime)                 # year ~ arrtime 조회
mutate(hflights_df, gain = ArrDelay - DepDelay)   # gain 열 추가
select(mutate(hflights_df, gain = ArrDelay - DepDelay), Year, Month, gain)
                                                  # 추가된 열 조회 가능
summarise(hflights_df, avgAirTime = mean(AirTime, na.rm = T))
                                                  # 요약통계 구하기
hflights %>% tbl_df() %>% summarise(avgAirTime = mean(AirTime, na.rm = T))
                                                  # 요약통계 구하기 (파이프)
species <- group_by(iris, Species)
str(species)
species
