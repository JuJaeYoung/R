# 정형과 비정형 데이터 처리
# https://jdk.java.net/archive/ => 11 GA 다운
# mairadb.com => 10.6.10-GA / MS windows(64bit) 다운 => 설치 중 root (bigdatar) 비번 / UTF-8 check
# www.mysql.com => connector/J => Archive 5.1.49 => zip 다운 => 폴더안 5.1.49.jar 파일만 !
# mariadb prompt - mysql -u root -p

install.packages("rJava")
install.packages("DBI")
install.packages("RJDBC")

Sys.setenv(JAVA_HOME = "C:\\bigdataR\\jdk-11")
library(DBI)
library(rJava)
library(RJDBC)

drv <- JDBC(driverClass = "com.mysql.jdbc.Driver", "C:\\bigdataR\\mysql-connector-java-5.1.49.jar")

conn <- dbConnect(drv, "jdbc:mysql://127.0.0.1:3306/work", "scott", "tiger")

query <- "select * from goods"
goodsAll <- dbGetQuery(conn, query)                 # 지정된 디비에 접속해서 쿼리실행 후 결과 반환
goodsAll
str(goodsAll)

query <- "select * from goods where su >= 3"        # 수량이 3보다 큰 모든 행
goodsAll <- dbGetQuery(conn, query)
goodsAll

query <- "select * from goods order by dan desc"    # 단가를 기준으로 내림차순
goodsAll <- dbGetQuery(conn, query)
goodsAll

# goods1 테이블 생성
insert.df <- data.frame(code = 5, name = '식기세척기', su = 1, dan = 250000)
dbWriteTable(conn, "goods1", insert.df)             # 데이터프레임을 이용한 일괄입력

query <- "select * from goods1"
goodsAll <- dbGetQuery(conn, query)
goodsAll

# goods2 테이블 생성(외부 데이터)
recode <- read.csv("C:/bigdataR/Part2/recode.csv", fileEncoding = "euc-kr")
dbWriteTable(conn, "goods2", recode)                # 연결된 db에 테이블 작성
query <- "select * from goods2"
goodsAll <- dbGetQuery(conn, query)                 # 연결된 db에서 쿼리를 얻어오기
goodsAll

# goods2 테이블에 행 추가
query <- "insert into goods2 values(6, 'test', 1, 1000)"
dbSendUpdate(conn, query)                           # 연결된 db에 추가
query <- "select * from goods2"
goodsAll <- dbGetQuery(conn, query)                
goodsAll

# goods2 테이블 레코드 수정
query <- "update goods2 set name = '테스트' where code = 6"
dbSendUpdate(conn, query)                           # goods2 테이블에서 code가 6인 name을 '테스트'로 변경
query <- "select * from goods2"
goodsAll <- dbGetQuery(conn, query)                
goodsAll

# goods2 테이블 레코드 삭제
delquery <- "delete from goods2 where code = 6"     # goods2 테이블에서 code가 6인 행 삭제
dbSendUpdate(conn, delquery)
query <- "select * from goods2"
goodsAll <- dbGetQuery(conn, query)                
goodsAll

#misson 각 문법이 실행될 때마다 전체 테이블 조회..
#1 code 6, 단가 200000 "청소기" 2개를 추가
#2 단가 600000 보다 큰 상품에 대해 수량을 5 로 수정
#3 수량이 1 인 상품을 삭제

#1
addquery <- "insert into goods2 values(6, '청소기', 2, 200000)"
dbSendUpdate(conn, addquery)
query1 <- "select * from goods2"
goodsAll1 <- dbGetQuery(conn, query1)
goodsAll1

#2
upquery <- "update goods2 set su = 5 where dan > 600000"
dbSendUpdate(conn, upquery)
query2 <- "select * from goods2"
goodsAll2 <- dbGetQuery(conn, query2)
goodsAll2

#3
delquery <- "delete from goods2 where su = 1"
dbSendUpdate(conn, delquery)
query3 <- "select * from goods2"
goodsAll3 <- dbGetQuery(conn, query3)
goodsAll3

# 특정 문자로 시작하거나 끝나는 문자열 조회(like, % 사용) - % : 어떤 문자열이 오든 상관 x
query <- "select * from goods2 where name like '%기'"   # 기로 끝나는 문자열 조회
goodsAll <- dbGetQuery(conn, query)                
goodsAll

# 일부 열의 데이터만 추가   # ↓원래 열 순서와 동일하면 생략 가능!
query <- "insert into goods2 (code, name) values(7, '안마의자')"
dbSendUpdate(conn, query)
query <- "select * from goods2"
goodsAll <- dbGetQuery(conn, query)                
goodsAll

# 복수의 열에 대해 수정         #↓ 쉼표로 구분
query <- "update goods2 set su = 1, dan = 560000 where name = '세탁기'"
dbSendUpdate(conn, query)
query <- "select * from goods2"
goodsAll <- dbGetQuery(conn, query)                
goodsAll

# DML (Data Manipulation Language) : 데이터 조작어
# select, insert, update, delete

# select 필드명리스트 from 테이블명 [where 조건절 order by 정렬키 (desc/asc)]
# insert into 테이블명 (필드명리스트) values(필드명리스트와 동일한 순서의 값리스트)
# update 테이블명 set  필드명1 = 값1, 필드명2 = 값2, ... where 조건절
# delete from 테이블명 where 조건절
# 테이블 삭제 : drop table 테이블

# shopUser, shopProduct, shopSale 테이블 생성
# shopUser : uId(문자열10, primary key), uName(문자열20), uAge(정수)
# shopProduct : pCode(정수, primary key), pName(문자열20), pPrice(정수)
# shopSale : uId, pCode, sCount(정수)

# 김삿갓이 구매한 내역에 대해 성명, 상품명, 수량 조회 ( 열 추가 가능)
query <- "SELECT u.uName, p.pName, s.sCount, p.pPrice * s.sCount AS subtot
	FROM shopuser AS u, shopproduct AS p, shopsale AS s
	WHERE u.uId = s.uId AND p.pCode = s.pCode AND u.uName = '김삿갓'"
q <- dbGetQuery(conn, query)
q

