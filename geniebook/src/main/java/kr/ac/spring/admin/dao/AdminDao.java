package kr.ac.spring.admin.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.ac.spring.member.vo.MemberVO;
import kr.ac.spring.product.vo.ProductVO;

@Repository
public class AdminDao {
	@Autowired
	private SqlSession sqlSession;

	public List<MemberVO> getMemberAllInfo() {
		List<MemberVO>  memberList= sqlSession.selectList("mapper.member.selectAllMemberList");
		return memberList;
	}
	
	public List<MemberVO> selectMemberInfo(String id) {
		List<MemberVO>  memberList = sqlSession.selectList("mapper.member.selectUserInfo",id);
		return memberList;
	}

	public int deleteProduct(int bookNo) {
		return sqlSession.delete("mapper.product.deleteProduct",bookNo);
	}

	public int addProduct(ProductVO productVO) {
		return sqlSession.delete("mapper.product.addProduct",productVO);
	}

	public int updateProduct(ProductVO productVO) {
		return sqlSession.update("mapper.product.updateProduct",productVO);
		
	}
}
