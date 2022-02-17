package com.market.service;

import java.util.List;

import com.market.vo.PageMaker;
import com.market.dto.NoticeDTO;
import com.market.dto.QReplyDTO;
import com.market.dto.QnaReplyDTO;
import com.market.dto.QuestionDTO;

public interface ICustomcenterService {
	
	/* 공지사항 시작*/
	public List<NoticeDTO> listSearchCriteria(PageMaker pm) throws Exception;
	
	public int listSearchCount(PageMaker pm) throws Exception;
	
	//공지사항 내용 갖고 오기
	public NoticeDTO selectNotice(int ntNum) throws Exception;
	
	//공지사항 내용 삭제
	public void deleteNotice(int ntNum) throws Exception;
	/* 공지사항 종료*/
	
	/* 1:1문의 시작*/
	public List<QuestionDTO> oneinquirylistSearchCriteria(PageMaker pm)throws Exception;
	
	public int oneinquirylistSearchCount(PageMaker pm)throws Exception;
	
	public Integer count() throws Exception;
	
	/*1:1문의 답글 달기*/
	public void qReplyInsert(QReplyDTO qdto)throws Exception;
	
	/*1:1문의 답글 불러오기*/
	public List<QReplyDTO> list() throws Exception;
	
	/*1:1문의 답글 삭제
	public void delete(Integer fNum)throws Exception;*/
	
	/* 1:1문의 종료*/
	
	/* 1:1문의 글쓰기 시작*/
	public void write(QuestionDTO question) throws Exception;
	
	//1:1문의 삭제
	public void deleteQ(int qNum) throws Exception;
	/* 1:1문의 글쓰기 종료*/
}
