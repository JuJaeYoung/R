# 인구이동 데이터를 다운로드하여 시, 군 데이터에 대하여 
# 전입이 전출보다 많은 경우 추출하여 csv파일로 저장

pop = read.csv(file.choose(), header = T, fileEncoding = "euc-kr")
pop

x <- grep("시$",pop$행정구역.시군구.별)                     # "시"로 끝나는 데이터가 들어있는 행번호 반환
y <- grep("군$", pop$행정구역.시군구.별)                    # "군"으로 끝나는 데이터가 들어있는 행번호 반환

data1 <- pop[x,c(1,5)]                                      # "시" 와 "순이동" 결합
data1

d1 <- grep("자치시$",data1$행정구역.시군구.별)              # 이미 추출한 데이터프레임(시) 중에서 위치(행번호) 조회
d1

data1 <- data1[-c(9),]                                      # 중복된 행을 제외한 모든 행을 저장
data1

data2 <- pop[y,c(1,5)]                                      # "군" 과 "순이동" 결합
data2

data <- rbind(data1,data2)                                  # "시", "군" 데이터 통합
data

dat1 <- subset(data, data[2] > 0)                            # 순이동이 양수인 부분만 반환
dat

write.csv(dat1, "C:/bigdataR/pop4.csv", row.names = F, fileEncoding = "euc-kr")
