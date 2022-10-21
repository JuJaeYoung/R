# 삼성전자 종가 (2022.1.3 ~ 2022.9.30) 를 이용하여 신경망 model 구성하고 평가 및 특정구간 예측
#                 input                   |       output
# start                               end | 
# 1   2   3   4   5   6   7   8   9   10  | 11  12  13  14  15
# 2   3   4   5   6   7   8   9   10  11  | 12  13  14  15  16
#                  ...                    |          ...             <= learning (147개)
# 133 134 135 136 137 138 139 140 141 142 | 143 144 145 146 147
# -------------------------------------------------------------
# 1   2   3   4   5   6   7   8   9   10  | 11  12  13  14  15
#                  ...                    |          ...             <= testing (37개)
# 23  24  25  26  27  28  29  30  31  32  | 33  34  35  36  37

library(nnet)
data <- read.csv(file.choose(), header = T, fileEncoding = "euc-kr")
df <- data[nrow(data):1, 1:2]                          
rownames(df) <- c(1:nrow(df))

Pnorm <- ( (df$종가 - min(df$종가)) / (max(df$종가) - min(df$종가)) ) * 0.9 + 0.05      # 정규화
df$종가norm <- Pnorm

n80 <- round(nrow(df) * 0.8 , 0)                                                        
train <- df[1:n80, ]                                   # 훈련데이터 147개
test <- df[(n80 + 1):nrow(df), ]                       # 테스트데이터 37개

# RNN model 생성
INPUT_NODES <- 10                                      # 입력층
HIDDEN_NODES <- 10                                     # 은닉층
OUTPUT_NODES <- 5                                      # 출력층
ITERATION <- 100                                       # 학습 횟수

# 데이터셋 재구성 함수
getDataSet <- function(item, from, to, size) {
  dataframe <- NULL
  to <- to - size + 1
  for ( i in from:to ) {
    start <- i
    end <- start + size - 1
    temp <- item[c(start:end)]
    dataframe <- rbind(dataframe, t(temp))
  }
  return(dataframe)
}

# 훈련데이터셋
in_train <- getDataSet(train$종가norm, 1, 142, INPUT_NODES)               # 입력 데이터셋 
out_train <- getDataSet(train$종가norm, 11, 147, OUTPUT_NODES)            # 정답 데이터셋

# 신경망 구성
model <- nnet(in_train, out_train, size = HIDDEN_NODES, maxit = ITERATION)

# 테스트데이터셋
in_test <- getDataSet(test$종가norm, 1, 32, INPUT_NODES)                  # 입력 데이터셋
out_test <- getDataSet(test$종가norm, 11, 37, OUTPUT_NODES)               # 정답 데이터셋

# 생성된 신경망에 테스트데이터셋을 입력하여 예측값 추출
predicted_values <- predict(model, in_test, type = "raw")

# 데이터 복원해서 비교
VPredict <- (predicted_values - 0.05) / 0.9 * (max(df$종가) - min(df$종가)) + min(df$종가)   # 역변환
VReal <- getDataSet(test$종가, 11, 37, OUTPUT_NODES)                      # 종가 이므로 역변환 x

# MAPE (절대값을 비교하지 않고 백분율로 환산해서 비교.. 2/5와 2555/5675는 비슷한 비율..)
ERROR <- abs(VPredict - VReal)
MAPE <- rowMeans(ERROR / VReal) * 100                                     # 개별 행단위 평가
MAPE
mean(MAPE)                                                                # 전체 평가

# 일부 데이터 예측
in_forecasting <- df$종가norm[101:110]
predict_values <- predict(model, in_forecasting, type = "raw")
VPredicted <- (predict_values - 0.05) / 0.9 * (max(df$종가) - min(df$종가)) + min(df$종가)
VPredicted                                                                # 101 ~ 110 으로 110 ~ 115 예측
df$종가[110:115]                                                          # 실제 110 ~ 115

# 시각화
plot(81:110, df$종가[81:110], xlim = c(81,115), ylim = c(50000, 80000), type = 'o', main = "삼성전자 주가 예측")
lines(111:115, VPredicted, type = 'o', col = 'red')
abline(v = 110, col = 'blue', lty = 2)
