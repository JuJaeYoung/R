install.packages("lattics")
library(lattice)
head(quakes)
summary(quakes$depth)

# 진앙지 깊이 그룹화
depthgroup <- equal.count(quakes$depth, number=5, overlap=0)    # 5개 구간(number)으로 겹치는 부분(overlap) 없도록
depthgroup
xyplot(lat ~ long | depthgroup, data = quakes)                  # (y ~ x | 그룹화 정보, 원본 data)

# 지진강도 그룹화
magnitudegroup <- equal.count(quakes$mag, number=2, overlap=0)  # 2개 구간으로 겹치는 부분 없도록록
magnitudegroup
xyplot(lat ~ long | magnitudegroup, data = quakes)

# 깊이와 진도를 합성해서 표현
xyplot(lat ~ long | depthgroup * magnitudegroup, data = quakes) # 합성 시 (*) 사용 

# 그룹 별 주석 입력
quakes$depth3[quakes$depth >= 39.5 & quakes$depth <= 80.5] <- 'd1'
quakes$depth3[quakes$depth >= 79.5 & quakes$depth <= 186.5] <- 'd2'
quakes$depth3[quakes$depth >= 185.5 & quakes$depth <= 397.5] <- 'd3'
quakes$depth3[quakes$depth >= 396.5 & quakes$depth <= 562.5] <- 'd4'
quakes$depth3[quakes$depth >= 562.5 & quakes$depth <= 680.5] <- 'd5'
head(quakes)

quakes$mag3[quakes$mag >= 3.95 & quakes$mag <= 4.65] <- 'm1'
quakes$mag3[quakes$mag >= 4.55 & quakes$mag <= 6.45] <- 'm2'

xyplot(lat ~ long | depth3 * mag3, data = quakes)

# depth3, mag3 str type 이라서 factor 변환
convert <- transform(quakes, depth3 = factor(depth3), mag3 = factor(mag3))
convert                                                         # 두개의 열을 factor 타입으로 변환
str(convert)

xyplot(lat ~ long | depth3 * mag3, data = convert, col = c('red', 'blue'))

# coplot 그래프는 구간 처리한 변수가 필요없음
coplot(lat ~ long | depth, data = quakes, overlap = 0.1)
coplot(lat ~ long | depth, data = quakes, number = 5, row = 1)  # 5개의 구간을 1개의 열에 그려라
coplot(lat ~ long | depth, data = quakes, number = 5, row = 1, overlap = 0.1)
coplot(lat ~ long | depth, data = quakes, number = 5, row = 1, overlap = 0.1, col = 'blue')
coplot(lat ~ long | depth, data = quakes, number = 5, row = 1, overlap = 0.1, col = 'blue', bar.bg = c(num = 'green'))
coplot(lat ~ long | depth, data = quakes, number = 5, row = 1, overlap = 0.1, col = 'blue', bar.bg = c(num = 'green'), panel = panel.smooth)

# 진도를 5개 구간으로 조건그래프
coplot(lat ~ long | mag, data = quakes, overlap = 0.1, number = 5, row = 1, col = 'blue', bar.bg = c(num = 'green'),  panel = panel.smooth)

# 3차원
cloud(depth ~ lat * long, data = quakes)                        # cloud(z ~ y * x , data) 
cloud(depth ~ lat * long, data = quakes, zlim = rev(range(quakes$depth)))
cloud(depth ~ lat * long, data = quakes, zlim = rev(range(quakes$depth)), xlab = '경도', ylab = '위도', zlab = '깊이')
cloud(depth ~ lat * long, data = quakes, zlim = rev(range(quakes$depth)), xlab = '경도', ylab = '위도', zlab = '깊이',
      panel.aspect = 0.9, screen = list(z = 45, x = -25))       # panel.aspect : 테두리 사이즈 , screen : 회전









       