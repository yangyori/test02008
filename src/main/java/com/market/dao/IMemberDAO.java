package com.market.dao;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import com.market.dto.MemberDTO;

public interface IMemberDAO {
	
	//회원가입
	public void create(MemberDTO dto) throws Exception;
	
	//회원탈퇴	
	public void delete(MemberDTO dto) throws Exception;
	
	//개인정보
	public MemberDTO selectAllUser(String userID) throws Exception;
	
	//개인정보 수정
	public void userUpdate(MemberDTO dto) throws Exception;
	
	//비밀번호 찾기
	public ArrayList<MemberDTO> SearchPassword(MemberDTO dto) throws Exception;    
	
	//아이디 찾기
	public ArrayList<MemberDTO> IDSearch2(MemberDTO dto) throws Exception;
	
	//개인정보
	public MemberDTO idSelect(String userID) throws Exception;
	
	//로그인
	public MemberDTO SelectLogin(MemberDTO dto) throws Exception;
}
