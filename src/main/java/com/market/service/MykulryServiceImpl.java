package com.market.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.market.dao.IMykulryDAO;
import com.market.dto.DeliveryDTO;
import com.market.dto.FavoritDTO;
import com.market.dto.OdersDTO;
import com.market.dto.OrderDetailDTO;
import com.market.dto.PReviewDTO;
import com.market.dto.QnaDTO;

@Service
public class MykulryServiceImpl implements IMykulryService {
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void deliveryInsert(DeliveryDTO ddto) throws Exception {
		IMykulryDAO mydao = sqlSession.getMapper(IMykulryDAO.class);
	    mydao.deliveryInsert(ddto);
	}

	@Override
	public DeliveryDTO deliSelect(String userID) throws Exception {
		IMykulryDAO mydao = sqlSession.getMapper(IMykulryDAO.class);
		return mydao.deliSelect(userID);
	}

	//주문내역
	@Override
	public List<OdersDTO> selectOrderAll(String userID) throws Exception {
		IMykulryDAO mydao = sqlSession.getMapper(IMykulryDAO.class);
		return mydao.selectOrderAll(userID);
	}

	@Override
	public List<OrderDetailDTO> selectOrderDetail(OrderDetailDTO oddto) throws Exception {
		IMykulryDAO mydao = sqlSession.getMapper(IMykulryDAO.class);
		return mydao.selectOrderDetail(oddto);
	}
	
	/* 찜 목록 시작 */
	@Override
	public List<FavoritDTO> favoritlist(String userID) throws Exception {
		IMykulryDAO dao = sqlSession.getMapper(IMykulryDAO.class);
		List<FavoritDTO> ftos = dao.favoritlist(userID);
		return ftos;
	}

	@Override
	public Integer favcount() throws Exception {
		IMykulryDAO dao = sqlSession.getMapper(IMykulryDAO.class);
		int c = dao.favcount();
		return c;
	}

	@Override
	public void deletefavoritlist(int fNum) throws Exception {
		IMykulryDAO dao = sqlSession.getMapper(IMykulryDAO.class);
		dao.deletefavoritlist(fNum);
	}
	
	//찜상품 담기
	@Override
	public void insertfavoritlist(FavoritDTO fdto) throws Exception {
		IMykulryDAO dao = sqlSession.getMapper(IMykulryDAO.class);
		dao.insertfavoritlist(fdto);
	}
	/* 찜 목록 종료 */

	//상품후기
	@Override
	public void insertReview(PReviewDTO prdto) throws Exception {
		IMykulryDAO dao = sqlSession.getMapper(IMykulryDAO.class);
		dao.insertReview(prdto);
		
	}

	/*상품후기 가능 목록*/ 
	@Override
	public List<OrderDetailDTO> selectOrderPreivew(String userID) throws Exception {
		IMykulryDAO dao = sqlSession.getMapper(IMykulryDAO.class);
		return dao.selectOrderPreivew(userID);
	}

	@Override
	public List<OdersDTO> selectOrderAllPreview(String userID) throws Exception {
		IMykulryDAO dao = sqlSession.getMapper(IMykulryDAO.class);
		return dao.selectOrderAllPreview(userID);
	}
	/*상품후기 가능 목록*/

	//내가 작성한 상품 후기
	@Override
	public List<PReviewDTO> selectCompletReviews(String userID) throws Exception {
		IMykulryDAO dao = sqlSession.getMapper(IMykulryDAO.class);
		return dao.selectCompletReviews(userID);
	}

	//상품 후기 삭제
	@Override
	public void deleteReview(int rNum) throws Exception {
		IMykulryDAO dao = sqlSession.getMapper(IMykulryDAO.class);
		dao.deleteReview(rNum);
		
	}

	//상품 후기 수정 게시판
	@Override
	public PReviewDTO selectOneReview(PReviewDTO prdto) throws Exception {
		IMykulryDAO dao = sqlSession.getMapper(IMykulryDAO.class);
		return dao.selectOneReview(prdto);
	}

	//항품 후기 수정
	@Override
	public void updateOneReview(PReviewDTO prdto) throws Exception {
		IMykulryDAO dao = sqlSession.getMapper(IMykulryDAO.class);
		dao.updateOneReview(prdto);
		
	}

	//배송지 목록
	@Override
	public List<DeliveryDTO> selectAllDelivery(String userID) throws Exception {
		IMykulryDAO dao = sqlSession.getMapper(IMykulryDAO.class);
		return dao.selectAllDelivery(userID);
	}
	
	//기본 배송지 설정
	@Override
	public void updateBasicAddr(DeliveryDTO ddto) throws Exception {
		IMykulryDAO dao = sqlSession.getMapper(IMykulryDAO.class);
		dao.updateBasicAddr(ddto);
	}
	
	//기본 배송지 해제
	@Override
	public void updateBasicAddrZero(String userID) throws Exception {
		IMykulryDAO dao = sqlSession.getMapper(IMykulryDAO.class);
		dao.updateBasicAddrZero(userID);
	}

	//선택 배송지 검색
	@Override
	public DeliveryDTO selectNumDelivery(int deliNum) throws Exception {
		IMykulryDAO dao = sqlSession.getMapper(IMykulryDAO.class);
		return dao.selectNumDelivery(deliNum);
	}

	//배송지 정보 수정
	@Override
	public void updateDeliverInfo(DeliveryDTO ddto) throws Exception {
		IMykulryDAO dao = sqlSession.getMapper(IMykulryDAO.class);
		dao.updateDeliverInfo(ddto);
		
	}

	//배송지 삭제
	@Override
	public void deleteDeliverInfo(int deliNum) throws Exception {
		IMykulryDAO dao = sqlSession.getMapper(IMykulryDAO.class);
		dao.deleteDeliverInfo(deliNum);
		
	}
	
	//상품문의 등록
	@Override
	public void insertQnA(QnaDTO qnadto) throws Exception {
		IMykulryDAO dao = sqlSession.getMapper(IMykulryDAO.class);
		dao.insertQnA(qnadto);
	}
	
	//상품문의 정보
	@Override
	public List<QnaDTO> pQnAlist(String userID) throws Exception {
		IMykulryDAO dao = sqlSession.getMapper(IMykulryDAO.class);
		return dao.pQnAlist(userID);
	}
	
	//상품문의 정보 삭제
	@Override
	public void updateQnA(QnaDTO qnadto) throws Exception {
		IMykulryDAO dao = sqlSession.getMapper(IMykulryDAO.class);
		dao.updateQnA(qnadto);
		
	}

	//상품문의 정보 삭제
	@Override
	public void deleteQnA(int qNum) throws Exception {
		IMykulryDAO dao = sqlSession.getMapper(IMykulryDAO.class);
		dao.deleteQnA(qNum);
	}


	
}
