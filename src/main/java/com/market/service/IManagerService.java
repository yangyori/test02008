package com.market.service;

import java.util.List;

import com.market.dto.NoticeDTO;
import com.market.dto.QReplyDTO;
import com.market.dto.QnaDTO;
import com.market.dto.QnaReplyDTO;
import com.market.dto.QuestionDTO;
import com.market.vo.PageMaker;

public interface IManagerService {
	
	/* 공지사항 시작*/
	public List<NoticeDTO> mnoticelistSearch(PageMaker pm)throws Exception;
	
	public int mnoticeSearchCount(PageMaker pm)throws Exception;
	
	//공지사항 작성
	public void insertMNotice(NoticeDTO ndto) throws Exception;
	
	/* 공지사항 종료*/
	
	//1:1문의 리스트
	public List<QuestionDTO> oneinquirylist(PageMaker pm)throws Exception;
	
	//1:1문의 페이지처리
	public int oneinquirylistSearchCount(PageMaker pm)throws Exception;
	
	//1:1문의 개수 처리
	public Integer count()throws Exception;

	//1:1문의 정보 삭제
	public void deleteOneInquiry(int qNum) throws Exception;
	
	//1:1문의답글 작성select(해당 qNum)
	public QuestionDTO selectOneInquiry(int qNum) throws Exception;
	
	//1:1문의답글 작성insert(해당 qNum)
	public void insertQueReply(QReplyDTO qdto) throws Exception;
	public void updateQueReplyStatus(int qNum) throws Exception;
	
	//1:1문의 답글 갖고 오기
	public List<QReplyDTO> list() throws Exception;
	
	//1:1문의 답글 삭제
	public void deleteQueReply(int rqNum)throws Exception;
	
	//상품 문의 리스트
	public List<QnaDTO> pQnAlist() throws Exception;
	
	//상품문의 정보  삭제
	public void deleteQnA(int qNum) throws Exception;
	
	//상품문의 답글 작성select(해당 qNum)
	public QnaDTO selectQnA(int qNum) throws Exception;
	
	//상품문의 답글 작성insert(해당 qNum)
	public void insertQnAReply(QnaReplyDTO prdto) throws Exception;
	public void updateQnAReplyStatus(int qNum) throws Exception;
	
	//상품문의 답글 갖고 오기
	public List<QnaReplyDTO> QnAReplyList() throws Exception;
	
	//상품문의 답글 삭제
	public void deleteQnAReply(int rqNum)throws Exception;
	
}
