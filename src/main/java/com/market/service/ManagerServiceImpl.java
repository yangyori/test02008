package com.market.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.market.dao.IManagerDAO;
import com.market.dao.IMykulryDAO;
import com.market.dto.NoticeDTO;
import com.market.dto.QReplyDTO;
import com.market.dto.QnaDTO;
import com.market.dto.QnaReplyDTO;
import com.market.dto.QuestionDTO;
import com.market.vo.PageMaker;

@Service
public class ManagerServiceImpl implements IManagerService {

	@Autowired
	private SqlSession sqlSession;
	
	
	/* 공지사항 시작*/
	@Override
	public List<NoticeDTO> mnoticelistSearch(PageMaker pm) throws Exception {
		IManagerDAO dao = sqlSession.getMapper(IManagerDAO.class);
		List<NoticeDTO> ntos = dao.mnoticelistSearch(pm);
		return ntos;
	}

	public int mnoticeSearchCount(PageMaker pm) throws Exception {
		IManagerDAO dao = sqlSession.getMapper(IManagerDAO.class);
		return dao.mnoticeSearchCount(pm);
	}
	
	//공지사항 작성
	@Override
	public void insertMNotice(NoticeDTO ndto) throws Exception {
		IManagerDAO dao = sqlSession.getMapper(IManagerDAO.class);
		dao.insertMNotice(ndto);
	}
	
	
	/* 공지사항 종료*/
	
	//1:1문의 리스트
	@Override
	public List<QuestionDTO> oneinquirylist(PageMaker pm) throws Exception {
		IManagerDAO dao = sqlSession.getMapper(IManagerDAO.class);
		List<QuestionDTO> qdto = dao.oneinquirylist(pm);
		return qdto;
	}

	//1:1문의 페이지처리
	@Override
	public int oneinquirylistSearchCount(PageMaker pm) throws Exception {
		IManagerDAO dao = sqlSession.getMapper(IManagerDAO.class);
		return dao.oneinquirylistSearchCount(pm);
	}

	//1:1문의 개수 처리
	@Override
	public Integer count() throws Exception {
		IManagerDAO dao = sqlSession.getMapper(IManagerDAO.class);
		int c = dao.count();
		return c;
	}

	//1:1문의 정보 삭제
	@Override
	public void deleteOneInquiry(int qNum) throws Exception {
		IManagerDAO dao = sqlSession.getMapper(IManagerDAO.class);
		dao.deleteOneInquiry(qNum);
		
	}
	
	//1:1문의답글 작성(해당 qNum)
	@Override
	public QuestionDTO selectOneInquiry(int qNum) throws Exception {
		IManagerDAO dao = sqlSession.getMapper(IManagerDAO.class);
		return dao.selectOneInquiry(qNum);
	}
	
	//1:1문의답글 작성insert(해당 qNum)
	@Override
	public void insertQueReply(QReplyDTO qdto) throws Exception {
		IManagerDAO dao = sqlSession.getMapper(IManagerDAO.class);
		dao.insertQueReply(qdto);
	}
	@Override
	public void updateQueReplyStatus(int qNum) throws Exception {
		IManagerDAO dao = sqlSession.getMapper(IManagerDAO.class);
		dao.updateQueReplyStatus(qNum);
	}

	//1:1문의 답글 가져오기
	@Override
	public List<QReplyDTO> list() throws Exception {
		IManagerDAO dao = sqlSession.getMapper(IManagerDAO.class);
		return dao.list();
	}
	
	//1:1문의 답글 삭제
	@Override
	public void deleteQueReply(int rqNum) throws Exception {
		IManagerDAO dao = sqlSession.getMapper(IManagerDAO.class);
		dao.deleteQueReply(rqNum);		
	}
	
	//상품문의 정보
	@Override
	public List<QnaDTO> pQnAlist() throws Exception {
		IManagerDAO dao = sqlSession.getMapper(IManagerDAO.class);
		return dao.pQnAlist();
	}

	//상품문의 정보 삭제
	@Override
	public void deleteQnA(int qNum) throws Exception {
		IManagerDAO dao = sqlSession.getMapper(IManagerDAO.class);
		dao.deleteQnA(qNum);
	}

	//상품문의 답글 작성select(해당 qNum)
	@Override
	public QnaDTO selectQnA(int qNum) throws Exception {
		IManagerDAO dao = sqlSession.getMapper(IManagerDAO.class);
		return dao.selectQnA(qNum);
	}

	//상품문의 답글 작성insert(해당 qNum)
	@Override
	public void insertQnAReply(QnaReplyDTO prdto) throws Exception {
		IManagerDAO dao = sqlSession.getMapper(IManagerDAO.class);
		dao.insertQnAReply(prdto);
	}
	@Override
	public void updateQnAReplyStatus(int qNum) throws Exception {
		IManagerDAO dao = sqlSession.getMapper(IManagerDAO.class);
		dao.updateQnAReplyStatus(qNum);
	}

	//상품문의 답글 갖고 오기
	@Override
	public List<QnaReplyDTO> QnAReplyList() throws Exception {
		IManagerDAO dao = sqlSession.getMapper(IManagerDAO.class);
		return dao.QnAReplyList();
	}

	//상품문의 답글 삭제
	@Override
	public void deleteQnAReply(int rqNum) throws Exception {
		IManagerDAO dao = sqlSession.getMapper(IManagerDAO.class);
		dao.deleteQnAReply(rqNum);
	}

	
}
