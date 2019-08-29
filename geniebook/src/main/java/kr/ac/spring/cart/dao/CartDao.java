package kr.ac.spring.cart.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.ac.spring.cart.vo.CartVO;

@Repository
public class CartDao {

	@Autowired
	private SqlSession sqlSession;
	
	public void addCart(int cartId_mem) {
		// TODO Auto-generated method stub
		sqlSession.insert("mapper.cart.addCart", cartId_mem);
	}

	public CartVO getCartById(int cartId) {
		// TODO Auto-generated method stub
		CartVO cart = sqlSession.selectOne("mapper.cart.getCartById",cartId);
		return cart;
	}

	public void updateGrandTotal(CartVO cartVO) {
		// TODO Auto-generated method stub
		sqlSession.insert("mapper.cart.updateGrandTotal", cartVO);
		
	}

	public void deleteCart(int id) {
		// TODO Auto-generated method stub
		sqlSession.delete("mapper.cart.deleteCart",id);
		
	}

}
