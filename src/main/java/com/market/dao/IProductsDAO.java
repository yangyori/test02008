package com.market.dao;

import java.util.List;

import com.market.dto.*;
import com.market.vo.PageMaker;

public interface IProductsDAO {
	
	//서브카테고리별 상품
	public List<ProductDTO> selectAllProduct(String subcategory) throws Exception;
	
	//서브카테고리별 상품 수
	public Integer selectCountProduct(String subcategory) throws Exception;
	
	//검색된 상품
	public List<ProductDTO> selectKeyowrd(String keyword) throws Exception;
	
	//검색된 상품 수
	public Integer selectKeyowrdCount(String keyword) throws Exception;
	
	//검색된 상품 정렬(내림차순)
	public List<ProductDTO> selectKeyowrdOrder(ProductDTO pdto) throws Exception;
	
	//검색된 상품 정렬(오름차순)
	public List<ProductDTO> selectKeyowrdOrderAsc(ProductDTO pdto) throws Exception;
	
	//신상품순
	public List<ProductDTO> selectNewAllProduct(String subcategory) throws Exception;
	//판매량순
	public List<ProductDTO> selectsellAllProduct(String subcategory) throws Exception;
	//낮은 가격순
	public List<ProductDTO> selectCheapAllProduct(String subcategory) throws Exception;
	//높은 가격순
	public List<ProductDTO> selectExpensiveAllProduct(String subcategory) throws Exception;
	
	//신상품 목록
	public List<ProductDTO> selectNewProduct()throws Exception;
	//신상품 개수
	public Integer countNewProduct()throws Exception;
	
	//베스트 목록
	public List<ProductDTO> selectBestProduct()throws Exception;
	//베스트 상품 개수
	public Integer countBestProduct()throws Exception;
	
	//알뜰상품 목록
	public List<ProductDTO> selectCheapProduct()throws Exception;
	//알뜰상품 개수
	public Integer countCheapProduct()throws Exception;
		
	//상품정보
	public ProductDTO selectProduct(int pCode) throws Exception;
	
	//찜 확인
	public FavoritDTO selectFavorit(FavoritDTO fdto) throws Exception;
	
	//상품설명이미지
	public List<ProductExplainImgDTO> selectExpImg(int pCode) throws Exception;
	
	//상세설명이미지
	public List<ProductDetailImgDTO> selectDetailImg(int pCode) throws Exception;
	
	//장바구니담기
	public void insertBucket(BucketDTO bdto) throws Exception;
	
	//장바구니 비교
	public BucketDTO seletEqBucket(BucketDTO bdto) throws Exception;
	
	//장바구니
	public List<BucketDTO> selectAllBucket(String userID) throws Exception;
	
	//장바구니 상품 수량 변경
	public void updateCountBucket(BucketDTO bdto) throws Exception;
	
	//장바구니 삭제
	public void deleteBucket(int bkNum) throws Exception;
	
	//장바구니 선택
	public List<BucketDTO> selectChekBucket(BucketDTO bdto) throws Exception;
	
	//장바구니 상품개수
	public int countBucket(BucketDTO bdto) throws Exception;
	
	//장바구니 첫번째
	public BucketDTO selectFirstBucket(BucketDTO bdto) throws Exception;
	
	//주문
	public void insertOrder(OdersDTO odto) throws Exception;
	
	//주문상세
	public void insertDetailOrder(OrderDetailDTO oddto) throws Exception;
	
	//주문상품 
	public List<BucketDTO> selectOrderBucket(BucketDTO bdto) throws Exception;
	
	//주문 상품 판매량 수정
	public void updateProductCount(BucketDTO bdto) throws Exception;
	
	//주문 후 장바구니DB 삭제
	public void deleteOrderBucket(BucketDTO bdto) throws Exception;

	//상품후기
	public List<PReviewDTO> selectReviewInfo(int pCode) throws Exception;
	
	//상품후기 조회수증가
	public void updatePreviewCnt(int rNum) throws Exception;
	
	//주문한 상품 상품후기 작성 조건
	public List<OrderDetailDTO> selectPreviewNull(OrderDetailDTO oddto) throws Exception;
	
	//product QnA 정보 갖고오기(page_maker)
	public List<QnaDTO> pQnAlistSearch(PageMaker pm)throws Exception;
	
	//product QnA page_maker적용하기
	public int pQnAlistSearchCount(PageMaker pm)throws Exception;
	
	//product QnA 개수
	public Integer pQnACount(Integer pCode)throws Exception;
	
	//product QnA 답글 달기
	public void qReplyInsert(QnaReplyDTO qnadto)throws Exception;

	//product QnA 답글 불러오기
	public List<QnaReplyDTO> list() throws Exception;
}
