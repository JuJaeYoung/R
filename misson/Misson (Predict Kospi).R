# 코스피 2022.01 ~ 2022.06 시계열 분석
#             input             |     output
# start                     end | 
# 1  2  3  4  5  6  7  8  9  10 | 11 12 13 14 15
# 2  3  4  5  6  7  8  9  10 11 | 12 13 14 15 16
#             ...               |       ...             <= learning (97개)
# 83 84 85 86 87 88 89 90 91 92 | 93 94 95 96 97 
# ----------------------------------------------
# 1  2  3  4  5  6  7  8  9  10 | 11 12 13 14 15
#             ...               |       ...             <= testing (24개)
# 10 11 12 13 14 15 16 17 18 19 | 20 21 22 23 24

library(nnet)
data <- read.csv(file.choose(),header = T, fileEncoding = "euc-kr")
head(data)
str(data)
data$종가 <- as.numeric(data$종가)                      # 숫자형 형변환
df <- data.frame(일자 = data$일자, 종가 = data$종가)
df <- df[order(df$일자) , ]                             # 일자 기준 오름차순 정렬 
rownames(df) <- c(1:121)                                # 열이름 수정

Pnorm <- ((df$종가 - min(df$종가)) / (max(df$종가) - min(df$종가))) * 0.9 + 0.05   # 0.05 ~ 0.95 정규화 
Pnorm
df <- cbind(df, 종가norm = Pnorm)
df

n80 <- round(nrow(df) * 0.8, 0)                         # 80% 마지막 인덱스
df.learning <- df[1:n80 , ]                             # 학습데이터
df.testing <- df[(n80+1):nrow(df), ]                    # 테스트데이터

# RNN model 생성
INPUT_NODES <- 10                                       # 입력층
HIDDEN_NODES <- 10                                      # 은닉층
OUTPUT_NODES <- 5                                       # 출력층
ITERATION <- 100                                        # 학습 횟수

# 데이터셋 재구성 함수
getDataSet <- function(item, from, to, size) {          # ex : (df.learning$종가norm, 1, 50, 10) (df.testing$종가norm, 11, 97, 5)
  dataframe <- NULL
  to <- to - size + 1
  for ( i in from:to ) {                                # size 분량 벡터 생성
    start <- i
    end <- start + size - 1
    temp <- item[c(start:end)]                          # 행단위 데이터
    dataframe <- rbind(dataframe, t(temp))
  }
  return(dataframe)
}

# 훈련 데이터셋
in_learning <- getDataSet(df.learning$종가norm, 1, 92, INPUT_NODES)       # 입력 데이터셋
out_learning <- getDataSet(df.learning$종가norm, 11, 97, OUTPUT_NODES)    # 정답 데이터셋

# 신경망 구성
model <- nnet(in_learning, out_learning, size = HIDDEN_NODES, maxit = ITERATION)

# 테스트 데이터셋
in_testing <- getDataSet(df.testing$종가norm, 1, 19, INPUT_NODES)         # 입력 데이터셋
out_testing <- getDataSet(df.testing$종가norm, 11, 24, OUTPUT_NODES)      # 정답 데이터셋

# 생성된 신경망에 테스트데이터를 입력해서 예측값 추출
predicted_values <- predict(model, in_testing, type = "raw")

# 데이터 복원해서 비교
VPredicted <- (predicted_values - 0.05) / 0.9 * (max(df$종가) - min(df$종가)) + min(df$종가)
VReal <- getDataSet(df.testing$종가, 11, 24, OUTPUT_NODES)                # 역변환 필요 없음

# MAPE (절대값을 비교하지 않고 백분율로 환산해서 비교.. 2/5와 2555/5675는 비슷한 비율..)
ERROR <- abs(VReal - VPredicted)
MAPE <- rowMeans(ERROR / VReal) * 100                                     # 개별 행단위 평가
MAPE                                                                      
mean(MAPE)                                                                # 전체 평가


# 일부 데이터 예측 (10개를 추출해서 다음 5개 예측)
in_forecasting <- df$종가norm[91:100]

predicted_values5 <- predict(model, in_forecasting, type = "raw")
VPredicted5 <- (predicted_values5 - 0.05) / 0.9 * (max(df$종가) - min(df$종가)) + min(df$종가)
VPredicted5                                                               # 91 ~ 100 으로 101 ~ 105 예측
df$종가[101:105]                                                          # 실제 101 ~ 105

# 시각화
plot(71:100, df$종가[71:100], xlim = c(71,105), ylim = c(1000, 3300), type = 'o', main = "코스피 지수 예측")  # 오리지널
lines(101:105, VPredicted5, type = 'o', col = 'red')                      # 예측값
abline(v = 100, col = 'blue', lty = 2)                                    # 수직선 그리기
