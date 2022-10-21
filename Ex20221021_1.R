## 시계열분석
# 순서가 뚜렷한 시간.. / 특정 온도계의 온도 변화.. / 간격 일정.. => 정상성 시계열 !!

data("AirPassengers")
par(mfrow = c(1, 2))
ts.plot(AirPassengers)                                    # 시계열 시각화
plot(diff(AirPassengers))                                 # 차분 수행 (평균이 일정하지 않을 때 / 추세(증가, 감소)가 뚜렷할 때)

par(mfrow = c(1, 2))
plot(AirPassengers)                                       # 시계열 시각화
plot(log(AirPassengers))                                  # 로그변환 수행 (분산이 일정하지 않을 때)

par(mfrow = c(1, 1))
log <- diff(log(AirPassengers))                           # 차분 + 로그변환 수행 (평균, 분산이 일정하지 않을 때)
plot(log)                                                 # 평균, 분산 정상화

data("WWWusage")
# X11()                                                   # 개별 창 띄워서 그래프 그리기.
ts.plot(WWWusage, type = 'l', col = 'red')

data("EuStockMarkets")
EuStock <- data.frame(EuStockMarkets)
plot(EuStock$DAX[1:1000], type = 'l', col = 'red')
plot.ts(cbind(EuStock$DAX[1:1000], EuStock$SMI[1:1000]), main = "주가지수 추세선")

data <- c(45,56,45,43,69,75,58,59,66,64,62,65,
          55,49,67,55,71,78,71,65,69,43,70,75,
          56,56,65,55,82,85,75,77,77,69,79,89)
length(data)
tsdata <- ts(data, start = c(2016, 1), frequency = 12)    # 2016년 1월 ~ 2018년 12월 시계열 자료 생성.
tsdata
ts.plot(tsdata)
plot.ts(tsdata)

plot(stl(tsdata, "periodic"))                             # stl : 시계열 분해(계절, 추세, 잔차) / periodic : 주기적인
m <- decompose(tsdata)                                    # decompose : 시계열 분해(추세, 계절, 불규칙요인)
plot(m)
plot(tsdata - m$seasonal)                                 # 계절요인을 제거한 그래프
plot(tsdata - m$trend)                                    # 추세요인 제거 그래프
plot(tsdata - m$seasonal - m$trend)                       # 불규칙요인만 출력

# 자기 상관 함수
input <- c(3180,3000,3200,3100,3300,3200,
           3400,3550,3200,3400,3300,3700)
tsdata <- ts(input, start = c(2015, 2), frequency = 12)
acf(tsdata, main = "자기상관함수", col = 'red')           # 자기 상관 함수 시각화
pacf(tsdata, main = "부분 자기 상관함수", col = 'red')    # 부분 자기 상관 함수 시각화

# 추세 패턴 찾기 시각화
plot(tsdata, type = 'l', col = 'red')
plot(diff(tsdata, differences = 1))

# 시계열요소 분해법
# 평활법 (이동평균, 지수평활법)
# 이동평균 
tsdata <- ts(data, start = c(2016, 1), frequency = 12)
install.packages("TTR")
library(TTR)                                              # 이동평균법 SMA() 제공
par(mfrow = c(2,2)) 
plot(tsdata, main = "원 시계열 자료")                     # 평활 시각화
plot(SMA(tsdata, 1), main = "1년 단위 이동평균법으로 평활")
plot(SMA(tsdata, 2), main = "2년 단위 이동평균법으로 평활")
plot(SMA(tsdata, 3), main = "3년 단위 이동평균법으로 평활")



