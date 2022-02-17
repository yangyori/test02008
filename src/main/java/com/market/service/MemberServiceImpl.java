package com.market.service;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.market.dao.IMemberDAO;
import com.market.dto.MemberDTO;

@Service
public class MemberServiceImpl implements IMemberService {
	
	@Autowired
	private SqlSession sqlSession;  // mybatis 호출
	
	
	@Override
	public void create(MemberDTO dto) throws Exception {
		IMemberDAO dao = sqlSession.getMapper(IMemberDAO.class);
		dao.create(dto);
	}
	
	@Override
	public void delete(MemberDTO dto) throws Exception{
		IMemberDAO dao = sqlSession.getMapper(IMemberDAO.class);
		dao.delete(dto);
	}
	
	@Override
	public ArrayList<MemberDTO> SearchPassword(MemberDTO dto) throws Exception{
		IMemberDAO dao = sqlSession.getMapper(IMemberDAO.class);
		return dao.SearchPassword(dto);
	}
	
	@Override
	public ArrayList<MemberDTO> IDSearch2(MemberDTO dto) throws Exception{
		IMemberDAO dao = sqlSession.getMapper(IMemberDAO.class);
		return dao.IDSearch2(dto);
	}
	
	@Override
	public void userUpdate(MemberDTO dto) throws Exception{
		IMemberDAO dao = sqlSession.getMapper(IMemberDAO.class);
		dao.userUpdate(dto);
	}

	@Override
	public MemberDTO idSelect(String userID) throws Exception {
		IMemberDAO dao = sqlSession.getMapper(IMemberDAO.class);
		return dao.idSelect(userID);
	}

	//로그인
	@Override
	public MemberDTO SelectLogin(MemberDTO dto) throws Exception {
		IMemberDAO dao = sqlSession.getMapper(IMemberDAO.class);
		return dao.SelectLogin(dto);
	}
	
	//개인정보
	@Override
	public MemberDTO selectAllUser(String userID) throws Exception {
		IMemberDAO dao = sqlSession.getMapper(IMemberDAO.class);
		return dao.selectAllUser(userID);
	}
	

}

