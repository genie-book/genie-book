package kr.ac.spring.admin.service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.ac.spring.admin.dao.AdminDao;
import kr.ac.spring.member.vo.MemberVO;
import kr.ac.spring.product.vo.ProductVO;

@Service
public class AdminService {

	@Autowired
	AdminDao adminDao;
	
	public List<MemberVO> getMemberAllInfo() {
		List<MemberVO> memberList = adminDao.getMemberAllInfo();
		return memberList;
	}

	public List<MemberVO> selectMemberInfo(String id) {
		List<MemberVO> memberList = adminDao.selectMemberInfo(id);
		return memberList;
	}
	
	public int deleteProduct(int bookNo) {
		return adminDao.deleteProduct(bookNo);
	}

	public int addProduct(ProductVO productVO) {
		return adminDao.addProduct(productVO);
	}

	public int updateProduct(ProductVO productVO) {
		return adminDao.updateProduct(productVO);
	}
	
}
