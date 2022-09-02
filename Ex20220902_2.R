data(iris)
iris
summary(iris)
hist(iris$Sepal.Length, xlab = "iris$Sepal.Length", col = rainbow(8), main = "iris 꽃받침 길이 Histogram", xlim = c(4.3,7.9))
hist(iris$Sepal.Width, xlab = "iris$Sepal.Width", col = "mistyrose", main = "iris 꽃받침 너비 Histogram", xlim = c(2.0, 4.5))

par(mfrow = c(1,2))
# 분포 그래프
hist(iris$Sepal.Width, xlab = "iris$Sepal.Width", col = "mistyrose", main = "iris 꽃받침 너비 Histogram", xlim = c(2.0, 4.5))
# 밀도 그래프
hist(iris$Sepal.Width, xlab = "iris$Sepal.Width", col = "mistyrose", main = "iris 꽃받침 너비 Histogram", xlim = c(2.0, 4.5), freq = F)

# 꽃잎의 길이 확률밀도와 너비 확률밀도 그래프를 1행에 2개 그리기
par(mfrow = c(1,2))
hist(iris$Petal.Length, main = "꽃잎의 길이 확률밀도 Histogram", freq = F, col = "mistyrose", xlim = c(1.0,7.0), xlab = "꽃잎의 길이", ylab = "밀도")
lines(density(iris$Petal.Length), col = "red")
hist(iris$Petal.Width, main = "꽃잎의 너비 확률밀도 Histogram", freq = F, col = "mistyrose", xlim = c(0.0,2.5), xlab = "꽃잎의 너비", ylab = "밀도")
lines(density(iris$Petal.Width), col = "red")

# 정규분포 곡선과 비교
par(mfrow = c(1,1))
hist(iris$Sepal.Width, xlab = "iris$Sepal.Width", col = "mistyrose", main = "iris 꽃받침 너비 Histogram", xlim = c(2.0, 4.5), freq = F)
lines(density(iris$Sepal.Width), col = "red")
x <- seq(2.0,4.5,0.1)
curve(dnorm(x, mean = mean(iris$Sepal.Width), sd = sd(iris$Sepal.Width)), col = "blue", add = T)

summary(quakes)
x <- quakes$mag
hist(x, breaks = seq(4.0,6.5,0.5))    # breaks 계급간격 설정

# 산점도 시각화
price <- runif(10, 1, 100)
plot(price, col = "red")
par(new = T)
line_chart = 1:100
plot(line_chart, type = 'l', axes = F, ann = F)
text(70,80,"대각선 추가", col = "blue")

par(mfrow = c(2,2))
plot(price, type = "l")    # 실선
plot(price, type = "o")    # 원형과 실선
plot(price, type = "h")    # 직선
plot(price, type = "s")    # 꺾은선

par(mfrow = c(2,2))
plot(price, type = "o", pch = 5)
plot(price, type = "o", pch = 15)
plot(price, type = "o", pch = 20, col = "blue")
plot(price, type = "o", pch = 20, col = "orange", cex = 1.5)

par(mfrow = c(1,1))
plot(price, type = "o", pch = 20, col = "green", cex = 2.0, lwd = 3)


