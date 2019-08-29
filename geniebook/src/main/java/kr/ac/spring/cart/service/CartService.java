package kr.ac.spring.cart.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.ac.spring.cart.dao.CartDao;
import kr.ac.spring.cart.vo.CartVO;

@Service
public class CartService {
	@Autowired
	private CartDao cartDao;
	
	public void addCart(int cartId_mem) {
		// TODO Auto-generated method stub
		cartDao.addCart(cartId_mem);
		
	}

	public CartVO getCartById(int cartId) {
		// TODO Auto-generated method stub
		CartVO cart = cartDao.getCartById(cartId);
		return cart;
	}

	public void updateGrandTotal(CartVO cart) {
		// TODO Auto-generated method stub
		cartDao.updateGrandTotal(cart);
		
	}

	public void deleteCart(int cartId_mem) {
		// TODO Auto-generated method stub
		cartDao.deleteCart(cartId_mem);
		
	}

}
