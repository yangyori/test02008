package com.market.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.market.dao.IProductsDAO;
import com.market.dto.*;
import com.market.vo.PageMaker;

@Service
public class ProductsServiceImpl implements IProductsService{
	
	@Autowired
	private SqlSession sqlSession;


	//서브카테고리별 상품
	@Override
	public List<ProductDTO> selectAllProduct(String subcategory) throws Exception {
		IProductsDAO pdao = sqlSession.getMapper(IProductsDAO.class);
		
		return pdao.selectAllProduct(subcategory);
	}
	//서브카테고리별 상품 수
	@Override
	public Integer selectCountProduct(String subcategory) throws Exception {
		IProductsDAO pdao = sqlSession.getMapper(IProductsDAO.class);
		return pdao.selectCountProduct(subcategory);
	}
	
	//검색된 상품
	@Override
	public List<ProductDTO> selectKeyowrd(String keyword) throws Exception {
		IProductsDAO pdao = sqlSession.getMapper(IProductsDAO.class);
		
		return pdao.selectKeyowrd(keyword);
	}
	
	//검색된 상품 수
	@Override
	public Integer selectKeyowrdCount(String keyword) throws Exception {
		IProductsDAO pdao = sqlSession.getMapper(IProductsDAO.class);
		return pdao.selectKeyowrdCount(keyword);
	}
	
	//검색된 상품 정렬(내림차순)
	@Override
	public List<ProductDTO> selectKeyowrdOrder(ProductDTO pdto) throws Exception {
		IProductsDAO pdao = sqlSession.getMapper(IProductsDAO.class);
		return pdao.selectKeyowrdOrder(pdto);
	}
	
	//검색된 상품 정렬(오름차순)
	@Override
	public List<ProductDTO> selectKeyowrdOrderAsc(ProductDTO pdto) throws Exception {
		IProductsDAO pdao = sqlSession.getMapper(IProductsDAO.class);
		return pdao.selectKeyowrdOrderAsc(pdto);
	}

	
	//신상품순
	@Override
	public List<ProductDTO> selectNewAllProduct(String subcategory) throws Exception {
		IProductsDAO pdao = sqlSession.getMapper(IProductsDAO.class);
		return pdao.selectNewAllProduct(subcategory);
	}
	//판매량순
	@Override
	public List<ProductDTO> selectsellAllProduct(String subcategory) throws Exception {
		IProductsDAO pdao = sqlSession.getMapper(IProductsDAO.class);
		return pdao.selectsellAllProduct(subcategory);
	}
	//낮은 가격순
	@Override
	public List<ProductDTO> selectCheapAllProduct(String subcategory) throws Exception {
		IProductsDAO pdao = sqlSession.getMapper(IProductsDAO.class);
		return pdao.selectCheapAllProduct(subcategory);
	}
	//높은 가격순
	@Override
	public List<ProductDTO> selectExpensiveAllProduct(String subcategory) throws Exception {
		IProductsDAO pdao = sqlSession.getMapper(IProductsDAO.class);
		return pdao.selectExpensiveAllProduct(subcategory);
	}
	
	
	//신상품 목록
	@Override
	public List<ProductDTO> selectNewProduct() throws Exception {
		IProductsDAO pdao = sqlSession.getMapper(IProductsDAO.class);
		return pdao.selectNewProduct();
	}
	//신상품 수
	@Override
	public Integer countNewProduct() throws Exception {
		IProductsDAO pdao = sqlSession.getMapper(IProductsDAO.class);
		int c = pdao.countNewProduct();
		return c;
	}
	
	//베스트 목록
	@Override
	public List<ProductDTO> selectBestProduct() throws Exception {
		IProductsDAO pdao = sqlSession.getMapper(IProductsDAO.class);
		return pdao.selectBestProduct();
	}
	//베스트 상품 수
	@Override
	public Integer countBestProduct() throws Exception {
		IProductsDAO pdao = sqlSession.getMapper(IProductsDAO.class);
		int c = pdao.countBestProduct();
		return c;
	}
	
	//알뜰상품 목록
	@Override
	public List<ProductDTO> selectCheapProduct() throws Exception {
		IProductsDAO pdao = sqlSession.getMapper(IProductsDAO.class);
		return pdao.selectCheapProduct();
	}
	//알뜰상품 수
	@Override
	public Integer countCheapProduct() throws Exception {
		IProductsDAO pdao = sqlSession.getMapper(IProductsDAO.class);
		int c = pdao.countCheapProduct();
		return c;
	}

	//상품정보
	@Override
	public ProductDTO selectProduct(int pCode) throws Exception {
		IProductsDAO pdao = sqlSession.getMapper(IProductsDAO.class);
		return pdao.selectProduct(pCode);
	}
	
	//찜 확인
	@Override
	public FavoritDTO selectFavorit(FavoritDTO fdto) throws Exception {
		IProductsDAO fdao = sqlSession.getMapper(IProductsDAO.class);
		return fdao.selectFavorit(fdto);
	}
		
	//상품설명이미지
	@Override
	public List<ProductExplainImgDTO> selectExpImg(int pCode) throws Exception {
		
		IProductsDAO pdao = sqlSession.getMapper(IProductsDAO.class);
		
		return pdao.selectExpImg(pCode);
	}

	//상세설명이미지
	@Override
	public List<ProductDetailImgDTO> selectDetailImg(int pCode) throws Exception {
		IProductsDAO pdao = sqlSession.getMapper(IProductsDAO.class);
		return pdao.selectDetailImg(pCode);
	}

	//장바구니 담기
	@Override
	public void insertBucket(BucketDTO bdto) throws Exception {
		IProductsDAO pdao = sqlSession.getMapper(IProductsDAO.class);
		pdao.insertBucket(bdto);
	}
	
	//장바구니 비교
	@Override
	public BucketDTO seletEqBucket(BucketDTO bdto) throws Exception {
		IProductsDAO pdao = sqlSession.getMapper(IProductsDAO.class);
		
		return pdao.seletEqBucket(bdto);
	}

	//장바구니
	@Override
	public List<BucketDTO> selectAllBucket(String userID) throws Exception {
		IProductsDAO pdao = sqlSession.getMapper(IProductsDAO.class);
		return pdao.selectAllBucket(userID);
	}
	
	//장바구니 수량 변경
	@Override
	public void updateCountBucket(BucketDTO bdto) throws Exception {
		IProductsDAO pdao = sqlSession.getMapper(IProductsDAO.class);
		pdao.updateCountBucket(bdto);
		
	}

	//장바구니 삭제
	@Override
	public void deleteBucket(int bkNum) throws Exception {
		IProductsDAO pdao = sqlSession.getMapper(IProductsDAO.class);
		pdao.deleteBucket(bkNum);
		
	}

	//장바구니 선택
	@Override
	public List<BucketDTO> selectChekBucket(BucketDTO bdto) throws Exception {
		IProductsDAO pdao = sqlSession.getMapper(IProductsDAO.class);
		
		return pdao.selectChekBucket(bdto);
	}
	
	//장바구니 개수
	@Override
	public int countBucket(BucketDTO bdto) throws Exception {
		IProductsDAO pdao = sqlSession.getMapper(IProductsDAO.class);
		return pdao.countBucket(bdto);
	}

	//방바구니 첫번째
	@Override
	public BucketDTO selectFirstBucket(BucketDTO bdto) throws Exception {
		IProductsDAO pdao = sqlSession.getMapper(IProductsDAO.class);
		
		return pdao.selectFirstBucket(bdto);
	}

	//주문
	@Override
	public void insertOrder(OdersDTO odto) throws Exception {
		IProductsDAO pdao = sqlSession.getMapper(IProductsDAO.class);
		
		pdao.insertOrder(odto);
	}

	//주문상세
	@Override
	public void insertDetailOrder(OrderDetailDTO oddto) throws Exception {
		IProductsDAO pdao = sqlSession.getMapper(IProductsDAO.class);
		
		pdao.insertDetailOrder(oddto);
	}

	//주문상품
	@Override
	public List<BucketDTO> selectOrderBucket(BucketDTO bdto) throws Exception {
		IProductsDAO pdao = sqlSession.getMapper(IProductsDAO.class);
		
		return pdao.selectOrderBucket(bdto);
	}
	
	//주문 상품 판매량 수정
	@Override
	public void updateProductCount(BucketDTO bdto) throws Exception {
		IProductsDAO pdao = sqlSession.getMapper(IProductsDAO.class);
		
		pdao.updateProductCount(bdto);
	}

	//주문 후 장바구니DB 삭제
	@Override
	public void deleteOrderBucket(BucketDTO bdto) throws Exception {
		IProductsDAO pdao = sqlSession.getMapper(IProductsDAO.class);
		pdao.deleteOrderBucket(bdto);
		
	}

	//상품후기
	@Override
	public List<PReviewDTO> selectReviewInfo(int pCode) throws Exception {
		IProductsDAO pdao = sqlSession.getMapper(IProductsDAO.class);
		return pdao.selectReviewInfo(pCode);
	}
	
	//상품후기 조회수증가
	@Override
	public void updatePreviewCnt(int rNum) throws Exception {
		IProductsDAO pdao = sqlSession.getMapper(IProductsDAO.class);
		pdao.updatePreviewCnt(rNum);
	}
	
	//주문한 상품 상품후기 작성 조건
	@Override
	public List<OrderDetailDTO> selectPreviewNull(OrderDetailDTO oddto) throws Exception {
		IProductsDAO pdao = sqlSession.getMapper(IProductsDAO.class);
		return pdao.selectPreviewNull(oddto);
	}

	
	//product QnA 정보 갖고오기(page_maker)
	@Override
	public List<QnaDTO> pQnAlistSearch(PageMaker pm) throws Exception {
		IProductsDAO pdao = sqlSession.getMapper(IProductsDAO.class);
		List<QnaDTO> qdto = pdao.pQnAlistSearch(pm);
		return qdto;
	}

	//product QnA page_maker적용하기
	@Override
	public int pQnAlistSearchCount(PageMaker pm) throws Exception {
		IProductsDAO pdao = sqlSession.getMapper(IProductsDAO.class);
		return pdao.pQnAlistSearchCount(pm);
	}

	//product QnA 개수
	@Override
	public Integer pQnACount(Integer pCode) throws Exception {
		IProductsDAO pdao = sqlSession.getMapper(IProductsDAO.class);
		int c = pdao.pQnACount(pCode);
		return c;
	}

	//product QnA 답글 작성
	@Override
	public void qReplyInsert(QnaReplyDTO qnadto) throws Exception {
		IProductsDAO pdao = sqlSession.getMapper(IProductsDAO.class);
		pdao.qReplyInsert(qnadto);
	}

	//product QnA 답글 불러오기
	@Override
	public List<QnaReplyDTO> list() throws Exception {
		IProductsDAO pdao = sqlSession.getMapper(IProductsDAO.class);
		return pdao.list();
	}





	
	
	

}
