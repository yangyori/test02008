package com.market.ex;

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

import com.market.dto.DeliveryDTO;
import com.market.dto.FavoritDTO;
import com.market.dto.OdersDTO;
import com.market.dto.OrderDetailDTO;
import com.market.dto.PReviewDTO;
import com.market.dto.QnaDTO;
import com.market.service.IMemberService;
import com.market.service.IMykulryService;
import com.market.service.IProductsService;

@Controller
@RequestMapping("/mykurly/*")
public class MyKurlyController {

	@Autowired
	private IMemberService mservice;
	
	@Autowired
	private IMykulryService myservice;
	
	@Autowired
	private IProductsService pservice;

	//주문내역
	@RequestMapping(value = "/orderlist", method = RequestMethod.GET)
	public String MyKurlyOrderList(HttpSession session, Model model) throws Exception {
		
		String userID=(String)session.getAttribute("userID");
		
		model.addAttribute("olist", myservice.selectOrderAll(userID));
		
		
		return "/mykurly/orderlist";
	}

	//주문상세내역
	@RequestMapping(value = "/orderdetaillist", method = RequestMethod.GET)
	public String MyKurlyOrderDetailList(@RequestParam("orderNum") int orderNum, OrderDetailDTO oddto, Model model, HttpSession session) throws Exception {
		
		String userID=(String)session.getAttribute("userID");
		
		oddto.setOrderNum(orderNum);
		oddto.setUserID(userID);
		model.addAttribute("orderNum", orderNum);
		model.addAttribute("odlist", myservice.selectOrderDetail(oddto));
		
		return "/mykurly/orderdetaillist";
	}

	//배송지 리스트
	@RequestMapping(value = "/deliverylist", method = RequestMethod.GET)
	public String MyKurlyDeliveryList(HttpSession session, DeliveryDTO ddto, Model model) throws Exception {
		
		String userID=(String)session.getAttribute("userID");
		
		model.addAttribute("ddlist", myservice.selectAllDelivery(userID));
		
		return "/mykurly/deliverylist";
	}
	
	//배송지 추가 팝업
	@RequestMapping(value = "/deliveryPopup", method = RequestMethod.GET)
	public String MyKurlyDeliveryPopup() {

		return "/mykurly/deliveryPopup";
	}
	
	//ajax 배송지 추가	
	@RequestMapping(value ="/deliveryAdd", method = RequestMethod.POST)
	public ResponseEntity<String> MyKurlyDeliveryadd(@RequestBody DeliveryDTO ddto, HttpSession session) { //@RequestBody: json형태로 담아서 처리
		ResponseEntity<String> entity = null;
		try {
			
			String userID=(String)session.getAttribute("userID");
			ddto.setUserID(userID);
			ddto.setBasicAdd(0);
			
			System.out.println(ddto.toString());
			
			myservice.deliveryInsert(ddto);
			
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
			
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	//ajax 기본배송지 변경
	@RequestMapping(value ="/basicAddrUpdate", method = RequestMethod.PUT)
	public ResponseEntity<String> MyKurlyDeliveryUpdate(@RequestBody DeliveryDTO ddto, HttpSession session) { //@RequestBody: json형태로 담아서 처리
		ResponseEntity<String> entity = null;
		try {
			
			String userID=(String)session.getAttribute("userID");
			ddto.setUserID(userID);
			
			System.out.println(ddto.toString());
			//기존 기본배송지 해제
			myservice.updateBasicAddrZero(userID);
			
			//기본송지 설정
			myservice.updateBasicAddr(ddto);
			
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
			
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	//배송지 내용 변경
	@RequestMapping(value = "/deliveryUpdate", method = RequestMethod.GET)
	public String MyKurlyDeliveryInfoUpdateGet(@RequestParam("deliNum") int deliNum, Model model) throws Exception {
		
		model.addAttribute("ddto", myservice.selectNumDelivery(deliNum));
		
		
		return "/mykurly/deliveryUpdate";
	}
	
	//ajax 배송지 내용 변경
	@RequestMapping(value ="/deliveryUpdate", method = RequestMethod.PUT)
	public ResponseEntity<String> MyKurlyDeliveryInfoUpdate(@RequestBody DeliveryDTO ddto, HttpSession session) { //@RequestBody: json형태로 담아서 처리
		ResponseEntity<String> entity = null;
		try {
			
			String userID=(String)session.getAttribute("userID");
			ddto.setUserID(userID);
			
			System.out.println(ddto.toString());
			
			myservice.updateDeliverInfo(ddto);
			//기존 기본배송지 해제
			//myservice.updateBasicAddrZero(userID);
			
			//기본송지 설정
			//myservice.updateBasicAddr(ddto);
			
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
			
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	//ajax 배송지 정보 삭제
	@RequestMapping(value = "/deliveryInfoDel/{deliNum}", method = RequestMethod.DELETE)
	public ResponseEntity<String> deliveryInfoRemove(@PathVariable("deliNum") int deliNum) {
		
		ResponseEntity<String> entity = null;
		try {
			System.out.println(deliNum);
			myservice.deleteDeliverInfo(deliNum);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	/* 찜 목록 시작 */	
	@RequestMapping(value = "/favoritlist", method = RequestMethod.GET)
	public void MyKurlyFavoritList(HttpSession session, Model model) throws Exception{
		
		String userID=(String)session.getAttribute("userID");
		model.addAttribute("favoritlist", myservice.favoritlist(userID));
		model.addAttribute("count",  myservice.favcount());
	}
	
	@RequestMapping(value = "/favoritlist/{fNum}", method = RequestMethod.DELETE)
	public ResponseEntity<String> remove(@PathVariable("fNum") Integer fNum) {
	
		ResponseEntity<String> entity = null;
		try {
			myservice.deletefavoritlist(fNum);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	//ajax 찜 상품담기
	@RequestMapping(value ="/favoritlist", method = RequestMethod.POST)
	public ResponseEntity<String> register(@RequestBody FavoritDTO fdto) { //@RequestBody: json형태로 담아서 처리
		ResponseEntity<String> entity = null;
		try {
			myservice.insertfavoritlist(fdto);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
			
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	/* 찜 목록 종료 */

	//상품후기 등록가능 목록, 내가 작성한 상품후기
	@RequestMapping(value = "/pdreview", method = RequestMethod.GET)
	public String MyKurlyPdReview(HttpSession session,OrderDetailDTO oddto, OdersDTO odto, Model model) throws Exception {

		String userID=(String)session.getAttribute("userID");
		
		
		//주문번호
		model.addAttribute("olist", myservice.selectOrderAllPreview(userID));
		
		//주문상품목록
		model.addAttribute("odlist", myservice.selectOrderPreivew(userID));
		
		//작성한 상품후기
		model.addAttribute("prlist", myservice.selectCompletReviews(userID));
		
		
		return "/mykurly/pdreview";
	}

	//상품후기 등록 화면
	@RequestMapping(value = "/pdreviewwrite", method = RequestMethod.GET)
	public String MyKurlyPdReviewwrite(@RequestParam("pCode") int pCode, Model model) throws Exception {

		model.addAttribute("pdto", pservice.selectProduct(pCode)); 
		
		return "/mykurly/pdreviewwrite";
	}
	
	//상품후기 등록
	@RequestMapping(value = "/pdreviewwrite", method = RequestMethod.POST)
	public String MyKurlyPdReviewwritePOST(HttpSession session,PReviewDTO prdto, Model model) throws Exception {
		
		String userID=(String)session.getAttribute("userID");
		
		prdto.setUserID(userID);
	
		myservice.insertReview(prdto);
		
		return "redirect:/mykurly/pdreview";
	}
	
	//상품후기 수정 화면 GET
	@RequestMapping(value = "/pdreviewupdate", method = RequestMethod.GET)
	public String MyKurlyPdReviewUpdate(@RequestParam("rNum") int rNum, HttpSession session, PReviewDTO prdto, Model model) throws Exception {
		
		String userID=(String)session.getAttribute("userID");
		
		prdto.setrNum(rNum);
		prdto.setUserID(userID);
		
		model.addAttribute("prdto", myservice.selectOneReview(prdto));
		
		return "/mykurly/pdreviewupdate";
	}
	
	//상품후기 수정 POST
	@RequestMapping(value = "/pdreviewupdate", method = RequestMethod.POST)
	public String MyKurlyPdReviewUpdatePOST(PReviewDTO prdto, Model model) throws Exception {
		
		myservice.updateOneReview(prdto);
		
		
		return "redirect:/mykurly/pdreview";
	}
	
	//ajax 상품후기 삭제
	@RequestMapping(value = "/prdel/{rNum}", method = RequestMethod.DELETE)
	public ResponseEntity<String> reviewRemove(@PathVariable("rNum") Integer rNum) {
		
		ResponseEntity<String> entity = null;
		try {
			myservice.deleteReview(rNum);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	//상품문의 등록
	@RequestMapping(value = "/pdquewrite", method = RequestMethod.POST)
	public String pdquewrite(HttpSession session,QnaDTO qnadto, Model model) throws Exception {
		
		String userID=(String)session.getAttribute("userID");
		
		int pCode = qnadto.getpCode();
		qnadto.setUserID(userID);
		myservice.insertQnA(qnadto);
		
		return "redirect:/products/pdinfo?pCode="+pCode;
	}
	
	//상품문의 정보
	@RequestMapping(value = "/pdinquiry", method = RequestMethod.GET)
	public String MyKurlyPdInquiry(HttpSession session, Model model) throws Exception {
		String userID = (String)session.getAttribute("userID");
		model.addAttribute("qnadto", myservice.pQnAlist(userID));
		
		return "/mykurly/pdinquiry";
	}
	
	//상품문의 정보 수정
	@RequestMapping(value = "/updateqna", method = RequestMethod.PUT)
	public ResponseEntity<String> update(@RequestBody QnaDTO qnadto) throws Exception{
		System.out.println(qnadto.toString());
		ResponseEntity<String> entity = null;
		try {
			myservice.updateQnA(qnadto);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
		
	}
	
	//상품문의 정보 삭제
	@RequestMapping(value = "/pdinquiry/{qNum}", method = RequestMethod.DELETE)
	public ResponseEntity<String> remove(@PathVariable("qNum") int qNum) throws Exception{
		
		ResponseEntity<String> entity = null;
		try {
			myservice.deleteQnA(qNum);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
		
	}
}