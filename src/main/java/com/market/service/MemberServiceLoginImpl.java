package com.market.service;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import com.market.dao.IMemberDAOLogin;
import com.market.dto.MemberDTO;
@Service
public class MemberServiceLoginImpl implements IMemberServiceLogin {
	
	@Inject
	IMemberDAOLogin memberDao;
	
	/*
	 * @Override public String loginCheck(MemberDTO dto, HttpSession session) {
	 * String userName = memberDao.loginCheck(dto); if(userName != null) {
	 * session.setAttribute("userID", dto.getUserID());
	 * session.setAttribute("userName", dto.getUserName()); } return userName; }
	 */

	@Override
	public void logout(HttpSession session) {
		session.invalidate();
	}
	
	
	@Override
	public int idChk(MemberDTO dto) throws Exception{
		int result = memberDao.idChk(dto);
		return result;
	}
	
	@Override
	public int idChk2(MemberDTO dto) throws Exception{
		int result =  memberDao.idChk2(dto);
		return result;
	}
	
	@Override
	public int pwChk(MemberDTO dto) throws Exception{
		int result = memberDao.pwChk(dto);
		return result;
	}
	
	@Override
	public int passwordCheck(MemberDTO dto) throws Exception{
		int result = memberDao.passwordCheck(dto);
		return result;
	}
	
	@Override
	public int IDSearch(MemberDTO dto) throws Exception{
		int result = memberDao.IDSearch(dto);
		return result;
	}
}
