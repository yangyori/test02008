package com.market.service;

import javax.servlet.http.HttpSession;

import com.market.dto.MemberDTO;

public interface IMemberServiceLogin {
	//public String loginCheck(MemberDTO dto, HttpSession session);
	public void logout(HttpSession session);
	public int idChk(MemberDTO dto) throws Exception;
	public int idChk2(MemberDTO dto) throws Exception;
	public int pwChk(MemberDTO dto) throws Exception;
	public int passwordCheck(MemberDTO dto) throws Exception;
	public int IDSearch(MemberDTO dto) throws Exception;
}
