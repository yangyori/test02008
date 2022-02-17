package com.market.dao;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.market.dto.MemberDTO;


@Repository
public class IMemberDAOLoginImpl implements IMemberDAOLogin {

	@Inject
	SqlSession sqlSession;
	
	@Override
	public String loginCheck(MemberDTO dto) {
		return sqlSession.selectOne("login_Check", dto);
	}
	
	
	@Override
	public int idChk(MemberDTO dto) throws Exception{
		int result = sqlSession.selectOne("idChk", dto);
		return result;
	}
	
	@Override
	public int idChk2(MemberDTO dto)throws Exception{
		int result = sqlSession.selectOne("idChk2", dto);
		return result;
	}
	
	@Override
	public int pwChk(MemberDTO dto) throws Exception{
		int result = sqlSession.selectOne("pwChk", dto);
		return result;
	}
	
	@Override
	public int IDSearch(MemberDTO dto) throws Exception{
		int result = sqlSession.selectOne("IDSearch", dto);
		return result;
	}
	
	
	@Override
	public int passwordCheck(MemberDTO dto) throws Exception{
	    int result = sqlSession.selectOne("passwordCheck", dto);
		return result;
	}
	
}
