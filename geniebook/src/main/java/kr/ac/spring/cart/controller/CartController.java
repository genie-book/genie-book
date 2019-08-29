package kr.ac.spring.cart.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.ac.spring.cart.service.CartItemService;
import kr.ac.spring.cart.service.CartService;
import kr.ac.spring.cart.vo.CartItemVO;
import kr.ac.spring.cart.vo.CartVO;
import kr.ac.spring.history.vo.HistoryVO;
import kr.ac.spring.member.service.MemberService;
import kr.ac.spring.member.vo.AddrVO;
import kr.ac.spring.member.vo.MemberVO;
import kr.ac.spring.product.service.ProductServiceImpl;
import kr.ac.spring.product.vo.ProductVO;

@Controller
public class CartController {

	@Autowired
	private CartService cartService;
	@Autowired
	private ProductServiceImpl productService;
	@Autowired
	private MemberService memberService;

	@Autowired
	private CartItemService cartItemService;

	@RequestMapping("/cart")
	public String getCart(Model model) throws Exception {

		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String id = authentication.getName();
		int cartId = memberService.selectUserInfo(id).getCartId_mem();
		CartVO cart = cartService.getCartById(cartId);
		List<ProductVO> productList = new ArrayList<>();
		List<CartItemVO> cartItemList = cartItemService.getCartItemsByCartId(cart.getId());
		int grandTotal = 0;
		if (cartItemList.size() != 0) {
			for (int i = 0; i < cartItemList.size(); i++) {
				System.out.println(productService.bookDetail(cartItemList.get(i).getBookNo()).getBookName());
				productList.add(productService.bookDetail(cartItemList.get(i).getBookNo()));
				grandTotal += cartItemList.get(i).getTotalPrice();
			}
			cart.setGrandTotal(grandTotal);
		}
		cartService.updateGrandTotal(cart);
		model.addAttribute("grandTotal",grandTotal);
		model.addAttribute("product", productList);
		model.addAttribute("cartItemList", cartItemList);
		model.addAttribute("id", id);
		model.addAttribute("cartId", cartId);

		return "cart";
	}
	
	@RequestMapping(value = "/checkout/{id}/{cartId}" , method =  RequestMethod.GET)
	public String CheckOut(@PathVariable("cartId") int cartId, @PathVariable("id") String id, Model model) throws Exception {
		MemberVO memberVO = memberService.selectUserInfo(id);
		CartVO cart = cartService.getCartById(cartId);
		List<ProductVO> productList = new ArrayList<>();
		List<CartItemVO> cartItemList = cartItemService.getCartItemsByCartId(cartId);
		int grandTotal = 0;
		if (cartItemList.size() != 0) {
			for (int i = 0; i < cartItemList.size(); i++) {
				System.out.println(productService.bookDetail(cartItemList.get(i).getBookNo()).getBookName());
				productList.add(productService.bookDetail(cartItemList.get(i).getBookNo()));
				grandTotal += cartItemList.get(i).getTotalPrice();
			}
		}else {
			String message ="<script>alert('상품이 없습니다.');</script>";
			model.addAttribute("message", message);
			return "cart";
		}
		
		AddrVO addrVO = memberService.selectUserInfo_Addr(id);
		model.addAttribute("product", productList);
		model.addAttribute("grandTotal", grandTotal);
		model.addAttribute("cartItemList", cartItemList);
		model.addAttribute("memberVO", memberVO);
		model.addAttribute("addrVO", addrVO);
		model.addAttribute("cartId", cartId);
		return "checkout";
	}

	@RequestMapping(value = "/cartRemoveAll")
	public String cartRemoveAll(@RequestParam("cartId") int cartId, String id) {
		cartItemService.removeAll(cartId);
		return "redirect:cart";
	}
	
	
}
