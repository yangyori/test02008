package com.market.dao;

import com.market.dto.MemberDTO;

public interface IMemberDAOLogin {
	public String loginCheck(MemberDTO dto);
	
	public int idChk(MemberDTO dto) throws Exception;
	public int idChk2(MemberDTO dto) throws Exception;
	public int pwChk(MemberDTO dto) throws Exception;
	public int IDSearch(MemberDTO dto) throws Exception;
	public int passwordCheck(MemberDTO dto) throws Exception;
}
