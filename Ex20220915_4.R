## 파생변수

# 더미 형식으로 파생변수 생성
user_data <- read.csv("user_data.csv",header = T,fileEncoding = "euc-kr")
head(user_data)
table(user_data$house_type)
house_type2 <- ifelse(user_data$house_type == 1 |               # housetype이 1 or 2 이면 0으로 아니면 1로 변환(더미변수)
                        user_data$house_type == 2, 0, 1)        # 단독주택, 다가구 : 0, 아파트, 오피스텔 : 1
house_type2[1:10]
user_data$house_type2 <- house_type2                            # 파생변수 추가

# 1:1 관계로 파생변수 생성
pay_data <- read.csv("pay_data.csv", header = T, fileEncoding = "euc-kr")
head(pay_data,10)
table(pay_data$product_type)
product_price <- dcast(pay_data, user_id ~ product_type,        # 행 ~ 열
                       sum, na.rm = T)
head(product_price,3)                                           # 행(고객 id), 열(상품타입)
