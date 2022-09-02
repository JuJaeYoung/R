par(mfrow = c(1,1))
dotchart(chart_data, color = c("blue", "red"), lcolor = "black", pch = 6, labels = names(chart_data), xlab = "매출액", ylab = "분기별현황", main = "분기별 판매현황: 점차트 시각화", cex = 1.2)

pie(chart_data, labels = names(chart_data), col = rainbow(8), cex = 1.2, clockwise = T, main = "분기별 매출현황")
names(chart_data)
title("2018~2019년도 분기별 매출현황")

boxplot(VADeaths, range = 0)
abline(h = 37, lty = 3, col = "red")
summary(VADeaths)

quakes
x <- quakes$mag
boxplot(x, col = "red", main = "지진강도 데이터 분포")
summary(quakes)
x
