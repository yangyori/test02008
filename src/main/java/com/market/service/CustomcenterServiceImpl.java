package com.market.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.market.vo.PageMaker;
import com.market.dao.ICustomcenterDAO;
import com.market.dto.NoticeDTO;
import com.market.dto.QReplyDTO;
import com.market.dto.QuestionDTO;

@Service
public class CustomcenterServiceImpl implements ICustomcenterService{
	
	@Autowired
	private SqlSession sqlSession;

	/* 공지사항 시작*/
	@Override
	public List<NoticeDTO> listSearchCriteria(PageMaker pm) throws Exception {
		ICustomcenterDAO dao = sqlSession.getMapper(ICustomcenterDAO.class);
		List<NoticeDTO> ntos = dao.listSearch(pm);
		return ntos;
	}

	public int listSearchCount(PageMaker pm) throws Exception {
		ICustomcenterDAO dao = sqlSession.getMapper(ICustomcenterDAO.class);
		return dao.listSearchCount(pm);
	}
	
	//공지사항 내용 갖고 오기
	@Override
	public NoticeDTO selectNotice(int ntNum) throws Exception {
		ICustomcenterDAO dao = sqlSession.getMapper(ICustomcenterDAO.class);
		return dao.selectNotice(ntNum);
	}
	
	//공지사항 내용 삭제
	@Override
	public void deleteNotice(int ntNum) throws Exception {
		ICustomcenterDAO dao = sqlSession.getMapper(ICustomcenterDAO.class);
		dao.deleteNotice(ntNum);
	}
	/* 공지사항 종료*/

	/* 1:1문의 시작*/
	@Override
	public List<QuestionDTO> oneinquirylistSearchCriteria(PageMaker pm) throws Exception {
		ICustomcenterDAO dao = sqlSession.getMapper(ICustomcenterDAO.class);
		List<QuestionDTO> qtos = dao.oneinquirylistSearch(pm);
		return qtos;
	}

	@Override
	public int oneinquirylistSearchCount(PageMaker pm) throws Exception {
		ICustomcenterDAO dao = sqlSession.getMapper(ICustomcenterDAO.class);
		return dao.oneinquirylistSearchCount(pm);
	}

	@Override
	public Integer count() throws Exception {
		ICustomcenterDAO dao = sqlSession.getMapper(ICustomcenterDAO.class);
		int c = dao.count();
		return c;
	}
	
	/* 1:1문의 답글달기 */
	@Override
	public void qReplyInsert(QReplyDTO qdto) throws Exception {
		ICustomcenterDAO dao = sqlSession.getMapper(ICustomcenterDAO.class);
		dao.qReplyInsert(qdto);
	}
	/* 1:1문의 답글 불러오기 */
	@Override
	public List<QReplyDTO> list() throws Exception {
		ICustomcenterDAO dao = sqlSession.getMapper(ICustomcenterDAO.class);
		return dao.list();
	}
	/* 1:1문의 답글 삭제
	@Override
	public void delete(Integer fNum) throws Exception {
		ICustomcenterDAO dao = sqlSession.getMapper(ICustomcenterDAO.class);
		dao.delete(fNum);
	}*/
	
	/* 1:1문의 종료*/

	/* 1:1문의 글쓰기 시작*/
	@Override
	public void write(QuestionDTO question) throws Exception {
		ICustomcenterDAO dao = sqlSession.getMapper(ICustomcenterDAO.class);
		dao.create(question);
	}
	
	//1:1문의 삭제
	@Override
	public void deleteQ(int qNum) throws Exception {
		ICustomcenterDAO dao = sqlSession.getMapper(ICustomcenterDAO.class);
		dao.deleteQ(qNum);
		
	}

	
	/* 1:1문의 글쓰기 종료*/
	

	
}
