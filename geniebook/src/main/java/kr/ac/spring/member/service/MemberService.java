package kr.ac.spring.member.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.ac.spring.member.dao.MemberDao;
import kr.ac.spring.member.vo.AddrVO;
import kr.ac.spring.member.vo.MemberVO;

@Service
public class MemberService {
	
	@Autowired
	private MemberDao memberDao;
	
	public void addMember(MemberVO memberVO, AddrVO addrVO){
		memberDao.addMember(memberVO, addrVO);
	}

	public String overlapped(String id) {
		// TODO Auto-generated method stub
		return memberDao.overlapped(id);
	}

	public MemberVO selectUserInfo(String id) {
		// TODO Auto-generated method stub
		return memberDao.selectUserInfo(id);
	}
	
	public MemberVO selectUserNameInfo(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return memberDao.selectUserNameInfo(map);
	}
	
	public AddrVO selectUserInfo_Addr(String id) {
		// TODO Auto-generated method stub
		return memberDao.selectUserInfo_Addr(id);
	} 

	public void updateMember(MemberVO memberVO, AddrVO addrVO) {
		// TODO Auto-generated method stub
		memberDao.updateMember(memberVO, addrVO);
		
	}

	public void deleteMember(String id) {
		// TODO Auto-generated method stub
		memberDao.deleteMember(id);
	}

	public void updatePwdById(Map<String, Object> map) {
		// TODO Auto-generated method stub
		memberDao.updatePwdById(map);
	}

	public void addPoint(String id, int point) {
		// TODO Auto-generated method stub
		memberDao.addPoint(id, point);
		
	}

	public void addAcc_Price(String id, int i) {
		// TODO Auto-generated method stub
		memberDao.addAcc_Price(id,i);
		
	}

	


}
