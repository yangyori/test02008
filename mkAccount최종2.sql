drop table pReview;
drop table qnaReply;
drop table qna;
drop table delivery;
drop table bucket;
drop table ORDER_Detail;
drop table orders;
drop table qReply;
drop table question;
drop table favorit;
drop table notice;
drop table member;
drop table product;
drop table productExplainImg;
drop table productDetailImg;

drop sequence seq_dNum; --배송지(delivery)
drop sequence bucketNum; --장바구니(bucket)
drop sequence seq_orderNum; --주문테이블(orders)
drop sequence seq_oddtNum; --주문상세(order_detail)
drop sequence seq_ntNum; --공지사항(ntNum)
drop sequence queNum; --1:1문의(qNum)
drop sequence favNum; --찜목록(fNum)
drop sequence seq_reivewNum; --후기(rNum)
drop sequence seq_pdqNum; --상품문의(qNum)
drop sequence seq_pdqrNum; -- 상품문의 답글(rqNum)
drop sequence seq_querNum; -- 1:1문의 답글 (rqNum)

CREATE TABLE member (  -- 회원가입 TABLE
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


-- 상품정보 table 
CREATE TABLE product(
	pCode		number	NOT NULL	PRIMARY KEY, -- 제품 고유번호 PK
	psubject	nvarchar2(50),  -- 제품 제목(이름) 
	category	nvarchar2(50),  -- 제품 카테고리 
	subcategory	nvarchar2(50),  -- 제품 서브카테고리 
	pinfo		nvarchar2(100),  -- 제품 설명 
	price		number,	       -- 제품 가격	
	unit		nvarchar2(50),  -- 판매 단위 
	origin		nvarchar2(50),  -- 원산지 
	shelfLife	nvarchar2(100),  -- 유통기한
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
	explainimg	nvarchar2(50)
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
	contents	nvarchar2(300), -- 리뷰 내용 
	userID		nvarchar2(50), -- 작성자 이름 
	created		Date,  -- 작성일자 
	cnt		    number,  -- 조회수 
    constraint fk_pReview_userID foreign key(userID) references member (userID) on delete cascade
);


CREATE TABLE qna(  -- Product QNA 제품 
	qNum		number PRIMARY KEY,  -- 질문 글번호 
	pCode		number	NOT NULL,  -- 제품 번호
	userID		nvarchar2(50) NOT null,  -- 사용자 아이디 
	qTitle		nvarchar2(50),  -- 질문 제목 
	qContents	nvarchar2(500), -- 질문 내용 
	created		Date,  -- 작성일자 
	rStatus		number,   -- 답변완료 (1 or 0)
    constraint fk_qna_userID foreign key(userID) references member (userID) on delete cascade
);

-- 제품 QNA 답글 테이블 
CREATE TABLE qnaReply(
	rqNum		number PRIMARY KEY, -- 답글 번호 
	qNum		number,  -- 질문 번호 
	replyText	nvarchar2(500),  -- 답글 내용 
	replyer		nvarchar2(50),  -- 답변인 
	replyDate	Date,  -- 답변 날짜 
    constraint fk_qnaReply_qNum foreign key(qNum) references qna (qNum) on delete cascade
);

-- 배송 
CREATE TABLE delivery(
	deliNum		number	PRIMARY KEY,  -- 배송 번호 
	userID		nvarchar2(30),  -- 고객 아이디 
	addr1		nvarchar2(50),
	addr2		nvarchar2(50),
	recipient	nvarchar2(50), -- 받는사람
	phoneNum	nvarchar2(50),  -- 핸드폰번호 
	basicAdd	number, -- 기본주소 (1 or 0) 
    constraint fk_delivery_userID foreign key(userID) references member (userID) on delete cascade
);

-- 장바구니 테이블 
CREATE TABLE bucket(
	bkNum		number PRIMARY KEY,  -- 장바구니 번호(상품번호)
	userID		nvarchar2(50), -- 사용자 아이디 
	pCode		number, -- 제품 번호 
	orderCnt	number,  -- 주문 수량 
    constraint fk_bucket_userID foreign key(userID) references member (userID) on delete cascade
);

-- 주문하기 테이블 
CREATE TABLE orders(
	orderNum	number PRIMARY KEY,  -- 주문 번호 
	userID		nvarchar2(30) NOT null,  -- 고객 아이디 
    recipient 	nvarchar2(50), -- 받는사람
    addr1		nvarchar2(50), -- 받는사람 주소1
	addr2		nvarchar2(50), -- 받는사람 주소2
	phoneNum	nvarchar2(50), -- 받는사람 핸드폰번호 
	order_Date	Date,  -- 주문 날짜 
	payment		number,  -- 주문 금액 
    constraint fk_orders_userID foreign key(userID) references member (userID) on delete cascade
);

-- 주문 상세 (결제 후)
CREATE TABLE ORDER_Detail(
	oddtNum		number PRIMARY KEY,  -- 주문상세번호 
	userID		nvarchar2(50) NOT null, -- 고객 아이디 
	pCode		number	NOT NULL, -- 제품 번호 
	cnt		    number,  -- 수량 
	orderNum	number,   -- 주문상세번호
    constraint fk_ORDER_Detail_orderNum foreign key(orderNum) references orders (orderNum) on delete cascade
);
-- 관리자 권한 부여 
CREATE TABLE notice(
	ntNum		number	PRIMARY KEY,
	title		nvarchar2(50) NOT NULL,
	manager		nvarchar2(50),
	created		Date,
	cnt		    number,
	contents	nvarchar2(500)
);

CREATE TABLE question(  -- 1:1 문의 table
	qNum		number NOT NULL PRIMARY KEY,
	category	nvarchar2(50), -- 문의 종류 
	title		nvarchar2(50),  -- 문의 제목 
	contents	nvarchar2(500), -- 문의 내용 
	userID		nvarchar2(50),  -- 문의자 아이디
    created     date,
	imgFiles	nvarchar2(50), -- 첨부파일 
    rStatus		number,   -- 답변완료 (1 or 0)
    constraint fk_question_userID foreign key(userID) references member (userID) on delete cascade
);

CREATE TABLE qReply(
	rqNum		number PRIMARY KEY,  -- 답글 번호  
	qNum		number,   -- 질문 번호  
	replyText		nvarchar2(500),  -- 답글 내용 
	replyer		nvarchar2(50),  -- 답변인 
	replyDate		Date, -- 답변일자 
    constraint fk_qReply_qNum foreign key(qNum) references question (qNum) on delete cascade
);


CREATE TABLE favorit(
	fNum		NUMBER PRIMARY KEY,
	pCode		NUMBER,
	userID		nvarchar2(50),
    constraint fk_favorit_userID foreign key(userID) references member (userID) on delete cascade
);


-- ******** 시퀀스 ******** 
create sequence seq_dNum; --배송지(delivery)
create sequence bucketNum; --장바구니(bucket)
create sequence seq_orderNum; --주문테이블(orders)
create sequence seq_oddtNum; --주문상세(order_detail)
create sequence seq_ntNum; --공지사항(ntNum)
create sequence queNum; --1:1문의(qNum)
create sequence favNum; --찜목록(fNum)
create sequence seq_reivewNum; --후기(rNum)
create sequence seq_pdqNum; --상품문의(qNum)
create sequence seq_pdqrNum; -- 상품문의 답글(rqNum)
create sequence seq_querNum; -- 1:1문의 답글 (rqNum)
select * from user_sequences; --현재 생성된 시퀀스


-- ****************상품 insert********************
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

insert into member values ('admin', 'admin', 'admin', 'admin', 'admin', 'admin', 'admin', 'admin', 'admin', 'admin');

commit;

