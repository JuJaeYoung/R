# 반정형 데이터

install.packages("httr")
install.packages("XML")
library(httr)
library(XML)
library(stringr)

url <- "http://media.daum.net"
web <- GET(url)                                           # 지정된 url 에 접속해서 html 형식의 소스코드를 반환(단순 텍스트)
web

html <- htmlTreeParse(web, useInternalNodes = T, trim = T, encoding = "utf-8")
                                                          # htmlTreeParse() : url 소스 -> html 태그 파싱
                                                          # useInternalNodes : root node
                                                          # trim : 앞뒤 공백 제거
                                                          # encoding : 인코딩 방식

html
rootnode <- xmlRoot(html)                                 # 최상위 노드 찾기 (들여쓰기 수준이 제일 왼쪽에 있는 태그)
rootnode

news <- xpathSApply(rootnode, "//a[@class = 'link_txt']", xmlValue)
news                                                      # <a herf = "url" class = "link_text"> 내용 </a>
                                                          # xmlValue : 해당 tag 내용
                                                          # 해당되는 모든 노드를 탐색하여 벡터로 저장(문자열)

# 전처리 과정
news_pre <- gsub("[\r\n\t]", '', news)                    # 이스케이프 제거
news_pre <- gsub("[[:punct:]]", '', news_pre)             # 문장부호 제거
news_pre <- gsub("[[:cntrl:]]", '', news_pre)             # 특수문자 제거
#news_pre <- gsub("\\d+", '', news_pre)                   # 숫자 제거
news_pre <- gsub("[a-z]+", '', news_pre)                  # 영문자 제거
news_pre <- gsub("[A-Z]+", '', news_pre)                  # 영문자 제거
news_pre <- str_trim(news_pre)                            # 문자열의 좌우측 공백 제거
#news_pre <- gsub("\\s+", '', news_pre)                   # 2개 이상 공백 교체

news_pre                                                  # 전처리 확인(이스케이프, 특수문자, 영문, 공백)

# 파일 저장과 읽기
getwd()
setwd("C:/bigdataR")
# 행 번호까지 저장한 후 불러와서 No에 행 번호를 저장, 그 후 행번호 없이 저장하면 깔끔.
write.csv(news_pre, "news_data.csv", quote = F, fileEncoding = "euc-kr")
                                                          # quote = F : 큰따옴표 저장 x
news_data <- read.csv("news_data.csv", header = T, fileEncoding = "euc-kr")
str(news_data)
names(news_data) <- c("No","news_text")                   # 열이름 변경
news_data
news_data$news_text
write.csv(news_data, "news_final.csv", fileEncoding = "euc-kr", row.names = F)



# 코로나19 사이트(http://ncov.kdca.go.kr/)에서 < http://ncov.kdca.go.kr/tcmBoardList.do?brdId=&brdGubun=&dataGubun=&ncvContSeq=&contSeq=&board_id=140&gubun= > 번호 제목 담당 출력
covid_url <- "http://ncov.kdca.go.kr/tcmBoardList.do?brdId=&brdGubun=&dataGubun=&ncvContSeq=&contSeq=&board_id=140&gubun="
covid_web <- GET(covid_url)
covid_web
covid_html <- htmlTreeParse(covid_web, useInternalNodes = T, trim = T, encoding = "utf-8")
covid_rootnode <- xmlRoot(covid_html)
covid_data <- xpathSApply(covid_rootnode, "//td[@class = 'm_dp_n']", xmlValue) # 번호, 담당, 첨부
covid_num <- covid_data[c(1,4,7,10,13,16,19,22,25,28)]
covid_num        # 번호
covid_dep <- covid_data[c(2,5,8,11,14,17,20,23,26,29)]
covid_dep        # 부서
covid_topic <- xpathSApply(covid_rootnode, "//a[@class = 'bl_link']", xmlValue) # 제목
covid_topic
covid <- cbind(covid_num, covid_topic, covid_dep)
covid
write.csv(covid, "covid.csv", fileEncoding = "euc-kr", row.names =F)
covid1 <- read.csv("covid.csv", header = T, fileEncoding = "euc-kr")
covid1
names(covid1) <- c("No", "Title", "Departments")
write.csv(covid1, "covid.csv", fileEncoding = "euc-kr", row.names =F)

# 교수님 풀이
url <- "http://ncov.kdca.go.kr/tcmBoardList.do?brdId=&brdGubun=&dataGubun=&ncvContSeq=&contSeq=&board_id=140&gubun="
web <- GET(url)
html <- htmlTreeParse(web, useInternalNodes = T, trim = T, encoding = "utf-8")
rootnode <- xmlRoot(html)
covid_num <- xpathSApply(rootnode, "//div[@class='board_list']//tbody/tr/td[1]", xmlValue)  # 번호
covid_num
covid_part <- xpathSApply(rootnode, "//div[@class='board_list']//tbody/tr/td[3]", xmlValue)  # 부서
covid_part
covid_subject <- xpathSApply(rootnode, "//a[@class='bl_link']", xmlValue)  # 제목
covid_subject
covid_date <- xpathSApply(rootnode, "//div[@class='board_list']//tbody/tr/td[4]", xmlValue)  # 날짜
covid_date
covid1 <- data.frame(번호=covid_num, 제목=covid_subject, 담당=covid_part, 날짜=covid_date)
covid1
write.csv(covid1, "covid1.csv", fileEncoding = "euc-kr", row.names =F)



# 반복문을 이용하여 1~10페이지의 내용 받아서 저장
df <- data.frame(번호=NULL, 제목=NULL, 담당=NULL, 날짜=NULL)  # 공백 데이터프레임
for ( x in c(1:10) ) {
  url <- paste("http://ncov.kdca.go.kr/tcmBoardList.do?pageIndex=", x,"&brdId=&brdGubun=&board_id=140&search_item=1&search_content=",sep = '')       
  web <- GET(url)            # paste : 문자열 합치는 함수 (기본적으로 ','가 있으면 공백 끼워서 붙임. 그래서 sep 역할은 붙일때 사이에 뭘 넣을지)
  html <- htmlTreeParse(web, useInternalNodes = T, trim = T, encoding = "utf-8")
  rootnode <- xmlRoot(html)
  covid_num <- xpathSApply(rootnode, "//div[@class='board_list']//tbody/tr/td[1]", xmlValue)   # 번호
  covid_part <- xpathSApply(rootnode, "//div[@class='board_list']//tbody/tr/td[3]", xmlValue)  # 부서
  covid_subject <- xpathSApply(rootnode, "//a[@class='bl_link']", xmlValue)                    # 제목
  covid_date <- xpathSApply(rootnode, "//div[@class='board_list']//tbody/tr/td[4]", xmlValue)  # 날짜
  subdf <- data.frame(번호=covid_num, 제목=covid_subject, 담당=covid_part, 날짜=covid_date)    # 10개 분량의 데이터프레임
  df <- rbind(df, subdf)                                                                       # df는 계속 누적됨
}
write.csv(df, "covidall.csv", fileEncoding = "euc-kr", row.names =F)



# 옥션 웹크롤링
searchName <- URLencode("노트북")                                                              # 한글이 포함된 url 처리
url <- paste("http://browse.auction.co.kr/search?keyword=", searchName, "&itemno=&nickname=&frm=hometab&dom=auction&isSuggestion=No&retry=&Fwk=", searchName,"&acode=SRP_SU_0100&arraycategory=&encKeyword=", searchName, "&t=a&v=l",sep = '')
web <- GET(url)
web
html <- htmlTreeParse(web, useInternalNodes = T, trim = T, encoding = "utf-8")
rootnode <- xmlRoot(html)
productname <- xpathSApply(rootnode, "//span[@class='text--title']", xmlValue)                 # 제품명
productname
productprice <- xpathSApply(rootnode, "//strong[@class='text--price_seller']", xmlValue)       # 제품가격
productprice <- gsub(",","",productprice)                                                      # 쉼표 제거
df <- data.frame(제품명 = productname, 제품가격 = productprice)
df
write.csv(df, "action.csv", fileEncoding = "euc-kr", row.names =F)




# XML 크롤링 (html보다 수월)
# 지역별 미세먼지 농도 비교
url <- "http://apis.data.go.kr/B552584/ArpltnInforInqireSvc/getCtprvnRltmMesureDnsty?serviceKey=0uuaPjQbs%2FRCdG%2Bh5QlzEBaj6wN%2BnsL5VcXumGqV1ivEno2vEZea4lFnilY2Nd4P72eIa17%2B6jFJyKBpeFor7g%3D%3D&returnType=xml&numOfRows=100&pageNo=1&sidoName=%EC%B6%A9%EB%B6%81&ver=1.0"
xmlfile <- xmlParse(url)   # 파서를 이용하여 저장
df <- xmlToDataFrame(getNodeSet(xmlfile, "//item"))  # 반복탐색하면서 item 내용을 저장
df
stationName <- df$stationName
pm10Value <- as.numeric(df$pm10Value)  # 숫자형으로 변환 (없는 수치는 NA로 저장)
barplot(pm10Value, names.arg = stationName, col = rainbow(7))  

# 시간대별 복대동 미세먼지 
url = "http://apis.data.go.kr/B552584/ArpltnInforInqireSvc/getMsrstnAcctoRltmMesureDnsty?serviceKey=0uuaPjQbs%2FRCdG%2Bh5QlzEBaj6wN%2BnsL5VcXumGqV1ivEno2vEZea4lFnilY2Nd4P72eIa17%2B6jFJyKBpeFor7g%3D%3D&returnType=xml&numOfRows=10&pageNo=1&stationName=%EB%B3%B5%EB%8C%80%EB%8F%99&dataTerm=DAILY&ver=1.0"
xmlfile <- xmlParse(url)
df <- xmlToDataFrame(getNodeSet(xmlfile, "//item"))
df
dataTime <- df$dataTime
#dataTime <- substr(dataTime, 12, 16)
dataTime
pm10Value <- as.numeric(df$pm10Value)
barplot(pm10Value, names.arg = str_sub(dataTime,12), col = rainbow(10))  # 결측치 제외

pm10Value <- ifelse(!is.na(pm10Value), pm10Value, round(mean(pm10Value, na.rm = T),0))
barplot(pm10Value, names.arg = str_sub(dataTime,12), col = rainbow(10))  # 결측치 평균값으로 대체



# 단어 구름 시각화(wordcloud)
install.packages("wordcloud")
library(wordcloud)
word <- c("서울","부산","대구")  # 항목(문자열)
freq <- c(300, 230, 150)  # 빈도수(정수)
pal <- brewer.pal(12,"Paired")
wordcloud(word, freq,random.order = F, random.color = F, colors = pal, )

# 전입이 많은 지역을 wordcloud 로 표현(시, 군 단위)
# 1
data <- read.csv(file.choose(), fileEncoding = "euc-kr", header = T)
head(data)
x <- grep("시$", data$행정구역.시군구.별)                   # 시 추출
data1 <- data[ x , ]
data1$행정구역.시군구.별

x <- grep("군$", data$행정구역.시군구.별)                   # 군 추출
data2 <- data[ x , ]
data2$행정구역.시군구.별

data3 <- rbind(data1, data2)                                # 시 + 군
data3$행정구역.시군구.별

d1 <- grep("자치시$",data3$행정구역.시군구.별)              # 이미 추출한 데이터프레임(시) 중에서 위치(행번호) 조회 => 8, 9
d1
data3 <- data3[-c(9),]                                      # 세종 1개 제외
data3$행정구역.시군구.별

data4 <- subset(data3, data3[5] > 0)                        # 순이동이 0보다 큰 경우 추출
word <- data4$행정구역.시군구.별
freq <- data4$순이동.명.
freq
wordcloud(word, freq, random.order = F, random.color = F, colors = pal)

# 2 (df 이용)
df <- data.frame(지역=word, 빈도수=freq)
View(df)

install.packages("wordcloud2")
library(wordcloud2)
wordcloud2(df)
