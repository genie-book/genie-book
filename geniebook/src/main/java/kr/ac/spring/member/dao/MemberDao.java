package kr.ac.spring.member.dao;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.ac.spring.member.vo.AddrVO;
import kr.ac.spring.member.vo.MemberVO;

@Repository
public class MemberDao {
	
	@Autowired
	private SqlSession sqlSession;

	public void addMember(MemberVO memberVO, AddrVO addrVO) {

		// TODO Auto-generated method stub
		sqlSession.insert("mapper.member.addMember", memberVO);
		sqlSession.insert("mapper.address.addAddress", addrVO);
	}

	public String overlapped(String id) {
		String result =  sqlSession.selectOne("mapper.member.selectOverlappedID",id);
		return result;
	}
	public MemberVO selectUserNameInfo(Map<String, Object> map) {
		// TODO Auto-generated method stub
		MemberVO memberVO = new MemberVO();
		memberVO = sqlSession.selectOne("mapper.member.selectUserNameInfo", map);
		
		return memberVO;
	}
	public MemberVO selectUserInfo(String id) {
		// TODO Auto-generated method stub
		MemberVO memberVO = new MemberVO();
		memberVO = sqlSession.selectOne("mapper.member.selectUserInfo", id);
		
		return memberVO;
	}
	public AddrVO selectUserInfo_Addr(String id) {
		// TODO Auto-generated method stub
		AddrVO addrVO = new AddrVO();
		addrVO = sqlSession.selectOne("mapper.address.selectUserInfo_Addr", id);
		
		return addrVO;
	}

	public void updateMember(MemberVO memberVO, AddrVO addrVO) {
		// TODO Auto-generated method stub
		System.out.println(memberVO.getId());
		System.out.println();
		System.out.println(memberVO.getEmail());
		sqlSession.insert("mapper.member.updateMember", memberVO);
		sqlSession.insert("mapper.address.updateAddress", addrVO);
		
	}

	public void deleteMember(String id) {
		// TODO Auto-generated method stub
		sqlSession.delete("mapper.member.deleteMember",id);
		sqlSession.delete("mapper.address.deleteAddress",id);
		
	}

	public void updatePwdById(Map<String, Object> map) {
		// TODO Auto-generated method stub
		sqlSession.insert("mapper.member.updatePwdById", map);
	}

	public void addPoint(String id, int point) {
		// TODO Auto-generated method stub
		Map<String,Object>map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("point", point);
		sqlSession.insert("mapper.member.addPoint",map);
	}

	public void addAcc_Price(String id, int acc_Price) {
		// TODO Auto-generated method stub
		Map<String,Object>map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("acc_Price", acc_Price);
		sqlSession.insert("mapper.member.addAcc_Price", map);
		
	}

	

	

}
