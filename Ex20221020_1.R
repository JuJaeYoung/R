# 랜덤 포레스트 
# 과적합 : 데이터가 특히 적을때에는 자료를 많이 학습을 하면 그 외의 문제를 풀 때 못 푸는 경우 발생. => 데이터 갯수 늘리기로 해결 => 랜덤 포레스트 방법
# 중요도 추출 가능 (어떤 자료가 가장 중요한 변수인가)

install.packages("randomForest")
library(randomForest)
data(iris)

model <- randomForest(Species ~ ., data = iris)         
model
# Call:
#  randomForest(formula = Species ~ ., data = iris) 
#                Type of random forest: classification
#                      Number of trees: 500             # 500개의 포레스트 복원 추출
# No. of variables tried at each split: 2               # 2개의 변수를 이용
# 
#         OOB estimate of  error rate: 4%
# Confusion matrix:
#            setosa versicolor virginica class.error
# setosa         50          0         0        0.00
# versicolor      0         47         3        0.06
# virginica       0          3        47        0.06

model2 <- randomForest(Species ~ ., data = iris, ntree = 300, mtry = 4, na.action = na.omit)
model2
# Call:
#  randomForest(formula = Species ~ ., data = iris, ntree = 300, mtry = 4, na.action = na.omit) 
#                Type of random forest: classification
#                      Number of trees: 300
# No. of variables tried at each split: 4
# 
#         OOB estimate of  error rate: 4.67%
# Confusion matrix:
#            setosa versicolor virginica class.error
# setosa         50          0         0        0.00
# versicolor      0         47         3        0.06
# virginica       0          4        46        0.08

model3 <- randomForest(Species ~ ., data = iris, importance = T, na.action = na.omit)
importance(model3)
                                              # 분류정확도 개선    # 노드 불순도(불확실성) 개선 
#                 setosa versicolor virginica MeanDecreaseAccuracy MeanDecreaseGini
# Sepal.Length  6.890393   8.414185  7.431290            10.741339         9.733117
# Sepal.Width   3.484569   2.229806  4.785343             5.610035         2.221070
# Petal.Length 20.507828  31.367312 27.060277            31.307045        41.810309
# Petal.Width  23.528628  32.469515 30.252760            32.861344        45.487817
# 꽃의 종류를 분류할 때 가장 크게 기여하는 변수(중요 변수)는 Petal.Width로 나타난다.

varImpPlot(model3)                                     # 중요도 시각화


# 인공신경망 : 은닉층이 많을수록 계산 수 증가. 더 정확해짐.
install.packages("nnet")
library(nnet)
df <- data.frame(x2 = c(1:6), x1 = c(6:1), y = factor(c('no','no','no','yes','yes','yes')))
model_net <- nnet(y~., df, size = 1)                   # size : 은닉층 수 / 초기 가중치가 랜덤하게 배정되기 때문에 나오는 결과값은 항상 다르다.
summary(model_net)

model_net$fitted.values
p <- predict(model_net, df, type = "class")            # 분류모델의 예측치 생성
table(p,df$y)                                          # 정확히 분류 확인.

# iris 를 활용한 인공신경망 구성
data(iris)
idx <- sample(1:nrow(iris), nrow(iris) * 0.7)
train <- iris[idx, ]
test <- iris[-idx, ]

model_iris1 <- nnet(Species ~ ., train, size = 1)      # 은닉층 1개 
summary(model_iris1)                                   # 가중치 11개
table(predict(model_iris1, test, type = "class"), test$Species)           #  train으로 훈련시간 후 test로 분류 확인
#              setosa versicolor virginica
#   setosa         14          1         0
#   versicolor      0         14         0
#   virginica       0          3        13
(14 + 14 + 13) / nrow(test)                            # 약 91.1% 적합

model_iris3 <- nnet(Species ~ ., train, size = 3)      # 은닉층 3개
summary(model_iris3)                                   # 가중치 27개
table(predict(model_iris3, test, type = "class"), test$Species)           #  train으로 훈련시간 후 test로 분류 확인
#              setosa versicolor virginica
#   setosa         14          0         0
#   versicolor      0         17         0
#   virginica       0          1        13
(14 + 17 + 13) / nrow(test)                            # 약 97.8% 적합

install.packages("neuralnet")                          # 역전파 알고리즘 사용 + 가중치 망 시각화
library(neuralnet)
data(iris)
idx <- sample(1:nrow(iris), nrow(iris) * 0.7)
train <- iris[idx, ]
test <- iris[-idx, ]

train$Species2[train$Species == 'setosa'] <- 1         # 출력변수(y)가 수치형이어야 하기 때문에 코딩 변경..
train$Species2[train$Species == 'versicolor'] <- 2
train$Species2[train$Species == 'virginica'] <- 3
train$Species <- NULL                                  # 기존 Species 칼럼 삭제
head(train)
test$Species2[test$Species == 'setosa'] <- 1
test$Species2[test$Species == 'versicolor'] <- 2
test$Species2[test$Species == 'virginica'] <- 3
test$Species <- NULL                                   # 기존 Species 칼럼 삭제
head(test)

normal <- function(x) {                                # 정규화 함수
  return ((x - min(x)) / (max(x) - min(x)))
}
train_nor <- as.data.frame(lapply(train, normal))      # lapply 함수 사용하여 train 데이터셋에 normal 함수 적용
summary(train_nor)
test_nor <- as.data.frame(lapply(test, normal))        # lapply 함수 사용하여 test 데이터셋에 normal 함수 적용
summary(test_nor) 

model_net <- neuralnet(Species2 ~ ., data = train_nor, hidden = 1)
model_net                                              # 은닉 노드 1개
plot(model_net)                                        # 시각화
model_result <- compute(model_net, test_nor[c(1:4)])   # 예측치 생성. 테스트데이터 입력(45개)
cor(model_result$net.result, test_nor$Species2)        # 상관관계 분석 = 0.9659

model_net2 <- neuralnet(Species2 ~ ., train_nor, hidden = 2, algorithm = "backprop", learningrate = 0.01)
plot(model_net2)                                       # algorithm = "backprop" : 역전파를 통해 가중치와 경계값을 조정하여 오차를 줄이기 위해
                                                       # learningrate = 0.01 : 학습비율 조정
model_result2 <- compute(model_net2, test_nor[c(1:4)])
cor(model_result2$net.result, test_nor$Species2)       # 상관관계 분석 = 0.9671
