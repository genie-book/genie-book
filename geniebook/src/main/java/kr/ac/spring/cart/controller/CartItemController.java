package kr.ac.spring.cart.controller;

import java.util.HashMap;
import java.util.Map;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.jsonFormatVisitors.JsonObjectFormatVisitor;

import kr.ac.spring.cart.service.CartItemService;
import kr.ac.spring.cart.service.CartService;
import kr.ac.spring.cart.vo.CartItemVO;
import kr.ac.spring.cart.vo.CartVO;
import kr.ac.spring.member.service.MemberService;
import kr.ac.spring.product.service.ProductServiceImpl;
import kr.ac.spring.product.vo.ProductVO;

@Controller
@RequestMapping("/api/cart")
public class CartItemController {

	@Autowired
	private CartService cartService;
	@Autowired
	private ProductServiceImpl productService;
	@Autowired
	private MemberService memberService;

	@Autowired
	private CartItemService cartItemService;

	@RequestMapping(value = "/add/{bookNo}/{quantity}", method = RequestMethod.GET)
	public String addCartItem(Model model, @PathVariable("bookNo") int bookNo, @PathVariable("quantity") int quantity)
			throws Exception {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String id = authentication.getName();
		ProductVO productVO = productService.bookDetail(bookNo);
		int cartId = memberService.selectUserInfo(id).getCartId_mem();
		CartItemVO cartItem = new CartItemVO();
		if (!cartItemService.isCartItemByBookNo(cartId, bookNo)) {

			cartItem.setCartId(cartId);
			cartItem.setBookNo(bookNo);
			cartItem.setQuantity(quantity);
			cartItem.setTotalPrice(quantity * productVO.getPrice());
			cartItemService.addCartItem(cartItem);
			return "redirect:/cart";
		} else {
			int price = productVO.getPrice();
			cartItemService.addCartItemQuantity(bookNo, cartId, price, quantity);
			return "redirect:/cart";
		}
	}

	@RequestMapping(value = "/delete/{cartId}/{bookNo}")
	public ResponseEntity deleteCartItem(@PathVariable("cartId") int cartId, @PathVariable("bookNo") int bookNo) {
		cartItemService.deleteCartItem(cartId, bookNo);
		ResponseEntity resEntity = null;
		resEntity = new ResponseEntity(HttpStatus.OK);
		return resEntity;

	}

	@RequestMapping(value = "/plus/{cartId}/{bookNo}", method = RequestMethod.POST)
	public @ResponseBody JSONObject plus(@PathVariable("cartId") int cartId, @PathVariable("bookNo") int bookNo)
			throws Exception {

		System.out.println(cartId + "   " + bookNo);
		int price = productService.bookDetail(bookNo).getPrice();
		int quantity = cartItemService.getCartItem(cartId, bookNo).getQuantity();
		cartItemService.addCartItemQuantity(bookNo, cartId, price, 1);
		CartItemVO cartItem = cartItemService.getCartItem(cartId, bookNo);

		JSONObject json = new JSONObject();
		json.put("price", productService.bookDetail(cartItem.getBookNo()).getPrice());
		json.put("quantity", cartItem.getQuantity());
		json.put("totalPrice", cartItem.getTotalPrice());

		return json;
	}

	@RequestMapping(value = "/minus/{cartId}/{bookNo}", method = RequestMethod.POST)
	public @ResponseBody JSONObject minus(@PathVariable("cartId") int cartId, @PathVariable("bookNo") int bookNo)
			throws Exception {
		String message = "";
		JSONObject json = new JSONObject();
		System.out.println(cartId + "   " + bookNo);
		int price = productService.bookDetail(bookNo).getPrice();
		int quantity = cartItemService.getCartItem(cartId, bookNo).getQuantity();
		if (quantity == 1) {
			message = "false";
			json.put("message", message);
			return json;
		} else {
			cartItemService.minusCartItemQuantity(bookNo, cartId, price, 1);
			CartItemVO cartItem = cartItemService.getCartItem(cartId, bookNo);

			message = "true";
			json.put("message", message);
			json.put("price", productService.bookDetail(cartItem.getBookNo()).getPrice());
			json.put("quantity", cartItem.getQuantity());
			json.put("totalPrice", cartItem.getTotalPrice());

			return json;
		}
	}
}
