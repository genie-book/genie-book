package kr.ac.spring.cart.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.ac.spring.cart.dao.CartItemDao;
import kr.ac.spring.cart.vo.CartItemVO;

@Service
public class CartItemService {

	@Autowired
	private CartItemDao cartItemDao;

	public List<CartItemVO> getCartItemsByCartId(int cartId) {
		// TODO Auto-generated method stub
		List<CartItemVO> cartItemList = cartItemDao.getCartItemsByCartId(cartId);
		return cartItemList;
	}

	public boolean isCartItemByBookNo(int cartId, int bookNo) {
		// TODO Auto-generated method stub
		return cartItemDao.isCartItemByBookNo(cartId, bookNo);
	}

	public void addCartItem(CartItemVO cartItem) {
		// TODO Auto-generated method stub
		cartItemDao.addCartItem(cartItem);
	}

	public void addCartItemQuantity(int bookNo, int cartId, int price, int quantity) {
		// TODO Auto-generated method stub
		cartItemDao.addCartItemQuantity(bookNo, cartId, price, quantity);
	}
	public void minusCartItemQuantity(int bookNo, int cartId, int price, int quantity) {
		// TODO Auto-generated method stub
		cartItemDao.minusCartItemQuantity(bookNo, cartId, price, quantity);
	}

	public void deleteCartItem(int cartId, int bookNo) {
		// TODO Auto-generated method stub
		cartItemDao.deleteCartItem(cartId,bookNo);
		
	}

	public CartItemVO getCartItem(int cartId, int bookNo) {
		// TODO Auto-generated method stub
		return cartItemDao.getCartItem(cartId, bookNo);
	}

	public void removeAll(int cartId) {
		// TODO Auto-generated method stub
		cartItemDao.removeAll(cartId);
	}
}
