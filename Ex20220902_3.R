x <- c(1,2,3,4,2,4)
y <- rep(2,6)
table(x,y)    # 교차 테이블 작성
plot(x, y)
xy.df <- as.data.frame(table(x,y))    # 테이블 활용 데이터프레임 생성
xy.df
plot(x, y, pch = "@", col = "blue", cex = 0.5 * xy.df$Freq,    # pch : 기호 넣기 가능 , cex : 크기 지정 연산 가능
     xlab = "x벡터 원소", ylab = "y벡터 원소")

install.packages("UsingR")
library(UsingR)
data(galton)
galton

table(galton)
galtonData <- as.data.frame(table(galton$child, galton$parent))
head(galtonData)
names(galtonData) = c("child", "parent", "freq")
parent <- as.numeric(galtonData$parent)    # factor -> numeric
parent
child <- as.numeric(galtonData$child)    # factor -> numeric
child

plot(parent, child, pch = 21, col = "blue", bg = "green",
     cex = 0.2 * galtonData$freq)

# 변수 간의 비교 시각화
head(iris)
pairs(iris[iris$Species == "virginica", 1:4])     # iris[행, 열]
pairs(iris[iris$Species == "setosa", 1:4])

install.packages("scatterplot3d")
library(scatterplot3d)

iris_setosa <- iris[iris$Species == "setosa",]
iris_versicolor <- iris[iris$Species == "versicolor",]
iris_virginica <- iris[iris$Species == "virginica",]
d3 <- scatterplot3d(iris$Petal.Length, iris$Sepal.Length, iris$Sepal.Width, type = 'n')
d3$points3d(iris_setosa$Petal.Length,iris_setosa$Sepal.Length, iris_setosa$Sepal.Width, bg = "orange", pch = 21)
d3$points3d(iris_versicolor$Petal.Length,iris_versicolor$Sepal.Length, iris_versicolor$Sepal.Width, bg = "blue", pch = 23)
d3$points3d(iris_virginica$Petal.Length,iris_virginica$Sepal.Length, iris_virginica$Sepal.Width, bg = "green", pch = 25)

x <- seq(10, 20)
y <- seq(1, 11)
plot(y, x)


# iris 의 꽃받침 너비(x)와 꽃잎 너비(y)를 비교하는 그래프
# 그래프에 사용되는 데이터타입은 반드시 숫자형이어야 함.

str(iris)
plot(iris$Sepal.Width, iris$Petal.Width)
















