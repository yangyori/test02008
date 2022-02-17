package com.market.ex;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.market.dto.MemberDTO;
import com.market.dto.NoticeDTO;
import com.market.dto.QReplyDTO;
import com.market.dto.QnaDTO;
import com.market.dto.QnaReplyDTO;
import com.market.dto.QuestionDTO;
import com.market.service.IManagerService;
import com.market.service.IMemberService;
import com.market.service.IMemberServiceLogin;
import com.market.service.IMykulryService;
import com.market.vo.PageMaker;


@Controller
@RequestMapping("/manager/*")  // 클래스 전체에서 사용할 공통 url maapping임. 그 아래 함수들은 세부적인 url 경로 
public class ManagerController {
	
	@Autowired
	IMemberServiceLogin memberService;
	
	@Autowired
	IMemberService mservice;
	
	@Autowired
	private IManagerService managerService;
		
	/* 공지사항 시작*/
	@RequestMapping(value = "/mnotice", method = RequestMethod.GET)
	public void noticeList(PageMaker pm, Model model) throws Exception {
		
		model.addAttribute("list",managerService.mnoticelistSearch(pm));
		pm.setTotalCount(managerService.mnoticeSearchCount(pm));
		
	}
	@RequestMapping(value = "/mnoticewrite", method = RequestMethod.GET)
	public String mnoticewriteGet() throws Exception {
		
		return "/manager/mnoticewrite";
	}
	
	//공지사항 작성
	@RequestMapping(value = "/mnoticewrite", method = RequestMethod.POST)
	public String mnoticewritePOST(NoticeDTO ndto,Model model) throws Exception {
		
		managerService.insertMNotice(ndto);
		
		return "redirect:/manager/mnotice";
	}
	
	
	//1:1문의 리스트
	@RequestMapping(value = "/moneinquiry", method = RequestMethod.GET)
	public void ManagerOneinquiry(PageMaker pm, MemberDTO mdto, Model model, HttpSession session) throws Exception {
		
		model.addAttribute("list",managerService.oneinquirylist(pm));
		pm.setTotalCount(managerService.oneinquirylistSearchCount(pm));
		model.addAttribute("count", managerService.count());
		model.addAttribute("qrdto", managerService.list());
		
	}
	
	//1:1문의 목록 삭제
	@RequestMapping(value = "/moneinquiry/{qNum}", method = RequestMethod.DELETE)
	public ResponseEntity<String> remove(@PathVariable("qNum") int qNum) throws Exception{
		
		ResponseEntity<String> entity = null;
		try {
			managerService.deleteOneInquiry(qNum);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
		
	}
	
	//1:1문의 답글 작성(해당 qNum)
	@RequestMapping(value = "/moneinquirywrite", method = RequestMethod.GET)
	public String moneinquirywrite(@RequestParam("qNum") int qNum, Model model) throws Exception {

		model.addAttribute("pdto", managerService.selectOneInquiry(qNum));
		
		return "/manager/moneinquirywrite";
	}
	
	//1:1문의 답글 등록(해당 qNum)
	@RequestMapping(value = "/moneinquirywrite", method = RequestMethod.POST)
	public String moneinquirywritePOST(QReplyDTO prdto, @RequestParam("qNum") int qNum, Model model) throws Exception {
		
		prdto.setReplyer("admin");
	
		managerService.insertQueReply(prdto);
		managerService.updateQueReplyStatus(qNum);
		
		return "redirect:/manager/moneinquiry";
	}
	
	//상품문의 답글 삭제
	@RequestMapping(value = "/moneinquirydelete/{rqNum}", method = RequestMethod.DELETE)
	public ResponseEntity<String> queReplyDelete(@PathVariable("rqNum") int rqNum) throws Exception{
		
		ResponseEntity<String> entity = null;
		try {
			managerService.deleteQueReply(rqNum);;
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
		
	}
	
	
	//상품문의 정보
	@RequestMapping(value = "/minquiry", method = RequestMethod.GET)
	public String MyKurlyPdInquiry(Model model) throws Exception {
		
		model.addAttribute("qnadto", managerService.pQnAlist());
		model.addAttribute("qnardto", managerService.QnAReplyList());
		
		return "/manager/minquiry";
	}
	
	//상품문의 정보 삭제
	@RequestMapping(value = "/minquiry/{qNum}", method = RequestMethod.DELETE)
	public ResponseEntity<String> delete(@PathVariable("qNum") int qNum) throws Exception{
		
		ResponseEntity<String> entity = null;
		try {
			managerService.deleteQnA(qNum);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
		
	}
	
	//상품문의 답글 작성(해당 qNum)
	@RequestMapping(value = "/minquirywrite", method = RequestMethod.GET)
	public String minquirywrite(@RequestParam("qNum") int qNum, Model model) throws Exception {

		model.addAttribute("pdto", managerService.selectQnA(qNum));
		
		return "/manager/minquirywrite";
	}
	
	//상품문의 답글 등록(해당 qNum)
	@RequestMapping(value = "/minquirywrite", method = RequestMethod.POST)
	public String minquirywritePOST(QnaReplyDTO prdto, @RequestParam("qNum") int qNum, Model model) throws Exception {
		
		prdto.setReplyer("admin");
	
		managerService.insertQnAReply(prdto);
		managerService.updateQnAReplyStatus(qNum);
		
		return "redirect:/manager/minquiry";
	}
	
	//상품문의 답글 삭제
	@RequestMapping(value = "/minquirydelete/{rqNum}", method = RequestMethod.DELETE)
	public ResponseEntity<String> qnaReplyDelete(@PathVariable("rqNum") int rqNum) throws Exception{
		
		ResponseEntity<String> entity = null;
		try {
			managerService.deleteQnAReply(rqNum);;
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
		
	}
	
}
