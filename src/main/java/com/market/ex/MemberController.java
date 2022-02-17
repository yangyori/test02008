package com.market.ex;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.market.dto.DeliveryDTO;
import com.market.dto.MemberDTO;
import com.market.service.IMemberService;
import com.market.service.IMemberServiceLogin;
import com.market.service.IMykulryService;


@Controller
@RequestMapping("/member/*")  // 클래스 전체에서 사용할 공통 url maapping임. 그 아래 함수들은 세부적인 url 경로 
public class MemberController {
	
	@Autowired
	IMemberServiceLogin memberService;
	
	@Autowired
	IMykulryService	mservice;
	
	@Autowired
	IMemberService memService;
	
	@Autowired
	private IMemberService service;

	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public String memberJoin() {
		return "/member/join";
	}
	
	@RequestMapping(value = "/userUpdate", method = RequestMethod.GET)
	public String userUpdate(MemberDTO mdto, Model model, HttpSession session) throws Exception {
		
		String userID = (String)session.getAttribute("userID");
		
		model.addAttribute("mdto", memService.selectAllUser(userID));
		
		
		return "/member/userUpdate";
	}
	
	
	@RequestMapping(value = "/userUpdate", method = RequestMethod.POST)
	public String userUpdateDB(MemberDTO dto, Model model, HttpSession session) throws Exception{
		System.out.println(dto.toString());
		service.userUpdate(dto);
		model.addAttribute("message", "updateSuccess");
		return "/marketkurly";
	}
	
	@RequestMapping(value = "/login")
	public String login() {
		return "/member/login";
	}
		
	@RequestMapping(value ="/login", method = RequestMethod.POST)
	public String login_check(MemberDTO dto, HttpSession session, HttpServletRequest request, Model model) throws Exception {
		
		dto=memService.SelectLogin(dto);
		
		if(dto==null) {
			
			model.addAttribute("message", "error");
			
			return "/member/login";
		}else {
			session=request.getSession();		
			session.setAttribute("userID", dto.getUserID());
			session.setAttribute("userName", dto.getUserName());
			
			return "/marketkurly";
		}
		
	}
	
	@RequestMapping("/member/logout")
	public String logout(HttpSession session) {
		session.invalidate();  // 세션초기화 
		return "/marketkurly";
	}
	
	// 아이디 찾기
	@RequestMapping(value = "/IDSearch", method = RequestMethod.GET)
	public String IDSearch() {
		return "/member/IDSearch";
	}
	

	@RequestMapping(value = "/IDSearch", method = RequestMethod.POST)
	public ModelAndView IDSearchDB(MemberDTO dto, Model model) throws Exception{
		ModelAndView mav = new ModelAndView();
		int result = memberService.IDSearch(dto);
		System.out.println(result);
		if(result == 1) {
			mav.setViewName("/member/IDSearch");
			mav.addObject("dto", service.IDSearch2(dto));
			System.out.println(dto.getUserID());
		} else {
			mav.setViewName("/member/IDSearch");
			mav.addObject("message", "error");
		}
		return mav;
	}
	
	
	// 비밀번호 찾기
	@RequestMapping(value = "/passwordSearch", method = RequestMethod.GET)
	public String passwordSearch() {
		return "/member/passwordSearch";
	}
	
	
	@RequestMapping(value = "/passwordSearch", method = RequestMethod.POST)
	public ModelAndView passwordSearchDB(MemberDTO dto, Model model) throws Exception {
		ModelAndView mav = new ModelAndView();
		int result = memberService.idChk2(dto);
		System.out.println(result);
		if (result == 1) {
			mav.setViewName("/member/passwordSearch");
			mav.addObject("dto", service.SearchPassword(dto));
		} else {
			mav.setViewName("/member/passwordSearch");
			mav.addObject("message", "error");
		}
		return mav;
	}
	
	@ResponseBody
	@RequestMapping(value = "/reCheck", method = RequestMethod.POST)
	public int passwordCheck(MemberDTO dto, Model model) throws Exception{
		System.out.println(dto.getUserID());
		System.out.println(dto.getPassword1());
		int result = memberService.passwordCheck(dto);
		System.out.println("count : " + result);
		return result;
	}
	
	@RequestMapping(value = "/personalInfo", method = RequestMethod.GET)
	public String reCheck() {
		return "/member/personalInfo";
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/idChk", method = RequestMethod.POST)
	public int idChk(MemberDTO dto) throws Exception{
		int result = memberService.idChk(dto);
		return result;
	}
	

	@RequestMapping(value = "/userDelete", method = RequestMethod.GET)
	public String userDelete() {
		return "/member/userDelete";
	}
	
	@RequestMapping(value = "/userDelete", method = RequestMethod.POST)
	public String delete(MemberDTO dto, HttpSession session) throws Exception{
		service.delete(dto);
		session.invalidate();
		return "/member/login";
	}
	
	
	@RequestMapping(value = "/join", method = RequestMethod.POST)
	public String memberJoinDB(MemberDTO dto,Model model, DeliveryDTO ddto, HttpSession session) throws Exception {
		service.create(dto);
	    ddto.setUserID(dto.getUserID());
	    ddto.setAddr1(dto.getAddr1());
	    ddto.setAddr2(dto.getAddr2());
	    ddto.setRecipient(dto.getUserName());
	    ddto.setPhoneNum(dto.getPhone());
	    ddto.setBasicAdd(1);
	    mservice.deliveryInsert(ddto);
	    model.addAttribute("message", "Joinsuccess");
	    session.setAttribute("userID", dto.getUserID());
	    session.setAttribute("userName", dto.getUserName());
	    return "/marketkurly";
	}
	
}
