# qplot()

install.packages("ggplot2")
library(ggplot2)

# quakes, iris, mpg, mtcars, diamonds ...

data(mpg)
help(mpg)
head(mpg)
summary(mpg)

# 한 개의 변수 대상
qplot(hwy, data = mpg)                                 # qplot(x ~ y, data)
qplot(hwy, data = mpg, fill = drv)                     # fill : 해당 범주에 서로 다른 색상 채움
qplot(hwy, data = mpg, fill = drv, binwidth = 2)       # binwidth : 넓이 
qplot(hwy, data = mpg, fill = drv, 
      binwidth = 2, facets = .~ drv)                   # 열 단위 패널 생성
qplot(hwy, data = mpg, fill = drv, 
      binwidth = 2, facets = drv ~.)                   # 행 단위 패널 생성

# 두 개의 변수 대상
qplot(displ, hwy, data = mpg)                          # qplot(x, y, data)
qplot(displ, hwy, data = mpg, color = drv)             # drv에 따라 색상 다르게 표현
qplot(displ, hwy, data = mpg, color = drv,             # 열 단위 패널 생성
      facets = .~drv)

# 미적 요소 매핑
mtcars
str(mtcars)                                            # factor : 같은 애들은 같은 그룹으로 판단하기 위해
qplot(wt, mpg, data = mtcars, color = factor(carb))    # color 
qplot(wt, mpg, data = mtcars, color = factor(carb),    # size
      size = qsec)
qplot(wt, mpg, data = mtcars, color = factor(carb),    # shape
      size = qsec, shape = factor(cyl))

# 기하학적 객체 적용
help("diamonds")
head(diamonds)
str(diamonds)

# 기본속성 : 축 1개 => 막대그래프 , 축 2개 => 산점도
# factor : 변수의 값들이 특정 기준에 의해 나누어져 있는 범주형일때 factor() 사용 !!
qplot(clarity, data = diamonds, fill = cut)                # fill : 채우기 속성
qplot(clarity, data = diamonds, fill = cut, geom = 'bar')  # 빈도수 비교 막대그래프
qplot(clarity, data = diamonds, geom = 'bar', color = cut) # color : 테두리 선
qplot(wt, mpg, data = mtcars, size = qsec, geom = "point")  
qplot(wt, mpg, data = mtcars, size = factor(qsec), geom = "point")  
qplot(wt, mpg, data = mtcars, size = qsec)
qplot(wt, mpg, data = mtcars, size = factor(cyl), color = factor(carb))
qplot(wt, mpg, data = mtcars, size = cyl, color = factor(carb))
qplot(wt, mpg, data = mtcars, size = cyl, color = carb)
qplot(wt, mpg, data = mtcars, size = cyl)
qplot(wt, mpg, data = mtcars, size = factor(cyl))
qplot(wt, mpg, data = mtcars, size = qsec, color = factor(carb), shape = factor(cyl), geom = "point")
qplot(wt, mpg, data = mtcars, geom = c("point", "smooth"), color = factor(cyl))
qplot(wt, mpg, data = mtcars, geom = c("point", "smooth"), color = cyl)
qplot(wt, mpg, data = mtcars, geom = c("line"), color = factor(cyl))
qplot(wt, mpg, data = mtcars, geom = c("line","point"), color = factor(cyl))

# ggplot()

# 미적 요소 맵핑
p <- ggplot(diamonds, aes(carat, price, color = cut))      # aes(x축변수, y축변수, color = 변수) 축설정
p + geom_point()                                           # 축설정 + 산점도

p <- ggplot(mtcars, aes(mpg, wt, color = factor(cyl)))
p + geom_point()

# 기하학적 객체 적용
p <- ggplot(mtcars, aes(mpg, wt, color = factor(cyl)))
p + geom_line()
p + geom_point()

# 미적 요소 맵핑과 기하학적 객체 적용
p <- ggplot(diamonds, aes(price))
p + stat_bin(aes(fill = cut), geom = 'bar')                # 히스토그램과 추가요인 합성 (도수분포)
p + stat_bin()                                             # 히스토그램
p + stat_bin(aes(fill = ..density..), geom = 'bar')        # 빈도를 밀도(전체의 합=1)로 스케일링 (상대도수분포)
p + stat_bin(aes(fill = cut), geom = 'area')
p + stat_bin(aes(color = cut, size = ..density..), geom = 'point')

# 산점도와 회귀선 적용
library(UsingR)
data("galton")
p <- ggplot(data = galton, aes(x = parent, y = child))     # 미적 요소 객체
p + geom_count()                                           # 숫자의 크기에 따라서 산점도를 시각화
p + geom_count() + geom_smooth(method = 'lm')              # 회귀선 적용

# ggsave()

p <- ggplot(diamonds, aes(carat, price, color = cut))
p + geom_point()

ggsave(file = "C:/bigdataR/diamond_price.pdf")

p <- ggplot(data = galton, aes(x = parent, y = child))
p <- p + geom_count() + geom_smooth(method = 'lm')

ggsave(file = "C://bigdataR/diamond.jpg", plot=p)
ggsave(file = "C://bigdataR/diamond1.jpg")
