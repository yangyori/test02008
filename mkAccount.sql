CREATE TABLE MEMBER (  -- ȸ������ TABLE
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

select * from member;
drop table member;

drop table product;
-- ��ǰ���� table 
CREATE TABLE product(
	pCode		number	NOT NULL	PRIMARY KEY, -- ��ǰ ������ȣ PK
	psubject		nvarchar2(50),  -- ��ǰ ����(�̸�) 
	category		nvarchar2(50),  -- ��ǰ ī�װ� 
	subcategory	nvarchar2(50),  -- ��ǰ ����ī�װ� 
	pinfo		nvarchar2(100),  -- ��ǰ ���� 
	price		number,	       -- ��ǰ ����	
	unit		nvarchar2(50),  -- �Ǹ� ���� 
	origin		nvarchar2(50),  -- ������ 
	shelfLife		nvarchar2(100),  -- �������
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
	explpainimg	nvarchar2(50)
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
	contents		nvarchar2(300), -- ���� ���� 
	userID		nvarchar2(50), -- �ۼ��� �̸� 
	created		Date,  -- �ۼ����� 
	cnt		number  -- ��ȸ�� 
);

CREATE TABLE qna(  -- Product QNA ��ǰ 
	qNum		number PRIMARY KEY,  -- ���� �۹�ȣ 
	pCode		number	NOT NULL,  -- ��ǰ ��ȣ
	userID		nvarchar2(50) NOT null,  -- ����� ���̵� 
	qTitle		nvarchar2(50),  -- ���� ���� 
	qContents	nvarchar2(500), -- ���� ���� 
	created		Date,  -- �ۼ����� 
	rStatus		number,   -- �亯�Ϸ� (1 or 0)
	secNum		number  -- ��б� ó�� ����(1 or 0)
);

drop table delivery;
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

-- ��ǰ QNA ��� ���̺� 
CREATE TABLE qnaReply(
	rqNum		number PRIMARY KEY, -- ��� ��ȣ 
	qNum		number,  -- ���� ��ȣ 
	replyText	nvarchar2(500),  -- ��� ���� 
	replyer		nvarchar2(50),  -- �亯�� 
	replyDate	Date  -- �亯 ��¥ 
);

drop table bucket;
update product set salesvolume=(select salesvolume from product where pCode=3004)+1 where pCode=3004;
select salesvolume from product where pCode=3004;
-- ��ٱ��� ���̺� 
CREATE TABLE bucket(
	bkNum		number	NOT NULL PRIMARY KEY,  -- ��ٱ��� ��ȣ(��ǰ��ȣ)
	userID		nvarchar2(50), -- ����� ���̵� 
	pCode		number, -- ��ǰ ��ȣ 
	orderCnt	number,  -- �ֹ� ���� 
    orderchk    number DEFAULT 0
);
select * from product where pCode in (1001,3001);

select*from bucket;

drop table orders;
-- �ֹ��ϱ� ���̺� 
CREATE TABLE orders(
	orderNum	number,  -- �ֹ� ��ȣ 
	userID		nvarchar2(30) NOT null,  -- �� ���̵� 
    recipient 	nvarchar2(50), -- �޴»��
    addr1		nvarchar2(50), -- �޴»�� �ּ�1
	addr2		nvarchar2(50), -- �޴»�� �ּ�2
	phoneNum	number, -- �޴»�� �ڵ�����ȣ 
	order_Date	Date,  -- �ֹ� ��¥ 
	payment		number  -- �ֹ� �ݾ� 
);

drop table ORDER_Detail;
-- �ֹ� �� (���� ��)
CREATE TABLE ORDER_Detail(
	oddtNum		number PRIMARY KEY,  -- �ֹ��󼼹�ȣ 
	userID		nvarchar2(50) NOT null, -- �� ���̵� 
	pCode		number	NOT NULL, -- ��ǰ ��ȣ 
	cnt		number,  -- ���� 
	orderNum		number   -- �ֹ��󼼹�ȣ 
);
-- ������ ���� �ο� 
CREATE TABLE notice(
	ntNum		number	PRIMARY KEY,
	title		nvarchar2(50) NOT NULL,
	manager		nvarchar2(50),
	created		Date,
	cnt			number,
	contents	nvarchar2(500)
);

CREATE TABLE question(  -- 1:1 ���� table
	qNum		number NOT NULL PRIMARY KEY,
	category	nvarchar2(50), -- ���� ���� 
	title		nvarchar2(50),  -- ���� ���� 
	contents	nvarchar2(500), -- ���� ���� 
	userID		nvarchar2(50),  -- ������ ���̵� 
	imgFiles	nvarchar2(50) -- ÷������ 
);

CREATE TABLE qReply(
	rqNum		number PRIMARY KEY,  -- ��� ��ȣ  
	qNum		number,   -- ���� ��ȣ  
	replyText	nvarchar2(500),  -- ��� ���� 
	replyer		nvarchar2(50),  -- �亯�� 
	replyDate	Date -- �亯���� 
);


drop table favorit;
CREATE TABLE favorit(
	fNum	NUMBER PRIMARY KEY,
	pCode	NUMBER,
	userID	nvarchar2(50),
    fcheck  NUMBER -- 0: none, 1: ���ƿ�
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


-- ****************��ǰ insert********************

delete productExplainImg;
delete productDetailImg;
delete product; 
commit;

--*******************
desc product;
select * from product where subcategory='�������ڴ��';
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
--***********************************************

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

COMMIT;
delete productExplainImg;
delete productDetailImg;
select * from productDetailImg;
select * from productExplainImg;
select * from product;



--��ǰ�ı�
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
insert into member values ('dacom', 123, 123, '������', 'dacom14@naver.com', '01031360586', '�泲 õ�Ƚ� ���ϱ�', '��ȭ�޿��׸�', '����', '890318');
insert into delivery values (1, 'dacom', '�泲 õ�Ƚ� ���ϱ�', '��ȭ�޿��׸�', '������', '01031360586', 1);
insert into delivery values (2, 'dacom', '��⵵ ������ ���뱸', '�켺APT', '�ƹ���', '01042320586', 0);
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

insert into delivery values (seq_dNum.nextval,'dacom','�泲 õ�Ƚ� ���ϱ� ����� 260','103�� 1302ȣ','������',01031360586,1);
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
insert into notice values (seq_ntNum.nextval,'�������', 'marketkurly', sysdate, 0, '�ܿ�ö���� ����� �ʾ� �� �� �ֽ��ϴ�.'); 
commit;
        
select * from favorit where userID='dacom' and pcode='1000';

select * from bucket;

update bucket set orderCnt=4 where bkNum=68;	
commit;
desc product;
select * from product order by created desc; 
select * from product where subcategory='�ñ�ġ��ä�ҳ���' order by salesvolume desc; 
select * from product where subcategory='�ñ�ġ��ä�ҳ���' order by price asc; 
select * from product where subcategory='�ñ�ġ��ä�ҳ���' order by price desc;

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
delete delivery where addr2='��������';
commit;
update delivery set basicadd=1 where delinum=21;
select * from member;
desc member;

delete delivery where deliNum=1;
commit;

select * from pReview;