install.packages("stringr")
library(stringr)
str_extract("홍길동35이순신45유관순25", "[1-9]{2}")  # 1~9까지 숫자 2개가 연속으로 있으면 추출한다. 제일 먼저 오는 것!
str_extract("abc123asd456qwe789", "[1-9]{2}")
string <- "abcdef123456qwer159asc751가나다12마나"
str_extract_all(string, "[a-z]{3}")  # 영어 소문자 3글자
str_extract_all(string, "[a-z]{3,}")  # 영어 소문자 3글자 이상
str_extract_all(string, "[가-힣]{2}")  # 한글 2글자
jumin <- "123456-1234567"
str_extract(jumin, "[0-9]{6}-[1234][0-9]{6}")
str1 <- "1234홍길동abc"
str1_sub <- str_sub(str1, 1, 3)  # end를 생략하면 끝까지!
str1_sub
ustr <- str_to_upper(str1)
ustr
str_to_lower(ustr)
str2 <- str_replace(str1, "홍길동", "김삿갓")
str2
str1
str_rep <- "홍길동35,이순신45,유관순25,강감찬55"
string_sp <- str_split(str_rep, ",")  # 쉼표를 구분자로 처리해서 문자열 분리
string_sp  # 벡터형식으로 문자열 저장됨.
str_join <- paste(string_sp, collapse = ",")
str_join
str_vec <- c("홍길동", "이순신", "유관순", "강감찬")
str_join2 <- paste(str_vec, collapse = ",")
str_join2


