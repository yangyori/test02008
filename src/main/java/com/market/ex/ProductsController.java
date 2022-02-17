package com.market.ex;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.market.dto.BucketDTO;
import com.market.dto.DeliveryDTO;
import com.market.dto.FavoritDTO;
import com.market.dto.OdersDTO;
import com.market.dto.OrderDetailDTO;
import com.market.dto.PReviewDTO;
import com.market.dto.ProductDTO;
import com.market.dto.QnaReplyDTO;
import com.market.service.IMemberService;
import com.market.service.IMykulryService;
import com.market.service.IProductsService;
import com.market.vo.PageMaker;


@Controller
@RequestMapping("/products/*")
public class ProductsController {
	
	@Autowired
	private IMemberService mbservice;
	
	@Autowired
	private IProductsService pservice;
	
	@Autowired
	private IMykulryService myservice;

	@RequestMapping(value = "/pdcart", method = RequestMethod.GET)
	public String productsPdcart(HttpSession session, BucketDTO bdto ,Model model) throws Exception {
		
		String userID=(String)session.getAttribute("userID");
		
		model.addAttribute("bklist",pservice.selectAllBucket(userID));
		
		model.addAttribute("ddto", myservice.deliSelect(userID));
		
		return "/products/pdcart";
	}
	
	//ajax 상품담기
	@RequestMapping(value ="/pdcart", method = RequestMethod.POST)
	public ResponseEntity<String> register(@RequestBody BucketDTO bdto) { //@RequestBody: json형태로 담아서 처리
		ResponseEntity<String> entity = null;

		try {
			
			if(pservice.seletEqBucket(bdto)==null) {
				pservice.insertBucket(bdto);
				entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);				
			}else {
				entity = new ResponseEntity<String>("", HttpStatus.OK);
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	//ajax 장바구니 상품 삭제
	@RequestMapping(value = "/pdcart/{bkNum}", method = RequestMethod.DELETE)
	public ResponseEntity<String> remove(@PathVariable("bkNum") Integer bkNum) {
		
		ResponseEntity<String> entity = null;
		try {
			pservice.deleteBucket(bkNum);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	//ajax 장바구니 상품 수량 변경
	@RequestMapping(value = "/pdcart/{bkNum}", method = RequestMethod.PUT)
	public ResponseEntity<String> countUpdate(@PathVariable("bkNum") Integer bkNum,@RequestBody BucketDTO bdto) {
		
		ResponseEntity<String> entity = null;
		try {
			bdto.setBkNum(bkNum);
			pservice.updateCountBucket(bdto);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	//장바구니 배송지
	@RequestMapping(value = "/deliveryCartPop", method = RequestMethod.GET)
	public String cartDeliveryPop(Model model, HttpSession session) throws Exception {
		
		String userID=(String)session.getAttribute("userID");
		model.addAttribute("dlist", myservice.selectAllDelivery(userID));
		
		return "/products/deliveryCartPop";
	}
	
	//장바구니 배송지 내용 변경 화면
	@RequestMapping(value = "/deliveryCartPopUpdate", method = RequestMethod.GET)
	public String CartDeliveryInfoUpdateGet(@RequestParam("deliNum") int deliNum, Model model) throws Exception {
		
		model.addAttribute("ddto", myservice.selectNumDelivery(deliNum));
		
		
		return "/products/deliveryCartPopUpdate";
	}
	
	//장바구니 배송지 내용 변경
	@RequestMapping(value = "/deliveryCartPopUpdate", method = RequestMethod.POST)
	public String CartDeliveryInfoUpdate(DeliveryDTO ddto, Model model) throws Exception {
		
		myservice.updateDeliverInfo(ddto);
		
		
		return "redirect:/products/deliveryCartPop";
	}
	
	//장바구니 배송지 추가 팝업 화면
	@RequestMapping(value = "/deliveryCartPopInsert", method = RequestMethod.GET)
	public String MyKurlyDeliveryPopup() {

		return "/products/deliveryCartPopInsert";
	}
	
	
	
	//상품정보
	@RequestMapping(value = "/pdinfo", method = RequestMethod.GET)
	public String productsPdinfo(@RequestParam("pCode") int pCode, HttpSession session, FavoritDTO fdto, Model model, PageMaker pm) throws Exception {
		
		String userID=(String)session.getAttribute("userID");
		
		//상품정보
		model.addAttribute("pdto", pservice.selectProduct(pCode));
		
		//상품설명이미지
		model.addAttribute("pExImg", pservice.selectExpImg(pCode));
		
		//상세정보이미지
		model.addAttribute("pDetailImg", pservice.selectDetailImg(pCode));
		
		//상품후기
		model.addAttribute("pReviewlist", pservice.selectReviewInfo(pCode));
		
		//찜 확인
		if(userID!=null) {
			fdto.setUserID(userID);//세션으로 아이디 수정
			fdto.setpCode(pCode);
			model.addAttribute("fdto", pservice.selectFavorit(fdto));
		}
		
		//product QnA 추가
		int replyCount = pservice.pQnACount(pCode);
		pm.setTotalCount(replyCount);
		pm.setpCode(pCode);
		
		model.addAttribute("qlist", pservice.pQnAlistSearch(pm));
		pm.setTotalCount(pservice.pQnAlistSearchCount(pm));
		model.addAttribute("qnaCount", pservice.pQnACount(pCode));
		
		//product QnA 답글 불러오기
		model.addAttribute("qnardto", pservice.list());
		
		return "/products/pdinfo";
	}
	
	//ajax 상품 후기 조회수
	@RequestMapping(value = "/previewCnt/{rNum}", method = RequestMethod.PUT)
	public ResponseEntity<String> pcountUpdate(@PathVariable("rNum") Integer rNum) {
		
		ResponseEntity<String> entity = null;
		try {
			System.out.println(rNum);
			pservice.updatePreviewCnt(rNum);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	//ajax 주문해야 상품후기 작성 가능
	@RequestMapping(value = "/preview/{pCode}", method = RequestMethod.POST)
	public ResponseEntity<String> selectEqualOrder(@PathVariable("pCode") Integer pCode, OrderDetailDTO oddto, HttpSession session) {
		
		String userID = (String)session.getAttribute("userID");
		
		oddto.setpCode(pCode);
		oddto.setUserID(userID);
		
		ResponseEntity<String> entity = null;
		try {
			List<OrderDetailDTO> oddlist = pservice.selectPreviewNull(oddto);
			System.out.println(oddlist);
			if(oddlist.isEmpty()) {
				entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
			}
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
		
	// product QnA 답글 작성
	@RequestMapping(value= "/replies", method = RequestMethod.POST)
	public ResponseEntity<String> qnaReplyInsert(@RequestBody QnaReplyDTO qnadto) throws Exception{
		
		ResponseEntity<String> entity = null;
		pservice.qReplyInsert(qnadto);
		entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		return entity;
		
	}
	
	//카테고리별 상품리스트
	@RequestMapping(value = "/pdlist", method = RequestMethod.GET)
	public String productsPdlist(@RequestParam("subcategory") String subcategory, @RequestParam("od") int od, Model model) throws Exception {
		
		if(od==1) {	//신상품순
			model.addAttribute("plist", pservice.selectNewAllProduct(subcategory));
		}else if(od==2) {	//판매량순
			model.addAttribute("plist", pservice.selectsellAllProduct(subcategory));
		}else if(od==3) {	//낮은 가격순
			model.addAttribute("plist", pservice.selectCheapAllProduct(subcategory));
		}else if(od==4){	//높은 가격순
			model.addAttribute("plist", pservice.selectExpensiveAllProduct(subcategory));
		}else {	//서브카테고리별 상품리스트(기본)
			model.addAttribute("plist", pservice.selectAllProduct(subcategory));			
		}
		model.addAttribute("pCount", pservice.selectCountProduct(subcategory));
		model.addAttribute("subcategory", subcategory);
		model.addAttribute("od", 5);
		
		return "/products/pdlist";
	}
	
	@RequestMapping(value = "/pdlist", method = RequestMethod.POST)
	public String productsPdlistPost() {

		return "/products/pdlist";
	}
	
	//검색된 상품 정렬
	@RequestMapping(value = "/pdlistsearch", method = RequestMethod.GET)
	public String productsSearchPdlist(ProductDTO pdto,@RequestParam("ord") String ord, Model model) throws Exception {
		
		String keyword=pdto.getKeyword();
		
		if(ord.equals("d")) { //내림차순
			model.addAttribute("plist", pservice.selectKeyowrdOrder(pdto));
		}else if(ord.equals("a")) { //오름차순
			model.addAttribute("plist", pservice.selectKeyowrdOrderAsc(pdto));
		}
		
		model.addAttribute("keyword", keyword);
		
		return "/products/pdlistsearch";
	}
	
	//검색된 상품 목록
	@RequestMapping(value = "/pdlistsearch", method = RequestMethod.POST)
	public String productsSearchPdlistPost(@RequestParam("search") String search, Model model) throws Exception {
		
		model.addAttribute("plist", pservice.selectKeyowrd(search));
		model.addAttribute("pCount", pservice.selectKeyowrdCount(search));
		model.addAttribute("keyword", search);
		
		return "/products/pdlistsearch";
	}
	
	// 신상품 상품 목록
	@RequestMapping(value = "/newpdlist", method = RequestMethod.GET)
	public void newProductsPdlist(Model model) throws Exception {
		
		model.addAttribute("newlist", pservice.selectNewProduct());
		model.addAttribute("count", pservice.countNewProduct());
		
	}
	
	// 베스트 상품 목록
	@RequestMapping(value = "/bestpdlist", method = RequestMethod.GET)
	public void bestProductsPdlist(Model model) throws Exception {
		
		model.addAttribute("bestlist", pservice.selectBestProduct());
		model.addAttribute("count", pservice.countBestProduct());
		
	}
	
	// 알뜰 상품 목록
	@RequestMapping(value = "/cheappdlist", method = RequestMethod.GET)
	public void cheapProductsPdlist(Model model) throws Exception {
			
		model.addAttribute("cheaplist", pservice.selectCheapProduct());
		model.addAttribute("count", pservice.countCheapProduct());
			
	}
	
	//주문서GET
	@RequestMapping(value = "/pdpayment", method = RequestMethod.GET)
	public String productsPdpayment() {
		
		
		return "/products/pdpayment";
	}
	
	//주문서POST
	@RequestMapping(value = "/pdpayment", method = RequestMethod.POST)
	public String productsPdpaymentPOST(HttpSession session, @RequestParam("chkproduct") List<String> chkproduct, BucketDTO bdto, Model model) throws Exception {
		
		String userID=(String)session.getAttribute("userID");
		
		//아이디, chkbucket		
		String chkbucket="("+String.join(",",chkproduct)+")";
		
		
		bdto.setChkbucket(chkbucket);
		bdto.setUserID(userID);
		
		ArrayList<BucketDTO> blist = (ArrayList<BucketDTO>) pservice.selectChekBucket(bdto);
		
		//장바구니 체크 리스트
		model.addAttribute("ckblist", blist);
		
		//총 가격
		int totalprice=0;
		for (BucketDTO bucketDTO : blist) {
			totalprice+=bucketDTO.getPrice()*bucketDTO.getOrderCnt();
		}

		model.addAttribute("totalprice", totalprice);
		
		//장바구니 첫번째
		model.addAttribute("cbfdto", pservice.selectFirstBucket(bdto));
		
		//장바구니 개수
		model.addAttribute("bCount", pservice.countBucket(bdto));
		
		//주문자 정보 - 세션으로 아이디 수정
		model.addAttribute("mbdto", mbservice.idSelect(bdto.getUserID()));
		
		//기본 배송지
		model.addAttribute("ddto",myservice.deliSelect(bdto.getUserID()));
	
		
		return "/products/pdpayment";
	}
	
	//최종결제POST
	@RequestMapping(value = "/pay", method = RequestMethod.POST)
	public String productPay(@RequestParam("bkNum") List<String> bkNum, OdersDTO odto,BucketDTO bdto, 
			OrderDetailDTO oddto, Model model, HttpSession session ) throws Exception {
		
		String userID=(String)session.getAttribute("userID");
		
		//주문결제
		odto.setUserID(userID);//세션으로 수정
		
		pservice.insertOrder(odto);
			
		
		//주문상품		
		String chkbucket="("+String.join(",",bkNum)+")";
		bdto.setChkbucket(chkbucket); 		
		bdto.setUserID(userID);
		
		ArrayList<BucketDTO> blist = (ArrayList<BucketDTO>) pservice.selectOrderBucket(bdto);
		
		//주문상품 상세등록
		for (BucketDTO bkdto : blist) {
			//주문상품 상세등록
			oddto.setUserID(userID);
			oddto.setpCode(bkdto.getpCode());
			oddto.setCnt(bkdto.getOrderCnt());
		
			pservice.insertDetailOrder(oddto);
			
			//상품주문량 수정
			pservice.updateProductCount(bkdto);
		}
		
		//장바구니 삭제
		pservice.deleteOrderBucket(bdto);
		
		return "/marketkurly";
	}
	
}
