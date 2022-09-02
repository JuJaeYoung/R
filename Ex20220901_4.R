n <- 1000
x <- rnorm(n, mean = 0, sd = 1)     # 정규분포 난수
hist(x)
plot(x)
y <- runif(n,0,10)                  # 균등분포 난수
hist(y)
plot(y)

set.seed(123)                       # seed 는 임의의 정수 사용
rnorm(5,0,1)                        # seed 정의 후 추출하면 같은 값 나옴 (매번 갱신해줘야 함)

set.seed(12)
runif(5,0,10)

x <- matrix(1:9,nrow = 3,byrow = T)
y <- matrix(1:3,nrow = 3)
x
y
t(x)                                # 전치행렬 
cbind(x,1:3)                        # 열방향 결합
rbind(x,10:12)                      # 행방향 결합
diag(x)                             # 대각행렬
det(x)                              # 행렬식
apply(x,1,sum)


