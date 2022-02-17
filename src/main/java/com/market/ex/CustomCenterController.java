package com.market.ex;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.market.vo.PageMaker;
import com.market.dto.QReplyDTO;
import com.market.dto.QuestionDTO;
import com.market.service.ICustomcenterService;

@Controller
@RequestMapping("/customcenter/*")
public class CustomCenterController {
	
	@Autowired
	private ICustomcenterService customservice;
	
	/* 공지사항 내용 시작*/
	@RequestMapping(value = "/noticecontent", method = RequestMethod.GET)
	public String CustomCenterNoticeContent() {
		
		
		return "/customcenter/noticecontent";
	}
	
	@RequestMapping(value = "/noticecontent2", method = RequestMethod.GET)
	public String selectNotice(@RequestParam("ntNum") int ntNum, Model model) throws Exception {
		
		model.addAttribute("ndto", customservice.selectNotice(ntNum));
	
		return "/customcenter/noticecontent2";
	}
	
	//공지사항 내용 삭제
	@RequestMapping(value = "/noticecontent2/{ntNum}", method = RequestMethod.DELETE)
	public ResponseEntity<String> remove(@PathVariable("ntNum") int ntNum) throws Exception{
		
		ResponseEntity<String> entity = null;
		try {
			customservice.deleteNotice(ntNum);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
		
	}
	/* 공지사항 내용 종료*/
	
	/* 공지사항 시작*/
	@RequestMapping(value = "/noticelist", method = RequestMethod.GET)
	public void noticeList(PageMaker pm, Model model) throws Exception {
		
		model.addAttribute("list",customservice.listSearchCriteria(pm));
		pm.setTotalCount(customservice.listSearchCount(pm));
		
	}
	/* 공지사항 종료*/
	
	/* 자주하는 질문 시작*/
	@RequestMapping(value = "/oftenqna", method = RequestMethod.GET)
	public String CustomCenterOftenQna() {
		
		
		return "/customcenter/oftenqna";
	}
	/* 자주하는 질문 종료*/
	
	/* 1:1문의 시작*/
	@RequestMapping(value = "/oneinquiry", method = RequestMethod.GET)
	public void oneInquiryList(PageMaker pm, Model model) throws Exception {
		
		model.addAttribute("list",customservice.oneinquirylistSearchCriteria(pm));
		pm.setTotalCount(customservice.oneinquirylistSearchCount(pm));
		model.addAttribute("count", customservice.count());
		model.addAttribute("qrdto", customservice.list());
		
	}
	
	/* 1:1문의 답글*/
	@RequestMapping(value = "/replies", method = RequestMethod.POST)
	public ResponseEntity<String> queReplyInsert(@RequestBody QReplyDTO qdto) throws Exception{
		
		ResponseEntity<String> entity = null;
		customservice.qReplyInsert(qdto);
		entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		return entity;
	}
		
	/* 1:1문의 종료*/
	
	/* 1:1문의 글쓰기 시작*/
	@RequestMapping(value = "/oneinquirywrite", method = RequestMethod.GET)
	public String OneInquiryWriteGet() {
		
		return "/customcenter/oneinquirywrite";
	}
	
	@RequestMapping(value = "/oneinquirywrite", method = RequestMethod.POST)
	public String OneinquirywritePost(QuestionDTO question, RedirectAttributes rttr)throws Exception {
		
		customservice.write(question);
		
		rttr.addFlashAttribute("msg","success");
		return "redirect:/customcenter/oneinquiry";
	}
	
	//1:1문의 정보 삭제
	@RequestMapping(value = "/oneinquiry/{qNum}", method = RequestMethod.DELETE)
	public ResponseEntity<String> deleteQ(@PathVariable("qNum") int qNum) throws Exception{
		
		ResponseEntity<String> entity = null;
		try {
			customservice.deleteQ(qNum);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
		
	}
	/* 1:1문의 글쓰기 종료*/
}