chart_data <- c(305, 450, 320, 445, 384, 350, 684, 496)
names(chart_data) <- c("2018년 1분기", "2019년 1분기", "2018년 2분기", "2019년 2분기",
                       "2018년 3분기", "2019년 3분기", "2018년 4분기", "2019년 4분기")
chart_data
barplot(chart_data, ylim = c(0,800), xlab = "분기",                         # ylim : y축 , main : 차트 제목
        ylab = "매출액", col = rainbow(8), main = "분기별 매출현황황")      # xlab : x레이블 , ylab : y레이블

barplot(chart_data, horiz = T, xlim = c(0,800), xlab = "분기",           
        ylab = "매출액", col = rainbow(8), main = "분기별 매출현황황")  

data(VADeaths)
dim(VADeaths)
str(VADeaths)
par(mfrow = c(1,2))                                            # 1행 2열 그래프 그리기
barplot(VADeaths, beside = T, col = rainbow(5), main = "미국 버지니아주 하위계층 사망비율")                # 누적 x 그래프
legend(19,71,c("50-54", "55-59", "60-64", "65-69", "70-74"), cex = 0.8, fill = rainbow(5))    # 범례
barplot(VADeaths, beside = F, col = rainbow(5), main = "미국 버지니아주 하위계층 사망비율")                # 누적 o 그래프
legend(3.8,200,c("50-54", "55-59", "60-64", "65-69", "70-74"), cex = 0.8, fill = rainbow(5))  # 범례

par(mfrow = c(1,2))  
barplot(VADeaths, beside = T, col = rainbow(5), ylim = c(0,90))
legend(19,71,c("50-54", "55-59", "60-64", "65-69", "70-74"), cex, fill = rainbow(5), ncol = 5)






























