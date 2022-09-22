# 지도 공간 시각화

library(ggplot2)
install.packages("ggmap")
library(ggmap)

seoul <- c(left = 126.77, bottom = 37.40,
           right = 127.17, top = 37.70)
map <- get_stamenmap(seoul, zoom = 12, maptype = 'terrain')
ggmap(map)

pop <- read.csv(file.choose(), header = T, fileEncoding = "euc-kr")

library(stringr)
pop
region <- pop$지역명
lon <- pop$LON
lat <- pop$LAT
tot_pop <- as.numeric(str_replace_all(pop$총인구수, ',', ''))
                                          # 총인구수 열에 ','를 빼고 그 사이를 공백으로 대체.
                                          # 수치형으로 변환.
df <- data.frame(region, lon, lat, tot_pop)
df
df <- df[1:17,]                           # 전체 통계 제외

daegu <- c(left = 123.4423013, bottom = 32.8528306,
           right = 131.601445, top = 38.8714354)
map <- get_stamenmap(daegu, zoom = 7, maptype = 'watercolor')
layer1 <- ggmap(map)
layer1                                    # 지도 그리기
layer2 <- layer1 + geom_point(data = df, aes(x = lon, y = lat, color = factor(tot_pop), size = factor(tot_pop)))
layer2                                    # 지도 위에 포인트 추가
                                          # x축(위도), y축(경도)
                                          # factor : 고유의 특성을 나타낼 때 사용 !!
                                          # 고유의 값을 그대로 사용할 때 !!
layer3 <- layer2 + geom_text(data = df, aes(x = lon + 0.01, y = lat + 0.08,
                                            label = region), size = 3)
layer3

ggsave("C:/bigdataR/pop201901.png", scale = 1, width = 10.24, height = 7.68)
