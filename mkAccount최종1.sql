drop table member;
drop table product;
drop table productExplainImg;
drop table productDetailImg;
drop table pReview;
drop table qna;
drop table delivery;
drop table qnaReply;
drop table bucket;
drop table orders;
drop table ORDER_Detail;
drop table notice;
drop table question;
drop table qReply;
drop table favorit;

drop sequence seq_dNum; --�����(delivery)
drop sequence bucketNum; --��ٱ���(bucket)
drop sequence seq_orderNum; --�ֹ����̺�(orders)
drop sequence seq_oddtNum; --�ֹ���(order_detail)
drop sequence seq_ntNum; --��������(ntNum)
drop sequence queNum; --1:1����(qNum)
drop sequence favNum; --����(fNum)
drop sequence seq_reivewNum; --�ı�(rNum)
drop sequence seq_pdqNum; --��ǰ����(qNum)
drop sequence seq_pdqrNum; -- ��ǰ���� ���(rqNum)
drop sequence seq_querNum; -- 1:1���� ��� (rqNum)

CREATE TABLE member (  -- ȸ������ TABLE
	userID			nvarchar2(30)	NOT NULL PRIMARY KEY, 
	password1		nvarchar2(30)	NOT NULL,  
	password2		nvarchar2(30)	NOT NULL,  -- ��й�ȣ Ȯ�� 
	userName		nvarchar2(12)	NOT NULL,
	email			nvarchar2(50),  
	phone			nvarchar2(50),
	addr1			nvarchar2(50),
	addr2			nvarchar2(50),
	gender			nvarchar2(10),
	birth			nvarchar2(50)
);


-- ��ǰ���� table 
CREATE TABLE product(
	pCode		number	NOT NULL	PRIMARY KEY, -- ��ǰ ������ȣ PK
	psubject	nvarchar2(50),  -- ��ǰ ����(�̸�) 
	category	nvarchar2(50),  -- ��ǰ ī�װ� 
	subcategory	nvarchar2(50),  -- ��ǰ ����ī�װ� 
	pinfo		nvarchar2(100),  -- ��ǰ ���� 
	price		number,	       -- ��ǰ ����	
	unit		nvarchar2(50),  -- �Ǹ� ���� 
	origin		nvarchar2(50),  -- ������ 
	shelfLife	nvarchar2(100),  -- �������
	pimg		nvarchar2(100),  -- ��ǥ �̹���
	created		Date,  -- �ۼ����� 
	amount		number, -- ���� 
	sale		number, -- ����
	salesvolume	number  -- �Ǹŷ� 
);

--��ǰ�����̹���
CREATE TABLE productExplainImg(
	pCode		number not null,
	subcategory	nvarchar2(50),  -- ��ǰ ����ī�װ� 
	explainimg	nvarchar2(50)
);


--�������̹���
CREATE TABLE productDetailImg(
	pCode		number not null,
	subcategory	nvarchar2(50),  -- ��ǰ ����ī�װ� 
	detailimg		nvarchar2(50)
);


CREATE TABLE pReview(  -- ��ǰ ���� TABLE
	rNum		NUMBER	PRIMARY KEY,  -- ���� ��ȣ PK 
	pCode		number NOT  NULL,
	title		nvarchar2(50) NOT NULL,  -- ���� ���� 
	contents	nvarchar2(300), -- ���� ���� 
	userID		nvarchar2(50), -- �ۼ��� �̸� 
	created		Date,  -- �ۼ����� 
	cnt		    number  -- ��ȸ�� 
);


CREATE TABLE qna(  -- Product QNA ��ǰ 
	qNum		number PRIMARY KEY,  -- ���� �۹�ȣ 
	pCode		number	NOT NULL,  -- ��ǰ ��ȣ
	userID		nvarchar2(50) NOT null,  -- ����� ���̵� 
	qTitle		nvarchar2(50),  -- ���� ���� 
	qContents	nvarchar2(500), -- ���� ���� 
	created		Date,  -- �ۼ����� 
	rStatus		number   -- �亯�Ϸ� (1 or 0)
);

-- ��ǰ QNA ��� ���̺� 
CREATE TABLE qnaReply(
	rqNum		number PRIMARY KEY, -- ��� ��ȣ 
	qNum		number,  -- ���� ��ȣ 
	replyText	nvarchar2(500),  -- ��� ���� 
	replyer		nvarchar2(50),  -- �亯�� 
	replyDate	Date  -- �亯 ��¥ 
);

-- ��� 
CREATE TABLE delivery(
	deliNum		number	PRIMARY KEY,  -- ��� ��ȣ 
	userID		nvarchar2(30) NOT null,  -- �� ���̵� 
	addr1		nvarchar2(50),
	addr2		nvarchar2(50),
	recipient	nvarchar2(50), -- �޴»��
	phoneNum	nvarchar2(50),  -- �ڵ�����ȣ 
	basicAdd	number -- �⺻�ּ� (1 or 0) 
);

-- ��ٱ��� ���̺� 
CREATE TABLE bucket(
	bkNum		number	NOT NULL PRIMARY KEY,  -- ��ٱ��� ��ȣ(��ǰ��ȣ)
	userID		nvarchar2(50), -- ����� ���̵� 
	pCode		number, -- ��ǰ ��ȣ 
	orderCnt	number  -- �ֹ� ���� 
);

-- �ֹ��ϱ� ���̺� 
CREATE TABLE orders(
	orderNum	number,  -- �ֹ� ��ȣ 
	userID		nvarchar2(30) NOT null,  -- �� ���̵� 
    recipient 	nvarchar2(50), -- �޴»��
    addr1		nvarchar2(50), -- �޴»�� �ּ�1
	addr2		nvarchar2(50), -- �޴»�� �ּ�2
	phoneNum	nvarchar2(50), -- �޴»�� �ڵ�����ȣ 
	order_Date	Date,  -- �ֹ� ��¥ 
	payment		number  -- �ֹ� �ݾ� 
);

-- �ֹ� �� (���� ��)
CREATE TABLE ORDER_Detail(
	oddtNum		number PRIMARY KEY,  -- �ֹ��󼼹�ȣ 
	userID		nvarchar2(50) NOT null, -- �� ���̵� 
	pCode		number	NOT NULL, -- ��ǰ ��ȣ 
	cnt		    number,  -- ���� 
	orderNum	number   -- �ֹ��󼼹�ȣ 
);
-- ������ ���� �ο� 
CREATE TABLE notice(
	ntNum		number	PRIMARY KEY,
	title		nvarchar2(50) NOT NULL,
	manager		nvarchar2(50),
	created		Date,
	cnt		    number,
	contents	nvarchar2(500)
);

CREATE TABLE question(  -- 1:1 ���� table
	qNum		number NOT NULL PRIMARY KEY,
	category		nvarchar2(50), -- ���� ���� 
	title		nvarchar2(50),  -- ���� ���� 
	contents		nvarchar2(500), -- ���� ���� 
	userID		nvarchar2(50),  -- ������ ���̵�
    created     date,
	imgFiles		nvarchar2(50), -- ÷������ 
    rStatus		number   -- �亯�Ϸ� (1 or 0)
);

CREATE TABLE qReply(
	rqNum		number PRIMARY KEY,  -- ��� ��ȣ  
	qNum		number,   -- ���� ��ȣ  
	replyText		nvarchar2(500),  -- ��� ���� 
	replyer		nvarchar2(50),  -- �亯�� 
	replyDate		Date -- �亯���� 
);


CREATE TABLE favorit(
	fNum		NUMBER PRIMARY KEY,
	pCode		NUMBER,
	userID		nvarchar2(50)
);


-- ******** ������ ******** 
select * from user_sequences; --���� ������ ������
create sequence seq_dNum; --�����(delivery)
create sequence bucketNum; --��ٱ���(bucket)
create sequence seq_orderNum; --�ֹ����̺�(orders)
create sequence seq_oddtNum; --�ֹ���(order_detail)
create sequence seq_ntNum; --��������(ntNum)
create sequence queNum; --1:1����(qNum)
create sequence favNum; --����(fNum)
create sequence seq_reivewNum; --�ı�(rNum)
create sequence seq_pdqNum; --��ǰ����(qNum)
create sequence seq_pdqrNum; -- ��ǰ���� ���(rqNum)
create sequence seq_querNum; -- 1:1���� ��� (rqNum)


-- ****************��ǰ insert********************
--�������ڴ��(1000)
insert into product values (1001,'[KF365] ����� 800g', 'ä��', '�������ڴ��', '�����ϰ� ����� ����(1��/800g)',4780, '1����', '����', '��깰�� ������ ��������� ������ ������ ������ ��ñ� �ٶ��ϴ�.', '����� 800g.jpg', sysdate, 50, 0.0, 0);
insert into product values (1002, '[KF365] ȣ�ڰ��� 800g', 'ä��', '�������ڴ��', '���� �����ϰ� ������ ȣ�ڰ���(1��/800g)',5580, '1����', '����', '��깰�� ������ ��������� ������ ������ ������ ��ñ� �ٶ��ϴ�.', 'ȣ�ڰ��� 800g.jpg', sysdate, 50, 0.0, 0);
insert into product values (1003, '���� ���� 1kg', 'ä��', '�������ڴ��', '���ֵ����� �ڶ� ���� ���� ä��', 3190, '1����', '����', '��깰�� ������ ��������� ������ ������ ������ ��ñ� �ٶ��ϴ�.', '���� ���� 1kg.jpg',  sysdate, 50, 0.0, 0);
insert into product values (1004, 'ģȯ�� ���� 600g', 'ä��', '�������ڴ��', '� ������ �ص� �� ��︮�� ����� ����', 2690, '1��', '����', '��깰�� ������ ��������� ������ ������ ������ ��ñ� �ٶ��ϴ�.', 'ģȯ�� ���� 600g.jpg',  sysdate, 50, 0.0, 0);
insert into product values (1005, 'ģȯ�� ��� 500g', 'ä��', '�������ڴ��', '����° ���� �� �ִ� ģȯ�� ����(500g ����)', 2990, '1����', '����', '��깰�� ������ ��������� ������ ������ ������ ��ñ� �ٶ��ϴ�.', 'ģȯ�� ��� 500g.jpeg',  sysdate, 50, 0.0, 0);
insert into product values (1006, '[KF365] ���� 1kg', 'ä��', '�������ڴ��', '�ϰ� ���� �� �ִ� ��ǰ�� �ո����� ���ݿ�, KF365', 3490, '1�ڽ�', '����', '��깰�� ������ ��������� ������ ������ ������ ��ñ� �ٶ��ϴ�.', '���� 1kg.jpg',  sysdate, 50, 0.0, 0);
insert into product values (1007,'ģȯ�� ȣ�ڰ��� 1kg', 'ä��', '�������ڴ��', '��� �ӻ츸ŭ ���� ������', 7490, '1�ڽ�', '����', '��깰�� ������ ��������� ������ ������ ������ ��ñ� �ٶ��ϴ�.', 'ģȯ�� ȣ�ڰ��� 1kg.jpg ',  sysdate, 50, 0.0, 0);
insert into product values (1008, '�ѳ� ���� 300g', 'ä��', '�������ڴ��', '���� ���� ���� �ҿ뷮 ��������', 1790, '1����', '����', '��깰�� ������ ��������� ������ ������ ������ ��ñ� �ٶ��ϴ�.', '�ѳ� ���� 300g.jpg',  sysdate, 50, 0.0, 0);
insert into product values (1009, '�ѳ� ��� 1��', 'ä��', '�������ڴ��', '�� �ϳ��� �ʿ��� �� �ѳ� ���',1300, '1����', '����', '��깰�� ������ ��������� ������ ������ ������ ��ñ� �ٶ��ϴ�.', '�ѳ� ��� 1��.jpg',  sysdate, 50, 0.0, 0);

insert into productExplainImg values (1001, '�������ڴ��', '��ǰ����1.jpg');
insert into productExplainImg values (1001, '�������ڴ��', '��ǰ����2.PNG');
insert into productExplainImg values (1001, '�������ڴ��', '��ǰ����3.PNG');
insert into productExplainImg values (1001, '�������ڴ��', '��ǰ����4.PNG');

insert into productDetailImg values (1001, '�������ڴ��', '������1.PNG');
insert into productDetailImg values (1001, '�������ڴ��', '������2.PNG');

insert into productExplainImg values (1002, '�������ڴ��', '��ǰ����1.jpg');
insert into productExplainImg values (1002, '�������ڴ��', '��ǰ����2.PNG');
insert into productExplainImg values (1002, '�������ڴ��', '��ǰ����3.PNG');
insert into productExplainImg values (1002, '�������ڴ��', '��ǰ����4.PNG');

insert into productDetailImg values (1002, '�������ڴ��', '������1.jpg');
insert into productDetailImg values (1002, '�������ڴ��', '������2.PNG');

insert into productExplainImg values (1003, '�������ڴ��', '��ǰ����1.jpg');
insert into productExplainImg values (1003, '�������ڴ��', '��ǰ����2.PNG');
insert into productExplainImg values (1003, '�������ڴ��', '��ǰ����3.PNG');

insert into productDetailImg values (1003, '�������ڴ��', '������1.PNG');
insert into productDetailImg values (1003, '�������ڴ��', '������2.PNG');

insert into productExplainImg values (1004, '�������ڴ��', '��ǰ����1.jpg');
insert into productExplainImg values (1004, '�������ڴ��', '��ǰ����2.PNG');
insert into productExplainImg values (1004, '�������ڴ��', '��ǰ����3.PNG');
insert into productExplainImg values (1004, '�������ڴ��', '��ǰ����4.PNG');

insert into productDetailImg values (1004, '�������ڴ��', '������1.PNG');
insert into productDetailImg values (1004, '�������ڴ��', '������2.PNG');

insert into productExplainImg values (1005, '�������ڴ��', '��ǰ����1.jpg');
insert into productExplainImg values (1005, '�������ڴ��', '��ǰ����2.PNG');
insert into productExplainImg values (1005, '�������ڴ��', '��ǰ����3.PNG');
insert into productExplainImg values (1005, '�������ڴ��', '��ǰ����4.PNG');

insert into productDetailImg values (1005, '�������ڴ��', '������1.PNG');
insert into productDetailImg values (1005, '�������ڴ��', '������2.PNG');

insert into productExplainImg values (1006, '�������ڴ��', '��ǰ����1.jpg');
insert into productExplainImg values (1006, '�������ڴ��', '��ǰ����2.PNG');
insert into productExplainImg values (1006, '�������ڴ��', '��ǰ����3.PNG');
insert into productExplainImg values (1006, '�������ڴ��', '��ǰ����4.PNG');

insert into productDetailImg values (1006, '�������ڴ��', '������1.PNG');
insert into productDetailImg values (1006, '�������ڴ��', '������2.PNG');

insert into productExplainImg values (1007, '�������ڴ��', '��ǰ����1.jpg');
insert into productExplainImg values (1007, '�������ڴ��', '��ǰ����2.PNG');
insert into productExplainImg values (1007, '�������ڴ��', '��ǰ����3.PNG');
insert into productExplainImg values (1007, '�������ڴ��', '��ǰ����4.PNG');

insert into productDetailImg values (1007, '�������ڴ��', '������1.PNG');
insert into productDetailImg values (1007, '�������ڴ��', '������2.PNG');

insert into productExplainImg values (1008, '�������ڴ��', '��ǰ����1.jpg');
insert into productExplainImg values (1008, '�������ڴ��', '��ǰ����2.PNG');
insert into productExplainImg values (1008, '�������ڴ��', '��ǰ����3.PNG');

insert into productDetailImg values (1008, '�������ڴ��', '������1.PNG');
insert into productDetailImg values (1008, '�������ڴ��', '������2.PNG');

insert into productExplainImg values (1009, '�������ڴ��', '��ǰ����1.jpg');
insert into productExplainImg values (1009, '�������ڴ��', '��ǰ����2.PNG');
insert into productExplainImg values (1009, '�������ڴ��', '��ǰ����3.PNG');

insert into productDetailImg values (1009, '�������ڴ��', '������1.PNG');
insert into productDetailImg values (1009, '�������ڴ��', '������2.PNG');

--����ݸ�������ī�����(2000)
insert into product values (2001, 'ģȯ�� �̴� ������ī 150g', 'ä��', '����ݸ�������ī�����', '���� ���� ���� ��ŭ��', 3990, '1��', '����', '��깰�� ������ ��������� ������ ������ ������ ��ñ� �ٶ��ϴ�.', 'ģȯ�� �̴� ������ī 150g.png', sysdate, 50, 0.0, 0);
insert into product values (2002, 'ģȯ�� ����ݸ�', 'ä��', '����ݸ�������ī�����', 'ǳ���� ������ ��� �ʷ� �ɼ���', 4290, '1����', '����', '��깰�� ������ ��������� ������ ������ ������ ��ñ� �ٶ��ϴ�.', 'ģȯ�� ����ݸ�.png', sysdate, 50, 0.0, 0);
insert into product values (2003, 'ģȯ�� ���� ����� 400g', 'ä��', '����ݸ�������ī�����', '�ǰ��ϰ� ����� ����ä��', 2290, '1��', '����', '��깰�� ������ ��������� ������ ������ ������ ��ñ� �ٶ��ϴ�.', 'ģȯ�� ���� ����� 400g.jpg', sysdate, 50, 0.0, 0);

insert into productExplainImg values (2001, '����ݸ�������ī�����', '��ǰ����1.jpeg');
insert into productExplainImg values (2001, '����ݸ�������ī�����', '��ǰ����2.png');
insert into productExplainImg values (2001, '����ݸ�������ī�����', '��ǰ����3.png');

insert into productDetailImg values (2001, '����ݸ�������ī�����', '������1.png');
insert into productDetailImg values (2001, '����ݸ�������ī�����', '������2.png');

insert into productExplainImg values (2002, '����ݸ�������ī�����', '��ǰ����1.jpeg');
insert into productExplainImg values (2002, '����ݸ�������ī�����', '��ǰ����2.png');
insert into productExplainImg values (2002, '����ݸ�������ī�����', '��ǰ����3.png');
insert into productExplainImg values (2002, '����ݸ�������ī�����', '��ǰ����4.png');

insert into productDetailImg values (2002, '����ݸ�������ī�����', '������1.png');
insert into productDetailImg values (2002, '����ݸ�������ī�����', '������2.png');

insert into productExplainImg values (2003, '����ݸ�������ī�����', '��ǰ����1.png');
insert into productExplainImg values (2003, '����ݸ�������ī�����', '��ǰ����2.png');
insert into productExplainImg values (2003, '����ݸ�������ī�����', '��ǰ����3.png');
insert into productExplainImg values (2003, '����ݸ�������ī�����', '��ǰ����4.png');

insert into productDetailImg values (2003, '����ݸ�������ī�����', '������1.png');
insert into productDetailImg values (2003, '����ݸ�������ī�����', '������2.png');

--�ñ�ġ��ä�ҳ���(3000)
insert into product values (3001, '[KF365] GAP �о� ���� 3��', 'ä��' ,'�ñ�ġ��ä�ҳ���', '�ϰ� ���� �� �ִ� ��ǰ�� �ո����� ���ݿ�, KF365', 1680, '1����', '����', '1���̳�', 'GAP�о粢��3��.jpg' ,sysdate, 50, 0.0, 0);
insert into product values (3002, '[KF365] ���� 200g', 'ä��' ,'�ñ�ġ��ä�ҳ���', '������ ���ĵ�, ���ĸԾ ���ִ� ���� ä��(200g/��)', 2640, '1����', '����', '1���̳�', '����200g.jpg', sysdate, 50, 0.0, 0);
insert into product values (3003, '[KF365] û���� 150g', 'ä��' ,'�ñ�ġ��ä�ҳ���', '�ϰ� ���� �� �ִ� ��ǰ�� �ո����� ���ݿ�, KF365', 1820, '1����', '����', '1���̳�', 'û����150g.jpg',sysdate, 50, 0.0, 8);
insert into product values (3004, '��� �ñ�ġ 250g', 'ä��' ,'�ñ�ġ��ä�ҳ���', '�η� ���Ǵ� ���� ��ä��', 2690, '1����', '����', '1���̳�', '��� �ñ�ġ 250g.jpg',sysdate, 50, 0.0, 10);
insert into product values (3005, '�˹�� ���� 1��', 'ä��' ,'�ñ�ġ��ä�ҳ���', '����ϰ� ��ŭ�� ���� ��ǰ�� �̴� �˹�� ���� 1��', 3690, '��', '����', '1���̳�', '�˹�� ���� 1��.jpeg',sysdate, 50, 0.0, 0);
insert into product values (3006, 'ģȯ�� ������ 200g', 'ä��' ,'�ñ�ġ��ä�ҳ���', '��ǳ�� ������ �ڶ� Ǫ�� �ñ�ġ', 3000, '1����', '����', '1���̳�', 'ģȯ�� ������ 200g.jpg',sysdate, 50, 0.1, 0);
insert into product values (3007, 'ģȯ�� �θ��� 2��', 'ä��' ,'�ñ�ġ��ä�ҳ���', '�ƻ��� �İ��� ��� �̱׷���', 1690, '1����', '����', '1���̳�', 'ģȯ�� �θ��� 2��.jpg', sysdate, 50, 0.2, 5);
insert into product values (3008, 'ģȯ�� �ñ�ġ 200g', 'ä��' ,'�ñ�ġ��ä�ҳ���', '�Ǻ��̰� �����ϴ� �ٷ� �� ä��. ģȯ�� �ñ�ġ (200g)', 2700, '1����', '����', '1���̳�', 'ģȯ�� �ñ�ġ 200g .jpg', sysdate, 50, 0.0, 0);
insert into product values (3009, '������ 250g', 'ä��' ,'�ñ�ġ��ä�ҳ���', '���ϰ� ��ū�� ���� �ñ�ġ ������ 250g', 3900, '1����', '������', '1���̳�', '������ 250g.jpg', sysdate, 50, 0.0, 6);

insert into productExplainImg values (3001, '�ñ�ġ��ä�ҳ���', '��ǰ����1.PNG');
insert into productExplainImg values (3001, '�ñ�ġ��ä�ҳ���', '��ǰ����2.PNG');
insert into productExplainImg values (3001, '�ñ�ġ��ä�ҳ���', '��ǰ����3.PNG');
insert into productExplainImg values (3001, '�ñ�ġ��ä�ҳ���', '��ǰ����4.PNG');

insert into productDetailImg values (3001, '�ñ�ġ��ä�ҳ���', '������1.PNG');
insert into productDetailImg values (3001, '�ñ�ġ��ä�ҳ���', '������2.PNG');

insert into productExplainImg values (3002, '�ñ�ġ��ä�ҳ���', '��ǰ����1.PNG');
insert into productExplainImg values (3002, '�ñ�ġ��ä�ҳ���', '��ǰ����2.PNG');
insert into productExplainImg values (3002, '�ñ�ġ��ä�ҳ���', '��ǰ����3.PNG');

insert into productDetailImg values (3002, '�ñ�ġ��ä�ҳ���', '������1.PNG');
insert into productDetailImg values (3002, '�ñ�ġ��ä�ҳ���', '������2.PNG');

insert into productExplainImg values (3003, '�ñ�ġ��ä�ҳ���', '��ǰ����1.PNG');
insert into productExplainImg values (3003, '�ñ�ġ��ä�ҳ���', '��ǰ����2.PNG');
insert into productExplainImg values (3003, '�ñ�ġ��ä�ҳ���', '��ǰ����3.PNG');

insert into productDetailImg values (3003, '�ñ�ġ��ä�ҳ���', '������1.PNG');
insert into productDetailImg values (3003, '�ñ�ġ��ä�ҳ���', '������2.PNG');

insert into productExplainImg values (3004, '�ñ�ġ��ä�ҳ���', '��ǰ����1.PNG');
insert into productExplainImg values (3004, '�ñ�ġ��ä�ҳ���', '��ǰ����2.PNG');
insert into productExplainImg values (3004, '�ñ�ġ��ä�ҳ���', '��ǰ����3.PNG');

insert into productDetailImg values (3004, '�ñ�ġ��ä�ҳ���', '������1.PNG');
insert into productDetailImg values (3004, '�ñ�ġ��ä�ҳ���', '������2.PNG');

insert into productExplainImg values (3005, '�ñ�ġ��ä�ҳ���', '��ǰ����1.PNG');
insert into productExplainImg values (3005, '�ñ�ġ��ä�ҳ���', '��ǰ����2.PNG');
insert into productExplainImg values (3005, '�ñ�ġ��ä�ҳ���', '��ǰ����3.PNG');

insert into productDetailImg values (3005, '�ñ�ġ��ä�ҳ���', '������1.PNG');
insert into productDetailImg values (3005, '�ñ�ġ��ä�ҳ���', '������2.PNG');

insert into productExplainImg values (3006, '�ñ�ġ��ä�ҳ���', '��ǰ����1.PNG');
insert into productExplainImg values (3006, '�ñ�ġ��ä�ҳ���', '��ǰ����2.PNG');
insert into productExplainImg values (3006, '�ñ�ġ��ä�ҳ���', '��ǰ����3.PNG');

insert into productDetailImg values (3006, '�ñ�ġ��ä�ҳ���', '������1.PNG');
insert into productDetailImg values (3006, '�ñ�ġ��ä�ҳ���', '������2.PNG');

insert into productExplainImg values (3007, '�ñ�ġ��ä�ҳ���', '��ǰ����1.PNG');
insert into productExplainImg values (3007, '�ñ�ġ��ä�ҳ���', '��ǰ����2.PNG');
insert into productExplainImg values (3007, '�ñ�ġ��ä�ҳ���', '��ǰ����3.PNG');
insert into productExplainImg values (3007, '�ñ�ġ��ä�ҳ���', '��ǰ����4.PNG');

insert into productDetailImg values (3007, '�ñ�ġ��ä�ҳ���', '������1.PNG');
insert into productDetailImg values (3007, '�ñ�ġ��ä�ҳ���', '������2.PNG');

insert into productExplainImg values (3008, '�ñ�ġ��ä�ҳ���', '��ǰ����1.PNG');
insert into productExplainImg values (3008, '�ñ�ġ��ä�ҳ���', '��ǰ����2.PNG');
insert into productExplainImg values (3008, '�ñ�ġ��ä�ҳ���', '��ǰ����3.PNG');
insert into productExplainImg values (3008, '�ñ�ġ��ä�ҳ���', '��ǰ����4.PNG');

insert into productDetailImg values (3008, '�ñ�ġ��ä�ҳ���', '������1.PNG');
insert into productDetailImg values (3008, '�ñ�ġ��ä�ҳ���', '������2.PNG');

insert into productExplainImg values (3009, '�ñ�ġ��ä�ҳ���', '��ǰ����1.PNG');
insert into productExplainImg values (3009, '�ñ�ġ��ä�ҳ���', '��ǰ����2.PNG');
insert into productExplainImg values (3009, '�ñ�ġ��ä�ҳ���', '��ǰ����3.PNG');

insert into productDetailImg values (3009, '�ñ�ġ��ä�ҳ���', '������1.PNG');
insert into productDetailImg values (3009, '�ñ�ġ��ä�ҳ���', '������2.PNG');

--���Ĵ��ĸ��ù���(4000)
insert into product values ( 4001 ,'[KF365] �񸶴� 200g', 'ä��', '���Ĵ��ĸ��ù���', '�ϰ� ���� �� �ִ� ��ǰ�� �ո����� ���ݿ�,KF365',2800 , '��', '����','��깰�� ������ ��������� ������ ������ ������ ��ñ� �ٶ��ϴ�.', '�񸶴� 200g.jpg', sysdate, 50, 0.0, 0);
insert into product values ( 4002 ,'[KF365] ����1.8kg', 'ä��', '���Ĵ��ĸ��ù���', '�ϰ� ������ �ִ� ��ǰ�� �ո����� ���ݿ�,KF365', 3840, '1��', '����','��깰�� ������ ��������� ������ ������ ������ ��ñ� �ٶ��ϴ�.', '����1.8kg.jpg', sysdate, 50, 0.0, 0);
insert into product values ( 4003, '�����500g', 'ä��', '���Ĵ��ĸ��ù���', '���� ���ä��', 2990, '��', '����','��깰�� ������ ��������� ������ ������ ������ ��ñ� �ٶ��ϴ�.', '�����500g.jpeg', sysdate, 50, 0.0, 0);
insert into product values ( 4004, '�񸶴�500g', 'ä��', '���Ĵ��ĸ��ù���', '������ ���� ������ ����',6890 , '1��', '����','��깰�� ������ ��������� ������ ������ ������ ��ñ� �ٶ��ϴ�.', '�񸶴�500g.jpg', sysdate, 50, 0.0, 0);
insert into product values ( 4005, '���� 1����', 'ä��', '���Ĵ��ĸ��ù���', 'ģ���ϰ� Ȱ�뵵 ���� ä��(2.5kg�̻�)',5190, '1��', '����','��깰�� ������ ��������� ������ ������ ������ ��ñ� �ٶ��ϴ�.', '���� 1����.jpg', sysdate, 50, 0.0, 0);
insert into product values ( 4006, '����3kg', 'ä��', '���Ĵ��ĸ��ù���', '�˳��ϰ� ������ �ܰ� �����', 5690, '1��', '����','��깰�� ������ ��������� ������ ������ ������ ��ñ� �ٶ��ϴ�.', '����3kg.jpeg', sysdate, 50, 0.0, 0);
insert into product values ( 4007, '���� ����1�� 1kg', 'ä��', '���Ĵ��ĸ��ù���', '�ܿ�ö ��ö ���� ����� ���� ����.', 2690, '1��', '����','��깰�� ������ ��������� ������ ������ ������ ��ñ� �ٶ��ϴ�.', '���� ����1�� 1kg.jpg', sysdate, 50, 0.0, 0);
insert into product values ( 4008, 'ģȯ�� �� ������1��', 'ä��', '���Ĵ��ĸ��ù���', '�������� ���� �ƻ��� ����', 1300, '1��', '����','��깰�� ������ ��������� ������ ������ ������ ��ñ� �ٶ��ϴ�.', 'ģȯ�� �� ������1��.jpg', sysdate, 50, 0.0, 0);
insert into product values ( 4009, 'ģȯ�� ������ �ٸ� ����200g', 'ä��', '���Ĵ��ĸ��ù���', '���� ���ִ� �ٸ� �κи� ���� ������ ����(1��/200g).', 3490, '1��', '����','��깰�� ������ ��������� ������ ������ ������ ��ñ� �ٶ��ϴ�.', 'ģȯ�� ������ �ٸ� ����200g.jpg', sysdate, 50, 0.0, 0);
insert into product values ( 4010, 'ģȯ�� �ٽӹ���120g', 'ä��', '���Ĵ��ĸ��ù���', '�� �θԱ� ���� �̽��� ä��(1��/120g)',2490, '1��', '����','��깰�� ������ ��������� ������ ������ ������ ��ñ� �ٶ��ϴ�.', 'ģȯ�� �ٽӹ���120g.jpg', sysdate, 50, 0.0, 0);
insert into product values ( 4011, 'ģȯ�� ��ä�� �ӹ��� ����', 'ä��', '���Ĵ��ĸ��ù���', '������� ����� ���� �̴Ϲ���',3690, '1��', '����','��깰�� ������ ��������� ������ ������ ������ ��ñ� �ٶ��ϴ�.', 'ģȯ�� ��ä�� �ӹ��� ����.jpg', sysdate, 50, 0.0, 0);
insert into product values ( 4012, 'ģȯ�� ���θ���50g', 'ä��', '���Ĵ��ĸ��ù���', '����� �丮�� �����ϰ� �̿��ϴ� ���θ���',3290 , '1��', '����','��깰�� ������ ��������� ������ ������ ������ ��ñ� �ٶ��ϴ�.', 'ģȯ�� ���θ���50g.jpg', sysdate, 50, 0.0, 0);

insert into productExplainImg values (4001, '���Ĵ��ĸ��ù���', '��ǰ����1.jpg');
insert into productExplainImg values (4001, '���Ĵ��ĸ��ù���', '��ǰ����2.PNG');
insert into productExplainImg values (4001, '���Ĵ��ĸ��ù���', '��ǰ����3.PNG');

insert into productDetailImg values (4001, '���Ĵ��ĸ��ù���', '������1.PNG');
insert into productDetailImg values (4001, '���Ĵ��ĸ��ù���', '������2.PNG');

insert into productExplainImg values (4002, '���Ĵ��ĸ��ù���', '��ǰ����1.jpg');
insert into productExplainImg values (4002, '���Ĵ��ĸ��ù���', '��ǰ����2.PNG');
insert into productExplainImg values (4002, '���Ĵ��ĸ��ù���', '��ǰ����3.PNG');
insert into productExplainImg values (4002, '���Ĵ��ĸ��ù���', '��ǰ����4.PNG');

insert into productDetailImg values (4002, '���Ĵ��ĸ��ù���', '������1.PNG');
insert into productDetailImg values (4002, '���Ĵ��ĸ��ù���', '������2.PNG');

insert into productExplainImg values (4003, '���Ĵ��ĸ��ù���', '��ǰ����1.jpg');
insert into productExplainImg values (4003, '���Ĵ��ĸ��ù���', '��ǰ����2.PNG');
insert into productExplainImg values (4003, '���Ĵ��ĸ��ù���', '��ǰ����3.PNG');

insert into productDetailImg values (4003, '���Ĵ��ĸ��ù���', '������1.PNG');
insert into productDetailImg values (4003, '���Ĵ��ĸ��ù���', '������2.PNG');

insert into productExplainImg values (4004, '���Ĵ��ĸ��ù���', '��ǰ����1.jpg');
insert into productExplainImg values (4004, '���Ĵ��ĸ��ù���', '��ǰ����2.PNG');
insert into productExplainImg values (4004, '���Ĵ��ĸ��ù���', '��ǰ����3.PNG');

insert into productDetailImg values (4004, '���Ĵ��ĸ��ù���', '������1.PNG');
insert into productDetailImg values (4004, '���Ĵ��ĸ��ù���', '������2.PNG');

insert into productExplainImg values (4005, '���Ĵ��ĸ��ù���', '��ǰ����1.jpg');
insert into productExplainImg values (4005, '���Ĵ��ĸ��ù���', '��ǰ����2.PNG');
insert into productExplainImg values (4005, '���Ĵ��ĸ��ù���', '��ǰ����3.PNG');

insert into productDetailImg values (4005, '���Ĵ��ĸ��ù���', '������1.PNG');
insert into productDetailImg values (4005, '���Ĵ��ĸ��ù���', '������2.PNG');

insert into productExplainImg values (4006, '���Ĵ��ĸ��ù���', '��ǰ����1.jpg');
insert into productExplainImg values (4006, '���Ĵ��ĸ��ù���', '��ǰ����2.PNG');
insert into productExplainImg values (4006, '���Ĵ��ĸ��ù���', '��ǰ����3.PNG');

insert into productDetailImg values (4006, '���Ĵ��ĸ��ù���', '������1.PNG');
insert into productDetailImg values (4006, '���Ĵ��ĸ��ù���', '������2.PNG');

insert into productExplainImg values (4007, '���Ĵ��ĸ��ù���', '��ǰ����1.jpg');
insert into productExplainImg values (4007, '���Ĵ��ĸ��ù���', '��ǰ����2.PNG');
insert into productExplainImg values (4007, '���Ĵ��ĸ��ù���', '��ǰ����3.PNG');

insert into productDetailImg values (4007, '���Ĵ��ĸ��ù���', '������1.PNG');
insert into productDetailImg values (4007, '���Ĵ��ĸ��ù���', '������2.PNG');

insert into productExplainImg values (4008, '���Ĵ��ĸ��ù���', '��ǰ����1.jpg');
insert into productExplainImg values (4008, '���Ĵ��ĸ��ù���', '��ǰ����2.PNG');
insert into productExplainImg values (4008, '���Ĵ��ĸ��ù���', '��ǰ����3.PNG');
insert into productExplainImg values (4008, '���Ĵ��ĸ��ù���', '��ǰ����4.PNG');
insert into productExplainImg values (4008, '���Ĵ��ĸ��ù���', '��ǰ����5.PNG');

insert into productDetailImg values (4008, '���Ĵ��ĸ��ù���', '������1.PNG');
insert into productDetailImg values (4008, '���Ĵ��ĸ��ù���', '������2.PNG');

insert into productExplainImg values (4009, '���Ĵ��ĸ��ù���', '��ǰ����1.jpg');
insert into productExplainImg values (4009, '���Ĵ��ĸ��ù���', '��ǰ����2.PNG');
insert into productExplainImg values (4009, '���Ĵ��ĸ��ù���', '��ǰ����3.PNG');

insert into productDetailImg values (4009, '���Ĵ��ĸ��ù���', '������1.PNG');
insert into productDetailImg values (4009, '���Ĵ��ĸ��ù���', '������2.PNG');

insert into productExplainImg values (4010, '���Ĵ��ĸ��ù���', '��ǰ����1.jpg');
insert into productExplainImg values (4010, '���Ĵ��ĸ��ù���', '��ǰ����2.PNG');
insert into productExplainImg values (4010, '���Ĵ��ĸ��ù���', '��ǰ����3.PNG');
insert into productExplainImg values (4010, '���Ĵ��ĸ��ù���', '��ǰ����4.PNG');

insert into productDetailImg values (4010, '���Ĵ��ĸ��ù���', '������1.PNG');
insert into productDetailImg values (4010, '���Ĵ��ĸ��ù���', '������2.PNG');

insert into productExplainImg values (4011, '���Ĵ��ĸ��ù���', '��ǰ����1.jpg');
insert into productExplainImg values (4011, '���Ĵ��ĸ��ù���', '��ǰ����2.PNG');

insert into productDetailImg values (4011, '���Ĵ��ĸ��ù���', '������1.PNG');
insert into productDetailImg values (4011, '���Ĵ��ĸ��ù���', '������2.PNG');

insert into productExplainImg values (4012, '���Ĵ��ĸ��ù���', '��ǰ����1.jpg');
insert into productExplainImg values (4012, '���Ĵ��ĸ��ù���', '��ǰ����2.PNG');
insert into productExplainImg values (4012, '���Ĵ��ĸ��ù���', '��ǰ����3.PNG');

insert into productDetailImg values (4012, '���Ĵ��ĸ��ù���', '������1.PNG');
insert into productDetailImg values (4012, '���Ĵ��ĸ��ù���', '������2.PNG');

select * from product where subcategory='����ȣ�ڰ���';
--����ȣ�ڰ���(5000)
insert into product values (5001, '[KF365] û����� 200g', 'ä��' ,'����ȣ�ڰ���', '�ϰ� ���� �� �ִ� ��ǰ�� �ո����� �����ݿ� KF365', 2980, '1��', '����', '��깰�� ������ ��������� ������ ������ ������ ��ñ� �ٶ��ϴ�.', 'û����� 200g.jpg', sysdate,50, 0.0, 0);
insert into product values (5002, '���ÿ��� 2��', 'ä��' ,'����ȣ�ڰ���', '�ܴ��� ���� �� �ܸ� ����', 4290, '1��', '����', '��깰�� ������ ��������� ������ ������ ������ ��ñ� �ٶ��ϴ�.', '���ÿ��� 2��.png', sysdate, 50, 0.0, 0);
insert into product values (5003, '����� ���� ��ȣ�� 2��', 'ä��' ,'����ȣ�ڰ���', '���� ��ȣ���� ��ȣ�� ������(400g)', 4300, '1��', '����', '��깰�� ������ ��������� ������ ������ ������ ��ñ� �ٶ��ϴ�.', '����� ���� ��ȣ�� 2��.PNG', sysdate, 50, 0.0, 0);
insert into product values (5004, '����� ���� ��ȣ�� 100g', 'ä��' ,'����ȣ�ڰ���', '�ս��� ���� ���� ��� ����', 2900, '1��', '����', '��깰�� ������ ��������� ������ ������ ������ ��ñ� �ٶ��ϴ�.', '����� ���� ��ȣ�� 100g.png', sysdate, 50, 0.0, 0);
insert into product values (5005, 'ģȯ�� ���� 2��', 'ä��' ,'����ȣ�ڰ���', '����° �Ƚ��ϰ� ���� �� �ִ� ����� ����(2��)', 3590, '1��', '����','��깰�� ������ ��������� ������ ������ ������ ��ñ� �ٶ��ϴ�.', 'ģȯ�� ���� 2��.png', sysdate, 50, 0.0, 0);
insert into product values (5006, 'ģȯ�� ���̰��� 200g', 'ä��' ,'����ȣ�ڰ���', '�ƻ�ƻ� ������ ���̸� ����', 2390, '1��', '����', '��깰�� ������ ��������� ������ ������ ������ ��ñ� �ٶ��ϴ�.', 'ģȯ�� ���̰��� 200g.png', sysdate, 50, 0.0, 0);

insert into productExplainImg values (5001, '����ȣ�ڰ���', '��ǰ����1.jpg');
insert into productExplainImg values (5001, '����ȣ�ڰ���', '��ǰ����2.PNG');
insert into productExplainImg values (5001, '����ȣ�ڰ���', '��ǰ����3.PNG');
insert into productExplainImg values (5001, '����ȣ�ڰ���', '��ǰ����4.PNG');

insert into productDetailImg values (5001, '����ȣ�ڰ���', '������1.PNG');
insert into productDetailImg values (5001, '����ȣ�ڰ���', '������2.PNG');

insert into productExplainImg values (5002, '����ȣ�ڰ���', '��ǰ����1.png');
insert into productExplainImg values (5002, '����ȣ�ڰ���', '��ǰ����2.png');
insert into productExplainImg values (5002, '����ȣ�ڰ���', '��ǰ����3.png');
insert into productExplainImg values (5002, '����ȣ�ڰ���', '��ǰ����4.png');

insert into productDetailImg values (5002, '����ȣ�ڰ���', '������1.png');
insert into productDetailImg values (5002, '����ȣ�ڰ���', '������2.png');

insert into productExplainImg values (5003, '����ȣ�ڰ���', '��ǰ����1.PNG');
insert into productExplainImg values (5003, '����ȣ�ڰ���', '��ǰ����2.png');
insert into productExplainImg values (5003, '����ȣ�ڰ���', '��ǰ����3.png');
insert into productExplainImg values (5003, '����ȣ�ڰ���', '��ǰ����4.png');

insert into productDetailImg values (5003, '����ȣ�ڰ���', '������1.PNG');
insert into productDetailImg values (5003, '����ȣ�ڰ���', '������2.PNG');

insert into productExplainImg values (5004, '����ȣ�ڰ���', '��ǰ����1.png');
insert into productExplainImg values (5004, '����ȣ�ڰ���', '��ǰ����2.png');
insert into productExplainImg values (5004, '����ȣ�ڰ���', '��ǰ����3.png');
insert into productExplainImg values (5004, '����ȣ�ڰ���', '��ǰ����4.png');
insert into productExplainImg values (5004, '����ȣ�ڰ���', '��ǰ����5.png');

insert into productDetailImg values (5004, '����ȣ�ڰ���', '������1.png');
insert into productDetailImg values (5004, '����ȣ�ڰ���', '������2.png');

insert into productExplainImg values (5005, '����ȣ�ڰ���', '��ǰ����1.png');
insert into productExplainImg values (5005, '����ȣ�ڰ���', '��ǰ����2.png');
insert into productExplainImg values (5005, '����ȣ�ڰ���', '��ǰ����3.png');
insert into productExplainImg values (5005, '����ȣ�ڰ���', '��ǰ����4.png');

insert into productDetailImg values (5005, '����ȣ�ڰ���', '������1.png');
insert into productDetailImg values (5005, '����ȣ�ڰ���', '������2.png');


insert into productExplainImg values (5006, '����ȣ�ڰ���', '��ǰ����1.PNG');
insert into productExplainImg values (5006, '����ȣ�ڰ���', '��ǰ����2.PNG');
insert into productExplainImg values (5006, '����ȣ�ڰ���', '��ǰ����3.png');
insert into productExplainImg values (5006, '����ȣ�ڰ���', '��ǰ����4.png');

insert into productDetailImg values (5006, '����ȣ�ڰ���', '������1.PNG');
insert into productDetailImg values (5006, '����ȣ�ڰ���', '������2.PNG');

--�ᳪ������(6000)
insert into product values (6001, '������ �ᳪ�� 250g(������ �����)','ä��', '�ᳪ������', '1��� �������� ���� ���� �淯��(1��/250g)', 1500, '1��', '����','��깰�� ������ ��������� ������ ������ ������ ��ñ� �ٶ��ϴ�.', '������ �ᳪ�� 250g.jpg', sysdate, 50, 0.0, 0);
insert into product values (6002, '����� ��Ÿ�� ���� 200g','ä��', '�ᳪ������', '�̱��� �İ��� ǳ���� ���� �ǰ�����', 1611, '1����', '����','��깰�� ������ ��������� ������ ������ ������ ��ñ� �ٶ��ϴ�.', '����� ��Ÿ�� ���� 200g.jpg',sysdate, 50, 0.0, 0);

insert into productExplainImg values (6001, '�ᳪ������', '��ǰ����1.jpg');
insert into productExplainImg values (6001, '�ᳪ������', '��ǰ����2.jpg');
insert into productExplainImg values (6001, '�ᳪ������', '��ǰ����3.jpg');
insert into productExplainImg values (6001, '�ᳪ������', '��ǰ����4.jpg');
insert into productExplainImg values (6001, '�ᳪ������', '��ǰ����5.jpg');
insert into productExplainImg values (6001, '�ᳪ������', '��ǰ����6.jpg');

insert into productDetailImg values (6001, '�ᳪ������', '������1.jpg');

insert into productExplainImg values (6002, '�ᳪ������', '��ǰ����1.jpg');
insert into productExplainImg values (6002, '�ᳪ������', '��ǰ����2.jpg');
insert into productExplainImg values (6002, '�ᳪ������', '��ǰ����3.jpg');

insert into productDetailImg values (6002, '�ᳪ������', '������1.jpg');

commit;


