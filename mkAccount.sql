CREATE TABLE MEMBER (  -- 회원가입 TABLE
	userID			nvarchar2(30)	NOT NULL PRIMARY KEY, 
	password1		nvarchar2(30)	NOT NULL,  
	password2		nvarchar2(30)	NOT NULL,  -- 비밀번호 확인 
	userName		nvarchar2(12)	NOT NULL,
	email			nvarchar2(50),  
	phone			nvarchar2(50),
	addr1			nvarchar2(50),
	addr2			nvarchar2(50),
	gender			nvarchar2(10),
	birth			nvarchar2(50)
);

select * from member;
drop table member;

drop table product;
-- 상품정보 table 
CREATE TABLE product(
	pCode		number	NOT NULL	PRIMARY KEY, -- 제품 고유번호 PK
	psubject		nvarchar2(50),  -- 제품 제목(이름) 
	category		nvarchar2(50),  -- 제품 카테고리 
	subcategory	nvarchar2(50),  -- 제품 서브카테고리 
	pinfo		nvarchar2(100),  -- 제품 설명 
	price		number,	       -- 제품 가격	
	unit		nvarchar2(50),  -- 판매 단위 
	origin		nvarchar2(50),  -- 원산지 
	shelfLife		nvarchar2(100),  -- 유통기한
	pimg		nvarchar2(100),  -- 대표 이미지
	created		Date,  -- 작성일자 
	amount		number, -- 수량 
	sale		number, -- 할인
	salesvolume	number  -- 판매량 
);

--상품설명이미지
CREATE TABLE productExplainImg(
	pCode		number not null,
	subcategory	nvarchar2(50),  -- 제품 서브카테고리 
	explpainimg	nvarchar2(50)
);

--상세정보이미지
CREATE TABLE productDetailImg(
	pCode		number not null,
	subcategory	nvarchar2(50),  -- 제품 서브카테고리 
	detailimg		nvarchar2(50)
);


CREATE TABLE pReview(  -- 제품 리뷰 TABLE
	rNum		NUMBER	PRIMARY KEY,  -- 리뷰 번호 PK 
	pCode		number NOT  NULL,
	title		nvarchar2(50) NOT NULL,  -- 리뷰 제목 
	contents		nvarchar2(300), -- 리뷰 내용 
	userID		nvarchar2(50), -- 작성자 이름 
	created		Date,  -- 작성일자 
	cnt		number  -- 조회수 
);

CREATE TABLE qna(  -- Product QNA 제품 
	qNum		number PRIMARY KEY,  -- 질문 글번호 
	pCode		number	NOT NULL,  -- 제품 번호
	userID		nvarchar2(50) NOT null,  -- 사용자 아이디 
	qTitle		nvarchar2(50),  -- 질문 제목 
	qContents	nvarchar2(500), -- 질문 내용 
	created		Date,  -- 작성일자 
	rStatus		number,   -- 답변완료 (1 or 0)
	secNum		number  -- 비밀글 처리 여부(1 or 0)
);

drop table delivery;
-- 배송 
CREATE TABLE delivery(
	deliNum		number	PRIMARY KEY,  -- 배송 번호 
	userID		nvarchar2(30) NOT null,  -- 고객 아이디 
	addr1		nvarchar2(50),
	addr2		nvarchar2(50),
	recipient	nvarchar2(50), -- 받는사람
	phoneNum	nvarchar2(50),  -- 핸드폰번호 
	basicAdd	number -- 기본주소 (1 or 0) 
);

-- 제품 QNA 답글 테이블 
CREATE TABLE qnaReply(
	rqNum		number PRIMARY KEY, -- 답글 번호 
	qNum		number,  -- 질문 번호 
	replyText	nvarchar2(500),  -- 답글 내용 
	replyer		nvarchar2(50),  -- 답변인 
	replyDate	Date  -- 답변 날짜 
);

drop table bucket;
update product set salesvolume=(select salesvolume from product where pCode=3004)+1 where pCode=3004;
select salesvolume from product where pCode=3004;
-- 장바구니 테이블 
CREATE TABLE bucket(
	bkNum		number	NOT NULL PRIMARY KEY,  -- 장바구니 번호(상품번호)
	userID		nvarchar2(50), -- 사용자 아이디 
	pCode		number, -- 제품 번호 
	orderCnt	number,  -- 주문 수량 
    orderchk    number DEFAULT 0
);
select * from product where pCode in (1001,3001);

select*from bucket;

drop table orders;
-- 주문하기 테이블 
CREATE TABLE orders(
	orderNum	number,  -- 주문 번호 
	userID		nvarchar2(30) NOT null,  -- 고객 아이디 
    recipient 	nvarchar2(50), -- 받는사람
    addr1		nvarchar2(50), -- 받는사람 주소1
	addr2		nvarchar2(50), -- 받는사람 주소2
	phoneNum	number, -- 받는사람 핸드폰번호 
	order_Date	Date,  -- 주문 날짜 
	payment		number  -- 주문 금액 
);

drop table ORDER_Detail;
-- 주문 상세 (결제 후)
CREATE TABLE ORDER_Detail(
	oddtNum		number PRIMARY KEY,  -- 주문상세번호 
	userID		nvarchar2(50) NOT null, -- 고객 아이디 
	pCode		number	NOT NULL, -- 제품 번호 
	cnt		number,  -- 수량 
	orderNum		number   -- 주문상세번호 
);
-- 관리자 권한 부여 
CREATE TABLE notice(
	ntNum		number	PRIMARY KEY,
	title		nvarchar2(50) NOT NULL,
	manager		nvarchar2(50),
	created		Date,
	cnt			number,
	contents	nvarchar2(500)
);

CREATE TABLE question(  -- 1:1 문의 table
	qNum		number NOT NULL PRIMARY KEY,
	category	nvarchar2(50), -- 문의 종류 
	title		nvarchar2(50),  -- 문의 제목 
	contents	nvarchar2(500), -- 문의 내용 
	userID		nvarchar2(50),  -- 문의자 아이디 
	imgFiles	nvarchar2(50) -- 첨부파일 
);

CREATE TABLE qReply(
	rqNum		number PRIMARY KEY,  -- 답글 번호  
	qNum		number,   -- 질문 번호  
	replyText	nvarchar2(500),  -- 답글 내용 
	replyer		nvarchar2(50),  -- 답변인 
	replyDate	Date -- 답변일자 
);


drop table favorit;
CREATE TABLE favorit(
	fNum	NUMBER PRIMARY KEY,
	pCode	NUMBER,
	userID	nvarchar2(50),
    fcheck  NUMBER -- 0: none, 1: 좋아요
);


-- ******** 시퀀스 ******** 
select * from user_sequences; --현재 생성된 시퀀스
create sequence seq_dNum; --배송지(delivery)
create sequence bucketNum; --장바구니(bucket)
create sequence seq_orderNum; --주문테이블(orders)
create sequence seq_oddtNum; --주문상세(order_detail)
create sequence seq_ntNum; --공지사항(ntNum)
create sequence queNum; --1:1문의(qNum)
create sequence favNum; --찜목록(fNum)
create sequence seq_reivewNum; --후기(rNum)


-- ****************상품 insert********************

delete productExplainImg;
delete productDetailImg;
delete product; 
commit;

--*******************
desc product;
select * from product where subcategory='고구마감자당근';
--고구마감자당근(1000)
insert into product values (1001,'[KF365] 밤고구마 800g', '채소', '고구마감자당근', '포근하고 고소한 고구마(1봉/800g)',4780, '1봉지', '국산', '농산물로 별도의 유통기한은 없으나 가급적 빠르게 드시기 바랍니다.', '밤고구마 800g.jpg', sysdate, 50, 0.0, 0);
insert into product values (1002, '[KF365] 호박고구마 800g', '채소', '고구마감자당근', '더욱 촉촉하고 달콤한 호박고구마(1봉/800g)',5580, '1봉지', '국산', '농산물로 별도의 유통기한은 없으나 가급적 빠르게 드시기 바랍니다.', '호박고구마 800g.jpg', sysdate, 50, 0.0, 0);
insert into product values (1003, '제주 흙당근 1kg', '채소', '고구마감자당근', '제주도에서 자란 영양 가득 채소', 3190, '1봉지', '국산', '농산물로 별도의 유통기한은 없으나 가급적 빠르게 드시기 바랍니다.', '제주 흙당근 1kg.jpg',  sysdate, 50, 0.0, 0);
insert into product values (1004, '친환경 감자 600g', '채소', '고구마감자당근', '어떤 음식을 해도 잘 어울리는 무농약 감자', 2690, '1봉', '국산', '농산물로 별도의 유통기한은 없으나 가급적 빠르게 드시기 바랍니다.', '친환경 감자 600g.jpg',  sysdate, 50, 0.0, 0);
insert into product values (1005, '친환경 당근 500g', '채소', '고구마감자당근', '껍질째 먹을 수 있는 친환경 흙당근(500g 내외)', 2990, '1봉지', '국산', '농산물로 별도의 유통기한은 없으나 가급적 빠르게 드시기 바랍니다.', '친환경 당근 500g.jpeg',  sysdate, 50, 0.0, 0);
insert into product values (1006, '[KF365] 감자 1kg', '채소', '고구마감자당근', '믿고 먹을 수 있는 상품을 합리적인 가격에, KF365', 3490, '1박스', '국산', '농산물로 별도의 유통기한은 없으나 가급적 빠르게 드시기 바랍니다.', '감자 1kg.jpg',  sysdate, 50, 0.0, 0);
insert into product values (1007,'친환경 호박고구마 1kg', '채소', '고구마감자당근', '노란 속살만큼 진한 달콤함', 7490, '1박스', '국산', '농산물로 별도의 유통기한은 없으나 가급적 빠르게 드시기 바랍니다.', '친환경 호박고구마 1kg.jpg ',  sysdate, 50, 0.0, 0);
insert into product values (1008, '한끼 감자 300g', '채소', '고구마감자당근', '보관 걱정 없이 소용량 포장으로', 1790, '1봉지', '국산', '농산물로 별도의 유통기한은 없으나 가급적 빠르게 드시기 바랍니다.', '한끼 감자 300g.jpg',  sysdate, 50, 0.0, 0);
insert into product values (1009, '한끼 당근 1개', '채소', '고구마감자당근', '딱 하나만 필요할 때 한끼 당근',1300, '1봉지', '국산', '농산물로 별도의 유통기한은 없으나 가급적 빠르게 드시기 바랍니다.', '한끼 당근 1개.jpg',  sysdate, 50, 0.0, 0);

insert into productExplainImg values (1001, '고구마감자당근', '상품설명1.jpg');
insert into productExplainImg values (1001, '고구마감자당근', '상품설명2.PNG');
insert into productExplainImg values (1001, '고구마감자당근', '상품설명3.PNG');
insert into productExplainImg values (1001, '고구마감자당근', '상품설명4.PNG');

insert into productDetailImg values (1001, '고구마감자당근', '상세정보1.PNG');
insert into productDetailImg values (1001, '고구마감자당근', '상세정보2.PNG');

insert into productExplainImg values (1002, '고구마감자당근', '상품설명1.jpg');
insert into productExplainImg values (1002, '고구마감자당근', '상품설명2.PNG');
insert into productExplainImg values (1002, '고구마감자당근', '상품설명3.PNG');
insert into productExplainImg values (1002, '고구마감자당근', '상품설명4.PNG');

insert into productDetailImg values (1002, '고구마감자당근', '상세정보1.jpg');
insert into productDetailImg values (1002, '고구마감자당근', '상세정보2.PNG');

insert into productExplainImg values (1003, '고구마감자당근', '상품설명1.jpg');
insert into productExplainImg values (1003, '고구마감자당근', '상품설명2.PNG');
insert into productExplainImg values (1003, '고구마감자당근', '상품설명3.PNG');

insert into productDetailImg values (1003, '고구마감자당근', '상세정보1.PNG');
insert into productDetailImg values (1003, '고구마감자당근', '상세정보2.PNG');

insert into productExplainImg values (1004, '고구마감자당근', '상품설명1.jpg');
insert into productExplainImg values (1004, '고구마감자당근', '상품설명2.PNG');
insert into productExplainImg values (1004, '고구마감자당근', '상품설명3.PNG');
insert into productExplainImg values (1004, '고구마감자당근', '상품설명4.PNG');

insert into productDetailImg values (1004, '고구마감자당근', '상세정보1.PNG');
insert into productDetailImg values (1004, '고구마감자당근', '상세정보2.PNG');

insert into productExplainImg values (1005, '고구마감자당근', '상품설명1.jpg');
insert into productExplainImg values (1005, '고구마감자당근', '상품설명2.PNG');
insert into productExplainImg values (1005, '고구마감자당근', '상품설명3.PNG');
insert into productExplainImg values (1005, '고구마감자당근', '상품설명4.PNG');

insert into productDetailImg values (1005, '고구마감자당근', '상세정보1.PNG');
insert into productDetailImg values (1005, '고구마감자당근', '상세정보2.PNG');

insert into productExplainImg values (1006, '고구마감자당근', '상품설명1.jpg');
insert into productExplainImg values (1006, '고구마감자당근', '상품설명2.PNG');
insert into productExplainImg values (1006, '고구마감자당근', '상품설명3.PNG');
insert into productExplainImg values (1006, '고구마감자당근', '상품설명4.PNG');

insert into productDetailImg values (1006, '고구마감자당근', '상세정보1.PNG');
insert into productDetailImg values (1006, '고구마감자당근', '상세정보2.PNG');

insert into productExplainImg values (1007, '고구마감자당근', '상품설명1.jpg');
insert into productExplainImg values (1007, '고구마감자당근', '상품설명2.PNG');
insert into productExplainImg values (1007, '고구마감자당근', '상품설명3.PNG');
insert into productExplainImg values (1007, '고구마감자당근', '상품설명4.PNG');

insert into productDetailImg values (1007, '고구마감자당근', '상세정보1.PNG');
insert into productDetailImg values (1007, '고구마감자당근', '상세정보2.PNG');

insert into productExplainImg values (1008, '고구마감자당근', '상품설명1.jpg');
insert into productExplainImg values (1008, '고구마감자당근', '상품설명2.PNG');
insert into productExplainImg values (1008, '고구마감자당근', '상품설명3.PNG');

insert into productDetailImg values (1008, '고구마감자당근', '상세정보1.PNG');
insert into productDetailImg values (1008, '고구마감자당근', '상세정보2.PNG');

insert into productExplainImg values (1009, '고구마감자당근', '상품설명1.jpg');
insert into productExplainImg values (1009, '고구마감자당근', '상품설명2.PNG');
insert into productExplainImg values (1009, '고구마감자당근', '상품설명3.PNG');

insert into productDetailImg values (1009, '고구마감자당근', '상세정보1.PNG');
insert into productDetailImg values (1009, '고구마감자당근', '상세정보2.PNG');

--브로콜리파프리카양배추(2000)
insert into product values (2001, '친환경 미니 파프리카 150g', '채소', '브로콜리파프리카양배추', '과일 못지 않은 상큼함', 3990, '1팩', '국산', '농산물로 별도의 유통기한은 없으나 가급적 빠르게 드시기 바랍니다.', '친환경 미니 파프리카 150g.png', sysdate, 50, 0.0, 0);
insert into product values (2002, '친환경 브로콜리', '채소', '브로콜리파프리카양배추', '풍부한 영양이 담긴 초록 꽃송이', 4290, '1봉지', '국산', '농산물로 별도의 유통기한은 없으나 가급적 빠르게 드시기 바랍니다.', '친환경 브로콜리.png', sysdate, 50, 0.0, 0);
insert into product values (2003, '친환경 조각 양배추 400g', '채소', '브로콜리파프리카양배추', '건강하게 재배한 만능채소', 2290, '1통', '국산', '농산물로 별도의 유통기한은 없으나 가급적 빠르게 드시기 바랍니다.', '친환경 조각 양배추 400g.jpg', sysdate, 50, 0.0, 0);

insert into productExplainImg values (2001, '브로콜리파프리카양배추', '상품설명1.jpeg');
insert into productExplainImg values (2001, '브로콜리파프리카양배추', '상품설명2.png');
insert into productExplainImg values (2001, '브로콜리파프리카양배추', '상품설명3.png');

insert into productDetailImg values (2001, '브로콜리파프리카양배추', '상세정보1.png');
insert into productDetailImg values (2001, '브로콜리파프리카양배추', '상세정보2.png');

insert into productExplainImg values (2002, '브로콜리파프리카양배추', '상품설명1.jpeg');
insert into productExplainImg values (2002, '브로콜리파프리카양배추', '상품설명2.png');
insert into productExplainImg values (2002, '브로콜리파프리카양배추', '상품설명3.png');
insert into productExplainImg values (2002, '브로콜리파프리카양배추', '상품설명4.png');

insert into productDetailImg values (2002, '브로콜리파프리카양배추', '상세정보1.png');
insert into productDetailImg values (2002, '브로콜리파프리카양배추', '상세정보2.png');

insert into productExplainImg values (2003, '브로콜리파프리카양배추', '상품설명1.png');
insert into productExplainImg values (2003, '브로콜리파프리카양배추', '상품설명2.png');
insert into productExplainImg values (2003, '브로콜리파프리카양배추', '상품설명3.png');
insert into productExplainImg values (2003, '브로콜리파프리카양배추', '상품설명4.png');

insert into productDetailImg values (2003, '브로콜리파프리카양배추', '상세정보1.png');
insert into productDetailImg values (2003, '브로콜리파프리카양배추', '상세정보2.png');

--시금치쌈채소나물(3000)
insert into product values (3001, '[KF365] GAP 밀양 깻잎 3속', '채소' ,'시금치쌈채소나물', '믿고 먹을 수 있는 상품을 합리적인 가격에, KF365', 1680, '1봉지', '국산', '1주이내', 'GAP밀양깻잎3속.jpg' ,sysdate, 50, 0.0, 0);
insert into product values (3002, '[KF365] 부추 200g', '채소' ,'시금치쌈채소나물', '전으로 부쳐도, 무쳐먹어도 맛있는 만능 채소(200g/봉)', 2640, '1봉지', '국산', '1주이내', '부추200g.jpg', sysdate, 50, 0.0, 0);
insert into product values (3003, '[KF365] 청상추 150g', '채소' ,'시금치쌈채소나물', '믿고 먹을 수 있는 상품을 합리적인 가격에, KF365', 1820, '1봉지', '국산', '1주이내', '청상추150g.jpg',sysdate, 50, 0.0, 8);
insert into product values (3004, '경기 시금치 250g', '채소' ,'시금치쌈채소나물', '두루 사용되는 국민 엽채류', 2690, '1봉지', '국산', '1주이내', '경기 시금치 250g.jpg',sysdate, 50, 0.0, 10);
insert into product values (3005, '알배기 배추 1통', '채소' ,'시금치쌈채소나물', '고소하고 달큼한 맛이 일품인 미니 알배기 배추 1통', 3690, '통', '국산', '1주이내', '알배기 배추 1통.jpeg',sysdate, 50, 0.0, 0);
insert into product values (3006, '친환경 남해초 200g', '채소' ,'시금치쌈채소나물', '해풍을 맞으며 자란 푸른 시금치', 3000, '1봉지', '국산', '1주이내', '친환경 남해초 200g.jpg',sysdate, 50, 0.1, 0);
insert into product values (3007, '친환경 로메인 2종', '채소' ,'시금치쌈채소나물', '아삭한 식감에 깃든 싱그러움', 1690, '1봉지', '국산', '1주이내', '친환경 로메인 2종.jpg', sysdate, 50, 0.2, 5);
insert into product values (3008, '친환경 시금치 200g', '채소' ,'시금치쌈채소나물', '뽀빠이가 좋아하는 바로 그 채소. 친환경 시금치 (200g)', 2700, '1봉지', '국내', '1주이내', '친환경 시금치 200g .jpg', sysdate, 50, 0.0, 0);
insert into product values (3009, '포항초 250g', '채소' ,'시금치쌈채소나물', '진하고 달큰한 포항 시금치 포항초 250g', 3900, '1봉지', '국내산', '1주이내', '포항초 250g.jpg', sysdate, 50, 0.0, 6);

insert into productExplainImg values (3001, '시금치쌈채소나물', '상품설명1.PNG');
insert into productExplainImg values (3001, '시금치쌈채소나물', '상품설명2.PNG');
insert into productExplainImg values (3001, '시금치쌈채소나물', '상품설명3.PNG');
insert into productExplainImg values (3001, '시금치쌈채소나물', '상품설명4.PNG');

insert into productDetailImg values (3001, '시금치쌈채소나물', '상세정보1.PNG');
insert into productDetailImg values (3001, '시금치쌈채소나물', '상세정보2.PNG');

insert into productExplainImg values (3002, '시금치쌈채소나물', '상품설명1.PNG');
insert into productExplainImg values (3002, '시금치쌈채소나물', '상품설명2.PNG');
insert into productExplainImg values (3002, '시금치쌈채소나물', '상품설명3.PNG');

insert into productDetailImg values (3002, '시금치쌈채소나물', '상세정보1.PNG');
insert into productDetailImg values (3002, '시금치쌈채소나물', '상세정보2.PNG');

insert into productExplainImg values (3003, '시금치쌈채소나물', '상품설명1.PNG');
insert into productExplainImg values (3003, '시금치쌈채소나물', '상품설명2.PNG');
insert into productExplainImg values (3003, '시금치쌈채소나물', '상품설명3.PNG');

insert into productDetailImg values (3003, '시금치쌈채소나물', '상세정보1.PNG');
insert into productDetailImg values (3003, '시금치쌈채소나물', '상세정보2.PNG');

insert into productExplainImg values (3004, '시금치쌈채소나물', '상품설명1.PNG');
insert into productExplainImg values (3004, '시금치쌈채소나물', '상품설명2.PNG');
insert into productExplainImg values (3004, '시금치쌈채소나물', '상품설명3.PNG');

insert into productDetailImg values (3004, '시금치쌈채소나물', '상세정보1.PNG');
insert into productDetailImg values (3004, '시금치쌈채소나물', '상세정보2.PNG');

insert into productExplainImg values (3005, '시금치쌈채소나물', '상품설명1.PNG');
insert into productExplainImg values (3005, '시금치쌈채소나물', '상품설명2.PNG');
insert into productExplainImg values (3005, '시금치쌈채소나물', '상품설명3.PNG');

insert into productDetailImg values (3005, '시금치쌈채소나물', '상세정보1.PNG');
insert into productDetailImg values (3005, '시금치쌈채소나물', '상세정보2.PNG');

insert into productExplainImg values (3006, '시금치쌈채소나물', '상품설명1.PNG');
insert into productExplainImg values (3006, '시금치쌈채소나물', '상품설명2.PNG');
insert into productExplainImg values (3006, '시금치쌈채소나물', '상품설명3.PNG');

insert into productDetailImg values (3006, '시금치쌈채소나물', '상세정보1.PNG');
insert into productDetailImg values (3006, '시금치쌈채소나물', '상세정보2.PNG');

insert into productExplainImg values (3007, '시금치쌈채소나물', '상품설명1.PNG');
insert into productExplainImg values (3007, '시금치쌈채소나물', '상품설명2.PNG');
insert into productExplainImg values (3007, '시금치쌈채소나물', '상품설명3.PNG');
insert into productExplainImg values (3007, '시금치쌈채소나물', '상품설명4.PNG');

insert into productDetailImg values (3007, '시금치쌈채소나물', '상세정보1.PNG');
insert into productDetailImg values (3007, '시금치쌈채소나물', '상세정보2.PNG');

insert into productExplainImg values (3008, '시금치쌈채소나물', '상품설명1.PNG');
insert into productExplainImg values (3008, '시금치쌈채소나물', '상품설명2.PNG');
insert into productExplainImg values (3008, '시금치쌈채소나물', '상품설명3.PNG');
insert into productExplainImg values (3008, '시금치쌈채소나물', '상품설명4.PNG');

insert into productDetailImg values (3008, '시금치쌈채소나물', '상세정보1.PNG');
insert into productDetailImg values (3008, '시금치쌈채소나물', '상세정보2.PNG');

insert into productExplainImg values (3009, '시금치쌈채소나물', '상품설명1.PNG');
insert into productExplainImg values (3009, '시금치쌈채소나물', '상품설명2.PNG');
insert into productExplainImg values (3009, '시금치쌈채소나물', '상품설명3.PNG');

insert into productDetailImg values (3009, '시금치쌈채소나물', '상세정보1.PNG');
insert into productDetailImg values (3009, '시금치쌈채소나물', '상세정보2.PNG');

--양파대파마늘배추(4000)
insert into product values ( 4001 ,'[KF365] 깐마늘 200g', '채소', '양파대파마늘배추', '믿고 먹을 수 있는 상품을 합리적인 가격에,KF365',2800 , '봉', '국산','농산물로 별도의 유통기한은 없으나 가급적 빠르게 드시기 바랍니다.', '깐마늘 200g.jpg', sysdate, 50, 0.0, 0);
insert into product values ( 4002 ,'[KF365] 양파1.8kg', '채소', '양파대파마늘배추', '믿고 먹을수 있는 상품을 합리적인 가격에,KF365', 3840, '1망', '국산','농산물로 별도의 유통기한은 없으나 가급적 빠르게 드시기 바랍니다.', '양파1.8kg.jpg', sysdate, 50, 0.0, 0);
insert into product values ( 4003, '깐대파500g', '채소', '양파대파마늘배추', '만능 양념채소', 2990, '봉', '국산','농산물로 별도의 유통기한은 없으나 가급적 빠르게 드시기 바랍니다.', '깐대파500g.jpeg', sysdate, 50, 0.0, 0);
insert into product values ( 4004, '깐마늘500g', '채소', '양파대파마늘배추', '껍질을 벗겨 간편한 마늘',6890 , '1봉', '국산','농산물로 별도의 유통기한은 없으나 가급적 빠르게 드시기 바랍니다.', '깐마늘500g.jpg', sysdate, 50, 0.0, 0);
insert into product values ( 4005, '배추 1포기', '채소', '양파대파마늘배추', '친숙하고 활용도 높은 채소(2.5kg이상)',5190, '1통', '국산','농산물로 별도의 유통기한은 없으나 가급적 빠르게 드시기 바랍니다.', '배추 1포기.jpg', sysdate, 50, 0.0, 0);
insert into product values ( 4006, '양파3kg', '채소', '양파대파마늘배추', '넉넉하게 누리는 단골 식재료', 5690, '1망', '국산','농산물로 별도의 유통기한은 없으나 가급적 빠르게 드시기 바랍니다.', '양파3kg.jpeg', sysdate, 50, 0.0, 0);
insert into product values ( 4007, '진도 대파1단 1kg', '채소', '양파대파마늘배추', '겨울철 제철 맞은 향긋한 진도 대파.', 2690, '1봉', '국산','농산물로 별도의 유통기한은 없으나 가급적 빠르게 드시기 바랍니다.', '진도 대파1단 1kg.jpg', sysdate, 50, 0.0, 0);
insert into product values ( 4008, '친환경 깐 적양파1입', '채소', '양파대파마늘배추', '손질없이 즐기는 아삭한 양파', 1300, '1입', '국산','농산물로 별도의 유통기한은 없으나 가급적 빠르게 드시기 바랍니다.', '친환경 깐 적양파1입.jpg', sysdate, 50, 0.0, 0);
insert into product values ( 4009, '친환경 손질한 잎몸 대파200g', '채소', '양파대파마늘배추', '가장 맛있는 잎몸 부분만 따로 손질한 대파(1봉/200g).', 3490, '1봉', '국산','농산물로 별도의 유통기한은 없으나 가급적 빠르게 드시기 바랍니다.', '친환경 손질한 잎몸 대파200g.jpg', sysdate, 50, 0.0, 0);
insert into product values ( 4010, '친환경 잎쌈배추120g', '채소', '양파대파마늘배추', '쌈 싸먹기 좋은 싱싱한 채소(1봉/120g)',2490, '1봉', '국산','농산물로 별도의 유통기한은 없으나 가급적 빠르게 드시기 바랍니다.', '친환경 잎쌈배추120g.jpg', sysdate, 50, 0.0, 0);
insert into product values ( 4011, '친환경 잎채소 쌈배추 반통', '채소', '양파대파마늘배추', '고소함이 겹겹히 쌓인 미니배추',3690, '1봉', '국산','농산물로 별도의 유통기한은 없으나 가급적 빠르게 드시기 바랍니다.', '친환경 잎채소 쌈배추 반통.jpg', sysdate, 50, 0.0, 0);
insert into product values ( 4012, '친환경 저민마늘50g', '채소', '양파대파마늘배추', '편썰기로 요리에 간편하게 이용하는 저민마늘',3290 , '1팩', '국산','농산물로 별도의 유통기한은 없으나 가급적 빠르게 드시기 바랍니다.', '친환경 저민마늘50g.jpg', sysdate, 50, 0.0, 0);

insert into productExplainImg values (4001, '양파대파마늘배추', '상품설명1.jpg');
insert into productExplainImg values (4001, '양파대파마늘배추', '상품설명2.PNG');
insert into productExplainImg values (4001, '양파대파마늘배추', '상품설명3.PNG');

insert into productDetailImg values (4001, '양파대파마늘배추', '상세정보1.PNG');
insert into productDetailImg values (4001, '양파대파마늘배추', '상세정보2.PNG');

insert into productExplainImg values (4002, '양파대파마늘배추', '상품설명1.jpg');
insert into productExplainImg values (4002, '양파대파마늘배추', '상품설명2.PNG');
insert into productExplainImg values (4002, '양파대파마늘배추', '상품설명3.PNG');
insert into productExplainImg values (4002, '양파대파마늘배추', '상품설명4.PNG');

insert into productDetailImg values (4002, '양파대파마늘배추', '상세정보1.PNG');
insert into productDetailImg values (4002, '양파대파마늘배추', '상세정보2.PNG');

insert into productExplainImg values (4003, '양파대파마늘배추', '상품설명1.jpg');
insert into productExplainImg values (4003, '양파대파마늘배추', '상품설명2.PNG');
insert into productExplainImg values (4003, '양파대파마늘배추', '상품설명3.PNG');

insert into productDetailImg values (4003, '양파대파마늘배추', '상세정보1.PNG');
insert into productDetailImg values (4003, '양파대파마늘배추', '상세정보2.PNG');

insert into productExplainImg values (4004, '양파대파마늘배추', '상품설명1.jpg');
insert into productExplainImg values (4004, '양파대파마늘배추', '상품설명2.PNG');
insert into productExplainImg values (4004, '양파대파마늘배추', '상품설명3.PNG');

insert into productDetailImg values (4004, '양파대파마늘배추', '상세정보1.PNG');
insert into productDetailImg values (4004, '양파대파마늘배추', '상세정보2.PNG');

insert into productExplainImg values (4005, '양파대파마늘배추', '상품설명1.jpg');
insert into productExplainImg values (4005, '양파대파마늘배추', '상품설명2.PNG');
insert into productExplainImg values (4005, '양파대파마늘배추', '상품설명3.PNG');

insert into productDetailImg values (4005, '양파대파마늘배추', '상세정보1.PNG');
insert into productDetailImg values (4005, '양파대파마늘배추', '상세정보2.PNG');

insert into productExplainImg values (4006, '양파대파마늘배추', '상품설명1.jpg');
insert into productExplainImg values (4006, '양파대파마늘배추', '상품설명2.PNG');
insert into productExplainImg values (4006, '양파대파마늘배추', '상품설명3.PNG');

insert into productDetailImg values (4006, '양파대파마늘배추', '상세정보1.PNG');
insert into productDetailImg values (4006, '양파대파마늘배추', '상세정보2.PNG');

insert into productExplainImg values (4007, '양파대파마늘배추', '상품설명1.jpg');
insert into productExplainImg values (4007, '양파대파마늘배추', '상품설명2.PNG');
insert into productExplainImg values (4007, '양파대파마늘배추', '상품설명3.PNG');

insert into productDetailImg values (4007, '양파대파마늘배추', '상세정보1.PNG');
insert into productDetailImg values (4007, '양파대파마늘배추', '상세정보2.PNG');

insert into productExplainImg values (4008, '양파대파마늘배추', '상품설명1.jpg');
insert into productExplainImg values (4008, '양파대파마늘배추', '상품설명2.PNG');
insert into productExplainImg values (4008, '양파대파마늘배추', '상품설명3.PNG');
insert into productExplainImg values (4008, '양파대파마늘배추', '상품설명4.PNG');
insert into productExplainImg values (4008, '양파대파마늘배추', '상품설명5.PNG');

insert into productDetailImg values (4008, '양파대파마늘배추', '상세정보1.PNG');
insert into productDetailImg values (4008, '양파대파마늘배추', '상세정보2.PNG');

insert into productExplainImg values (4009, '양파대파마늘배추', '상품설명1.jpg');
insert into productExplainImg values (4009, '양파대파마늘배추', '상품설명2.PNG');
insert into productExplainImg values (4009, '양파대파마늘배추', '상품설명3.PNG');

insert into productDetailImg values (4009, '양파대파마늘배추', '상세정보1.PNG');
insert into productDetailImg values (4009, '양파대파마늘배추', '상세정보2.PNG');

insert into productExplainImg values (4010, '양파대파마늘배추', '상품설명1.jpg');
insert into productExplainImg values (4010, '양파대파마늘배추', '상품설명2.PNG');
insert into productExplainImg values (4010, '양파대파마늘배추', '상품설명3.PNG');
insert into productExplainImg values (4010, '양파대파마늘배추', '상품설명4.PNG');

insert into productDetailImg values (4010, '양파대파마늘배추', '상세정보1.PNG');
insert into productDetailImg values (4010, '양파대파마늘배추', '상세정보2.PNG');

insert into productExplainImg values (4011, '양파대파마늘배추', '상품설명1.jpg');
insert into productExplainImg values (4011, '양파대파마늘배추', '상품설명2.PNG');

insert into productDetailImg values (4011, '양파대파마늘배추', '상세정보1.PNG');
insert into productDetailImg values (4011, '양파대파마늘배추', '상세정보2.PNG');

insert into productExplainImg values (4012, '양파대파마늘배추', '상품설명1.jpg');
insert into productExplainImg values (4012, '양파대파마늘배추', '상품설명2.PNG');
insert into productExplainImg values (4012, '양파대파마늘배추', '상품설명3.PNG');

insert into productDetailImg values (4012, '양파대파마늘배추', '상세정보1.PNG');
insert into productDetailImg values (4012, '양파대파마늘배추', '상세정보2.PNG');

select * from product where subcategory='오이호박고추';
--오이호박고추(5000)
insert into product values (5001, '[KF365] 청양고추 200g', '채소' ,'오이호박고추', '믿고 먹을 수 있는 상품을 합리적인 가가격에 KF365', 2980, '1봉', '국산', '농산물로 별도의 유통기한은 없으나 가급적 빠르게 드시기 바랍니다.', '청양고추 200g.jpg', sysdate,50, 0.0, 0);
insert into product values (5002, '가시오이 2입', '채소' ,'오이호박고추', '단단한 과육 속 단맛 가득', 4290, '1봉', '국산', '농산물로 별도의 유통기한은 없으나 가급적 빠르게 드시기 바랍니다.', '가시오이 2입.png', sysdate, 50, 0.0, 0);
insert into product values (5003, '무농약 간편 단호박 2종', '채소' ,'오이호박고추', '간편 단호박의 단호한 간편함(400g)', 4300, '1팩', '국산', '농산물로 별도의 유통기한은 없으나 가급적 빠르게 드시기 바랍니다.', '무농약 간편 단호박 2종.PNG', sysdate, 50, 0.0, 0);
insert into product values (5004, '유기농 다진 단호박 100g', '채소' ,'오이호박고추', '손쉽게 꺼내 쓰는 노란 영양', 2900, '1팩', '국내', '농산물로 별도의 유통기한은 없으나 가급적 빠르게 드시기 바랍니다.', '유기농 다진 단호박 100g.png', sysdate, 50, 0.0, 0);
insert into product values (5005, '친환경 오이 2입', '채소' ,'오이호박고추', '껍질째 안심하고 먹을 수 있는 무농약 오이(2입)', 3590, '1봉', '국산','농산물로 별도의 유통기한은 없으나 가급적 빠르게 드시기 바랍니다.', '친환경 오이 2입.png', sysdate, 50, 0.0, 0);
insert into product values (5006, '친환경 오이고추 200g', '채소' ,'오이호박고추', '아삭아삭 씹히는 오이맛 고추', 2390, '1봉', '국산', '농산물로 별도의 유통기한은 없으나 가급적 빠르게 드시기 바랍니다.', '친환경 오이고추 200g.png', sysdate, 50, 0.0, 0);

insert into productExplainImg values (5001, '오이호박고추', '상품설명1.jpg');
insert into productExplainImg values (5001, '오이호박고추', '상품설명2.PNG');
insert into productExplainImg values (5001, '오이호박고추', '상품설명3.PNG');
insert into productExplainImg values (5001, '오이호박고추', '상품설명4.PNG');

insert into productDetailImg values (5001, '오이호박고추', '상세정보1.PNG');
insert into productDetailImg values (5001, '오이호박고추', '상세정보2.PNG');

insert into productExplainImg values (5002, '오이호박고추', '상품설명1.png');
insert into productExplainImg values (5002, '오이호박고추', '상품설명2.png');
insert into productExplainImg values (5002, '오이호박고추', '상품설명3.png');
insert into productExplainImg values (5002, '오이호박고추', '상품설명4.png');

insert into productDetailImg values (5002, '오이호박고추', '상세정보1.png');
insert into productDetailImg values (5002, '오이호박고추', '상세정보2.png');

insert into productExplainImg values (5003, '오이호박고추', '상품설명1.PNG');
insert into productExplainImg values (5003, '오이호박고추', '상품설명2.png');
insert into productExplainImg values (5003, '오이호박고추', '상품설명3.png');
insert into productExplainImg values (5003, '오이호박고추', '상품설명4.png');

insert into productDetailImg values (5003, '오이호박고추', '상세정보1.PNG');
insert into productDetailImg values (5003, '오이호박고추', '상세정보2.PNG');

insert into productExplainImg values (5004, '오이호박고추', '상품설명1.png');
insert into productExplainImg values (5004, '오이호박고추', '상품설명2.png');
insert into productExplainImg values (5004, '오이호박고추', '상품설명3.png');
insert into productExplainImg values (5004, '오이호박고추', '상품설명4.png');
insert into productExplainImg values (5004, '오이호박고추', '상품설명5.png');

insert into productDetailImg values (5004, '오이호박고추', '상세정보1.png');
insert into productDetailImg values (5004, '오이호박고추', '상세정보2.png');

insert into productExplainImg values (5005, '오이호박고추', '상품설명1.png');
insert into productExplainImg values (5005, '오이호박고추', '상품설명2.png');
insert into productExplainImg values (5005, '오이호박고추', '상품설명3.png');
insert into productExplainImg values (5005, '오이호박고추', '상품설명4.png');

insert into productDetailImg values (5005, '오이호박고추', '상세정보1.png');
insert into productDetailImg values (5005, '오이호박고추', '상세정보2.png');


insert into productExplainImg values (5006, '오이호박고추', '상품설명1.PNG');
insert into productExplainImg values (5006, '오이호박고추', '상품설명2.PNG');
insert into productExplainImg values (5006, '오이호박고추', '상품설명3.png');
insert into productExplainImg values (5006, '오이호박고추', '상품설명4.png');

insert into productDetailImg values (5006, '오이호박고추', '상세정보1.PNG');
insert into productDetailImg values (5006, '오이호박고추', '상세정보2.PNG');

--콩나물버섯(6000)
insert into product values (6001, '국산콩 콩나물 250g(제주콩 무농약)','채소', '콩나물버섯', '1등급 제주콩을 맑은 물로 길러낸(1봉/250g)', 1500, '1봉', '국내','농산물로 별도의 유통기한은 없으나 가급적 빠르게 드시기 바랍니다.', '국산콩 콩나물 250g.jpg', sysdate, 50, 0.0, 0);
insert into product values (6002, '유기농 느타리 버섯 200g','채소', '콩나물버섯', '쫄깃한 식감에 풍부한 맛을 건강까지', 1611, '1봉지', '국내','농산물로 별도의 유통기한은 없으나 가급적 빠르게 드시기 바랍니다.', '유기농 느타리 버섯 200g.jpg',sysdate, 50, 0.0, 0);

insert into productExplainImg values (6001, '콩나물버섯', '상품설명1.jpg');
insert into productExplainImg values (6001, '콩나물버섯', '상품설명2.jpg');
insert into productExplainImg values (6001, '콩나물버섯', '상품설명3.jpg');
insert into productExplainImg values (6001, '콩나물버섯', '상품설명4.jpg');
insert into productExplainImg values (6001, '콩나물버섯', '상품설명5.jpg');
insert into productExplainImg values (6001, '콩나물버섯', '상품설명6.jpg');

insert into productDetailImg values (6001, '콩나물버섯', '상세정보1.jpg');

insert into productExplainImg values (6002, '콩나물버섯', '상품설명1.jpg');
insert into productExplainImg values (6002, '콩나물버섯', '상품설명2.jpg');
insert into productExplainImg values (6002, '콩나물버섯', '상품설명3.jpg');

insert into productDetailImg values (6002, '콩나물버섯', '상세정보1.jpg');

commit;
--***********************************************

insert into product values (3001, '[KF365] GAP 밀양 깻잎 3속', '채소' ,'시금치쌈채소나물', '믿고 먹을 수 있는 상품을 합리적인 가격에, KF365', 1680, '1봉지', '국산', '1주이내', 'GAP밀양깻잎3속.jpg' ,sysdate, 50, 0.0, 0);
insert into product values (3002, '[KF365] 부추 200g', '채소' ,'시금치쌈채소나물', '전으로 부쳐도, 무쳐먹어도 맛있는 만능 채소(200g/봉)', 2640, '1봉지', '국산', '1주이내', '부추200g.jpg', sysdate, 50, 0.0, 0);
insert into product values (3003, '[KF365] 청상추 150g', '채소' ,'시금치쌈채소나물', '믿고 먹을 수 있는 상품을 합리적인 가격에, KF365', 1820, '1봉지', '국산', '1주이내', '청상추150g.jpg',sysdate, 50, 0.0, 8);
insert into product values (3004, '경기 시금치 250g', '채소' ,'시금치쌈채소나물', '두루 사용되는 국민 엽채류', 2690, '1봉지', '국산', '1주이내', '경기 시금치 250g.jpg',sysdate, 50, 0.0, 10);
insert into product values (3005, '알배기 배추 1통', '채소' ,'시금치쌈채소나물', '고소하고 달큼한 맛이 일품인 미니 알배기 배추 1통', 3690, '통', '국산', '1주이내', '알배기 배추 1통.jpeg',sysdate, 50, 0.0, 0);
insert into product values (3006, '친환경 남해초 200g', '채소' ,'시금치쌈채소나물', '해풍을 맞으며 자란 푸른 시금치', 3000, '1봉지', '국산', '1주이내', '친환경 남해초 200g.jpg',sysdate, 50, 0.1, 0);
insert into product values (3007, '친환경 로메인 2종', '채소' ,'시금치쌈채소나물', '아삭한 식감에 깃든 싱그러움', 1690, '1봉지', '국산', '1주이내', '친환경 로메인 2종.jpg', sysdate, 50, 0.2, 5);
insert into product values (3008, '친환경 시금치 200g', '채소' ,'시금치쌈채소나물', '뽀빠이가 좋아하는 바로 그 채소. 친환경 시금치 (200g)', 2700, '1봉지', '국내', '1주이내', '친환경 시금치 200g .jpg', sysdate, 50, 0.0, 0);
insert into product values (3009, '포항초 250g', '채소' ,'시금치쌈채소나물', '진하고 달큰한 포항 시금치 포항초 250g', 3900, '1봉지', '국내산', '1주이내', '포항초 250g.jpg', sysdate, 50, 0.0, 6);

insert into productExplainImg values (3001, '시금치쌈채소나물', '상품설명1.PNG');
insert into productExplainImg values (3001, '시금치쌈채소나물', '상품설명2.PNG');
insert into productExplainImg values (3001, '시금치쌈채소나물', '상품설명3.PNG');
insert into productExplainImg values (3001, '시금치쌈채소나물', '상품설명4.PNG');

insert into productDetailImg values (3001, '시금치쌈채소나물', '상세정보1.PNG');
insert into productDetailImg values (3001, '시금치쌈채소나물', '상세정보2.PNG');

insert into productExplainImg values (3002, '시금치쌈채소나물', '상품설명1.PNG');
insert into productExplainImg values (3002, '시금치쌈채소나물', '상품설명2.PNG');
insert into productExplainImg values (3002, '시금치쌈채소나물', '상품설명3.PNG');

insert into productDetailImg values (3002, '시금치쌈채소나물', '상세정보1.PNG');
insert into productDetailImg values (3002, '시금치쌈채소나물', '상세정보2.PNG');

insert into productExplainImg values (3003, '시금치쌈채소나물', '상품설명1.PNG');
insert into productExplainImg values (3003, '시금치쌈채소나물', '상품설명2.PNG');
insert into productExplainImg values (3003, '시금치쌈채소나물', '상품설명3.PNG');

insert into productDetailImg values (3003, '시금치쌈채소나물', '상세정보1.PNG');
insert into productDetailImg values (3003, '시금치쌈채소나물', '상세정보2.PNG');

insert into productExplainImg values (3004, '시금치쌈채소나물', '상품설명1.PNG');
insert into productExplainImg values (3004, '시금치쌈채소나물', '상품설명2.PNG');
insert into productExplainImg values (3004, '시금치쌈채소나물', '상품설명3.PNG');

insert into productDetailImg values (3004, '시금치쌈채소나물', '상세정보1.PNG');
insert into productDetailImg values (3004, '시금치쌈채소나물', '상세정보2.PNG');

insert into productExplainImg values (3005, '시금치쌈채소나물', '상품설명1.PNG');
insert into productExplainImg values (3005, '시금치쌈채소나물', '상품설명2.PNG');
insert into productExplainImg values (3005, '시금치쌈채소나물', '상품설명3.PNG');

insert into productDetailImg values (3005, '시금치쌈채소나물', '상세정보1.PNG');
insert into productDetailImg values (3005, '시금치쌈채소나물', '상세정보2.PNG');

insert into productExplainImg values (3006, '시금치쌈채소나물', '상품설명1.PNG');
insert into productExplainImg values (3006, '시금치쌈채소나물', '상품설명2.PNG');
insert into productExplainImg values (3006, '시금치쌈채소나물', '상품설명3.PNG');

insert into productDetailImg values (3006, '시금치쌈채소나물', '상세정보1.PNG');
insert into productDetailImg values (3006, '시금치쌈채소나물', '상세정보2.PNG');

insert into productExplainImg values (3007, '시금치쌈채소나물', '상품설명1.PNG');
insert into productExplainImg values (3007, '시금치쌈채소나물', '상품설명2.PNG');
insert into productExplainImg values (3007, '시금치쌈채소나물', '상품설명3.PNG');
insert into productExplainImg values (3007, '시금치쌈채소나물', '상품설명4.PNG');

insert into productDetailImg values (3007, '시금치쌈채소나물', '상세정보1.PNG');
insert into productDetailImg values (3007, '시금치쌈채소나물', '상세정보2.PNG');

insert into productExplainImg values (3008, '시금치쌈채소나물', '상품설명1.PNG');
insert into productExplainImg values (3008, '시금치쌈채소나물', '상품설명2.PNG');
insert into productExplainImg values (3008, '시금치쌈채소나물', '상품설명3.PNG');
insert into productExplainImg values (3008, '시금치쌈채소나물', '상품설명4.PNG');

insert into productDetailImg values (3008, '시금치쌈채소나물', '상세정보1.PNG');
insert into productDetailImg values (3008, '시금치쌈채소나물', '상세정보2.PNG');

insert into productExplainImg values (3009, '시금치쌈채소나물', '상품설명1.PNG');
insert into productExplainImg values (3009, '시금치쌈채소나물', '상품설명2.PNG');
insert into productExplainImg values (3009, '시금치쌈채소나물', '상품설명3.PNG');

insert into productDetailImg values (3009, '시금치쌈채소나물', '상세정보1.PNG');
insert into productDetailImg values (3009, '시금치쌈채소나물', '상세정보2.PNG');

COMMIT;
delete productExplainImg;
delete productDetailImg;
select * from productDetailImg;
select * from productExplainImg;
select * from product;



--상품후기
select a.psubject, a.pimg, b.orderNum, b.cnt, b.pCode,b.userid from product a, order_detail b where a.pCode=b.pCode ;

select a.order_date, a.ordernum, a.payment, b.pCode from orders a, order_detail b where a.orderNum=b.orderNum and b.userID='dacom';

select d.order_date, p.psubject, p.pimg, d.orderNum, d.payment from product p, (select a.order_date, a.ordernum, a.payment, b.pCode from orders a, order_detail b where a.orderNum=b.orderNum and b.userID='dacom') d where p.pCode=d.pCode order by d.orderNum asc;

select b.bkNum, b.userID, b.pCode, b.orderCnt, p.psubject, p.pimg, p.price from product p, bucket b where p.pCode=b.pCode and b.userID='dacom';
select b.bkNum, b.userID, b.pCode, b.orderCnt,p.subcategory, p.psubject, p.pimg, p.price from product p, bucket b where p.pCode=b.pCode and b.userID='dacom';
select count(*) from product p, bucket b where p.pCode=b.pCode and b.userID='dacom';


delete bucket where bkNum=1;

select * from bucket;
commit;
select * from member;
delete member;
insert into member values ('dacom', 123, 123, '김태훈', 'dacom14@naver.com', '01031360586', '충남 천안시 서북구', '한화꿈에그린', '남자', '890318');
insert into delivery values (1, 'dacom', '충남 천안시 서북구', '한화꿈에그린', '김태훈', '01031360586', 1);
insert into delivery values (2, 'dacom', '경기도 수원시 영통구', '우성APT', '아무개', '01042320586', 0);
commit;

select b.bkNum, b.userID, b.pCode, b.orderCnt,p.subcategory, p.psubject, p.pimg, p.price 
		from product p, bucket b 
		where p.pCode=b.pCode and b.userID='dacom';
        
select b.bkNum, b.userID, b.pCode, b.orderCnt,p.subcategory, p.psubject, p.pimg, p.price 
from product p, bucket b 
where p.pCode=b.pCode and b.userID='dacom' and b.bkNum in (32,29,31);
        
select * from orders;

select b.bkNum, b.userID, b.pCode, b.orderCnt,p.subcategory, p.psubject, p.pimg, p.price 
		from product p, bucket b 
		where p.pCode=b.pCode and b.userID='dacom' and rownum=1 and b.bkNum in (31,41);
        
select * from member;
select * from delivery;

insert into delivery values (seq_dNum.nextval,'dacom','충남 천안시 서북구 광장로 260','103동 1302호','김태훈',01031360586,1);
commit;
select * from delivery where userID='dacom' and basicAdd=1;
select * from bucket;

delete bucket where  bknum in (29,30);
        
select userID, pCode, orderCnt from bucket where bknum in (31,41);

select * from bucket where bknum in (31,41);

select b.bkNum, b.userID, b.pCode, b.orderCnt, p.subcategory, p.psubject, p.pimg, p.price from product p, bucket b where p.pCode=b.pCode and b.userID='dacom';

delete from orders;
delete from order_detail;
commit;
select * from orders;
select * from order_detail;
select * from bucket;


insert into orders (orderNum,userID,recipient,addr1,addr2,phoneNum,order_Date,payment)  values (seq_orderNum.nextval, 'dacom', 'asdf','gre','aaaa',123124,sysdate,1000);
insert into order_detail (oddtNum, userID, pCode, cnt, orderNum) values (seq_oddtNum.nextval, 'dacom', 4000, 3, seq_orderNum.currval);
select seq_orderNum.currval from dual;
select seq_orderNum.nextval from dual;

insert into order_detail (oddtNum, userID, pCode, cnt, orderNum) 
		values (seq_oddtNum.nextval, 'dacom', 1111, 3, (select max(orderNum) from orders));


desc orders;

delete bucket where bkNum in (43,31);

select * from orders;

select p.psubject, p.subcategory, p.pimg, p.pcode ,od.ordernum, od.ordercount from product p, (select max(pcode) pcode, count(*) orderCount, ordernum from order_detail where userID='dacom' group by ordernum) od where p.pCode=od.pCode;

select * from orders;
select * from order_detail;
select max(pcode) pcode, ordernum from order_detail where userID='dacom' group by ordernum;
select max(pcode) pcode, count(*), ordernum from order_detail where userID='dacom' group by ordernum;

insert into order_detail (oddtNum, userID, pCode, cnt, orderNum) 
		values (seq_oddtNum.nextval, 'dac', 1111, 3, 2);
        commit;

select o.ordernum, o.order_date,b.subcategory, b.psubject, b.pimg, o.payment, b.ordercount, b.pcode  from orders o, (select p.psubject,p.subcategory, p.pimg, p.pcode ,od.ordernum, od.ordercount from product p, (select max(pcode) pcode, count(*) orderCount, ordernum from order_detail where userID='dacom' group by ordernum) od where p.pCode=od.pCode) b where o.ordernum=b.ordernum;

select * from order_detail od, product p where od.pCode=p.pCode;
desc product;
select p.pcode, p.psubject, p.subcategory, p.price, p.pimg, od.cnt from product p, order_detail od where p.pcode=od.pcode and od.userID='dacom' and od.orderNum='1';

select * from tab;

select * from notice;
insert into notice values (seq_ntNum.nextval,'배송주의', 'marketkurly', sysdate, 0, '겨울철에는 배송이 늦어 질 수 있습니다.'); 
commit;
        
select * from favorit where userID='dacom' and pcode='1000';

select * from bucket;

update bucket set orderCnt=4 where bkNum=68;	
commit;
desc product;
select * from product order by created desc; 
select * from product where subcategory='시금치쌈채소나물' order by salesvolume desc; 
select * from product where subcategory='시금치쌈채소나물' order by price asc; 
select * from product where subcategory='시금치쌈채소나물' order by price desc;

select*from pReview;
select*from product;
select * from pReview where pCode='2001';
select * from product where pCode='2001';
select * from pReview pr inner join product p on pr.pCode=p.pCode where userID='dacom';
select * from pReview NATURAL JOIN product;
select pr.rNum, pr.title,pr.contents,pr.userid,pr.created,pr.cnt,p.* from pReview pr, product p where pr.pCode=p.pCode and userID='dacom';

select * from orders where userID='dacom';
select * from order_detail odt, product p where odt.pCode=p.pCode and userID='dacom';
select * from order_detail NATURAL JOIN product where pCode='1004';
select * from order_detail odt;
delete orders;
delete order_detail;
commit;

select pr.rNum, pr.title,pr.contents,pr.userid,pr.created,pr.cnt,p.* from pReview pr, product p where pr.pCode=p.pCode and userID='dacom' and rNum=21;

select * from delivery;
delete delivery where addr2='ㅁㄴㅇㄹ';
commit;
update delivery set basicadd=1 where delinum=21;
select * from member;
desc member;

delete delivery where deliNum=1;
commit;

select * from pReview;