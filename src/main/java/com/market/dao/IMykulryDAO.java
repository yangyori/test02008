package com.market.dao;

import java.util.List;

import com.market.dto.DeliveryDTO;
import com.market.dto.FavoritDTO;
import com.market.dto.OdersDTO;
import com.market.dto.OrderDetailDTO;
import com.market.dto.PReviewDTO;
import com.market.dto.QnaDTO;

public interface IMykulryDAO {
	
	//기본 배송지정보 등록
	public void deliveryInsert(DeliveryDTO ddto) throws Exception;
	
	//기본배송지 검색
	public DeliveryDTO deliSelect(String userID) throws Exception;
	
	//선택 배송지 검색
	public DeliveryDTO selectNumDelivery(int deliNum) throws Exception;
	
	//배송지 정보 수정
	public void updateDeliverInfo(DeliveryDTO ddto) throws Exception;
	
	//배송지 검색
	public List<DeliveryDTO> selectAllDelivery(String userID) throws Exception;
	
	//기본 배송지 설정
	public void updateBasicAddr(DeliveryDTO ddto) throws Exception;
	
	//기본 배송지 해제
	public void updateBasicAddrZero(String userID) throws Exception;
	
	//배송지 삭제
	public void deleteDeliverInfo(int deliNum) throws Exception;
	
	//주문내역
	public List<OdersDTO> selectOrderAll(String userID) throws Exception;
	
	//주문내역 상세
	public List<OrderDetailDTO> selectOrderDetail(OrderDetailDTO oddto) throws Exception;
	
	//찜목록
	public List<FavoritDTO> favoritlist(String userID)throws Exception;
	
	//찜상품 개수
	public Integer favcount()throws Exception;
	
	//찜삭제
	public void deletefavoritlist(int fNum)throws Exception;
	
	//찜상품 담기
	public void insertfavoritlist(FavoritDTO fdto) throws Exception;
	
	//상품후기
	public void insertReview(PReviewDTO prdto) throws Exception;
	
	//상품후기 가능 목록 
	public List<OrderDetailDTO> selectOrderPreivew(String userID) throws Exception;
	public List<OdersDTO> selectOrderAllPreview(String userID) throws Exception;

	//내가 작성한 상품후기
	public List<PReviewDTO> selectCompletReviews(String userID) throws Exception;
	
	//상품후기 삭제
	public void deleteReview(int rNum) throws Exception;
	
	//상품후기수정게시판
	public PReviewDTO selectOneReview(PReviewDTO prdto) throws Exception;
	
	//상품후기수정
	public void updateOneReview(PReviewDTO prdto) throws Exception;
	
	//상품문의 등록
	public void insertQnA(QnaDTO qnadto) throws Exception;
	
	//상품문의 정보
	public List<QnaDTO> pQnAlist(String userID) throws Exception;
	
	//상품문의 정보 수정
	public void updateQnA(QnaDTO qnadto) throws Exception;
	
	//상품문의 정보  삭제
	public void deleteQnA(int qNum) throws Exception;
}
