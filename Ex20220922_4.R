# 8장 연습문제 1

data(quakes)
depthgroup <- equal.count(quakes$depth, number = 3, overlap = 0)
depthgroup
maggroup <- equal.count(quakes$mag, number = 2, overlap = 0)
maggroup

quakes$depth1[quakes$depth >= 39.5 & quakes$depth <= 139.5] <- 'd1'
quakes$depth1[quakes$depth >= 138.5 & quakes$depth <= 498.5] <- 'd2'
quakes$depth1[quakes$depth >= 497.5 & quakes$depth <= 680.5] <- 'd3'

quakes$mag1[quakes$mag >= 3.95 & quakes$mag <= 4.65] <- 'm1'
quakes$mag1[quakes$mag >= 4.55 & quakes$mag <= 6.45] <- 'm2'

str(quakes)

convert <- transform(quakes, depth1 = factor(depth1), mag1 = factor(mag1))

xyplot(lat ~ long | mag1 * depth1, data = quakes, col = c('red','blue'),
       main = 'Fiji Earthquakes', xlab = 'longitude', ylab = 'latitude')


# iris 데이터셋의 Sepal.Length(x) 와 Sepal.Width(y) 와 관계를 나타내는 
# 그래프를 그리고, 3가지 품종별로 다른 색상과 도형으로 표시(ggplot 함수 사용)

data(iris)
str(iris)

p <- ggplot(iris,aes(Sepal.Length, Sepal.Width, color = Species, shape = Species))
p + geom_point()

p1 <- ggplot(data = iris, aes(x = Sepal.Length, y = Sepal.Width))
p1 + geom_point(aes(color = Species, shape = Species))

# 품종별로 Petal.Length(x) 와 Petal.Width(y) 의 관계를 서로 다른 패널에 표시(xyplot 함수 사용)

xyplot(Petal.Width ~ Petal.Length |factor(Species), data = iris, col = c("blue", "red", "green"),
       main = "품종별 꽃잎의 길이와 너비의 관계", xlab = "꽃잎의 길이", ylab = "꽃잎의 너비")
