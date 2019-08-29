package kr.ac.spring.cart.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.ac.spring.cart.vo.CartItemVO;
import kr.ac.spring.member.vo.MemberVO;

@Repository
public class CartItemDao {
	@Autowired
	private SqlSession sqlSession;

	public List<CartItemVO> getCartItemsByCartId(int cartId) {
		// TODO Auto-generated method stub
		List<CartItemVO>  cartItemList = sqlSession.selectList("mapper.cartItem.getCartItemsByCartId",cartId);
		return cartItemList;
	}

	public boolean isCartItemByBookNo(int cartId, int bookNo) {
		// TODO Auto-generated method stub
		Map<String, Integer> map = new HashMap<>();
		map.put("cartId", cartId);
		map.put("bookNo", bookNo);
		System.out.println(cartId+" "+ bookNo);
		String result =  sqlSession.selectOne("mapper.cartItem.isCartItemByBookNo",map);
		System.out.println(result);
		
		return Boolean.parseBoolean(result);
	}

	public void addCartItem(CartItemVO cartItem) {
		// TODO Auto-generated method stub
		sqlSession.insert("mapper.cartItem.addCartItem",cartItem);
	}

	public void addCartItemQuantity(int bookNo, int cartId, int price, int quantity) {
		// TODO Auto-generated method stub
		Map<String, Integer> map = new HashMap<>();
		map.put("cartId", cartId);
		map.put("bookNo", bookNo);
		map.put("price", price);
		map.put("quantity", quantity);
		sqlSession.insert("mapper.cartItem.addCartItemQuantity", map);
		
	}
	public void minusCartItemQuantity(int bookNo, int cartId, int price, int quantity) {
		// TODO Auto-generated method stub
		Map<String, Integer> map = new HashMap<>();
		map.put("cartId", cartId);
		map.put("bookNo", bookNo);
		map.put("price", price);
		map.put("quantity", quantity);
		sqlSession.insert("mapper.cartItem.minusCartItemQuantity", map);
	}

	public void deleteCartItem(int cartId, int bookNo) {
		// TODO Auto-generated method stub
		Map<String, Integer> map = new HashMap<>();
		map.put("cartId", cartId);
		map.put("bookNo", bookNo);
		sqlSession.delete("mapper.cartItem.deleteCartItem",map);
		
	}

	public CartItemVO getCartItem(int cartId, int bookNo) {
		// TODO Auto-generated method stub
		Map<String, Integer> map = new HashMap<>();
		map.put("cartId", cartId);
		map.put("bookNo", bookNo);
		CartItemVO cartItem = sqlSession.selectOne("mapper.cartItem.getCartItem",map);
		return cartItem;
	}

	public void removeAll(int cartId) {
		// TODO Auto-generated method stub
		sqlSession.delete("mapper.cartItem.removeAll",cartId);
		
	}
}
