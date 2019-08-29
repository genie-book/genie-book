package kr.ac.spring.history.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
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
import kr.ac.spring.history.service.HistoryService;
import kr.ac.spring.history.vo.HistoryVO;
import kr.ac.spring.member.service.MemberService;
import kr.ac.spring.member.vo.AddrVO;
import kr.ac.spring.member.vo.MemberVO;
import kr.ac.spring.product.service.ProductServiceImpl;
import kr.ac.spring.product.vo.ProductVO;

@Controller
public class HistoryController {
	@Autowired
	private HistoryService historyService;
	@Autowired
	private CartService cartService;
	@Autowired
	private ProductServiceImpl productService;
	@Autowired
	private MemberService memberService;

	@Autowired
	private CartItemService cartItemService;

	@RequestMapping(value = "historyDetail/{id}/{purchase_date}")
	public String historyDetail(@PathVariable("id") String id, @PathVariable("purchase_date") Date purchase_date,
			Model model) throws Exception {

		List<HistoryVO> history = historyService.getHistoryByIdByDate(id, purchase_date);
		List<ProductVO> product = new ArrayList<ProductVO>();
		if (history.size() != 0) {
			for (int i = 0; i < history.size(); i++) {
				product.add(productService.bookDetail(history.get(i).getBookNo()));
			}
		}
		model.addAttribute("history", history);
		model.addAttribute("productList", product);
		return "historyDetail";
	}

	@RequestMapping(value = "purchaseHistory/{id}", method = RequestMethod.GET)
	public String memberHistory(Model model, @PathVariable("id") String id) throws Exception {
		List<String> productName = new ArrayList<String>();
		List<HistoryVO> historyList = historyService.getHistoryById(id);
		if (historyList.size() != 0) {
			for (int i = 0; i < historyList.size(); i++) {
				productName.add(productService.bookDetail(historyList.get(i).getBookNo()).getBookName());
			}
		}
		model.addAttribute("historyList", historyList);
		model.addAttribute("productName", productName);
		return "memberHistory";
	}

	@RequestMapping(value = "/payment", method = RequestMethod.POST)
	public String payment(@ModelAttribute("memberVO") MemberVO member, @ModelAttribute("addrVO") AddrVO addr,
			HttpServletRequest request, @RequestParam("cartId") int cartId) throws Exception {
		CartVO cartVO = cartService.getCartById(cartId);
		int grandTotal = (int) cartVO.getGrandTotal();
		List<CartItemVO> cartItemList = cartItemService.getCartItemsByCartId(cartId);
		for (int i = 0; i < cartItemList.size(); i++) {
			ProductVO product = productService.bookDetail(cartItemList.get(i).getBookNo());
			HistoryVO history = new HistoryVO();
			history.setId(member.getId());
			history.setName(member.getName());
			history.setContent(request.getParameter("content"));
			history.setEmail(member.getEmail());
			history.setPhoneNum(member.getPhoneNum());
			history.setAddr_detail(addr.getAddr_detail());
			history.setAddr_num(addr.getAddr_num());
			history.setAddr_road(addr.getAddr_road());
			history.setBookNo(product.getBookNo());
			history.setPrice(product.getPrice());
			history.setCartId(cartId);
			history.setQuantity(cartItemList.get(i).getQuantity());
			history.setGrandTotal(grandTotal);

			historyService.addHistory(history);

		}

		memberService.addAcc_Price(member.getId(), (int) grandTotal);
		memberService.addPoint(member.getId(), (int) (grandTotal * 0.02));
		cartVO.setGrandTotal(0);
		cartService.updateGrandTotal(cartVO);
		cartItemService.removeAll(cartId);
		return "redirect:/";
	}

	@RequestMapping(value = "/historyDetail", method = RequestMethod.POST)
	public String historyDetail(Model model, HttpServletRequest request) throws Exception {
		System.out.println("asdsa");
		System.out.println("date" + request.getParameter("purchase_date"));
		System.out.println("id " + request.getParameter("id"));

		String id = request.getParameter("id");
		SimpleDateFormat dt = new SimpleDateFormat("E MMM dd HH:mm:ss z yyyy", Locale.ENGLISH);
		Date data = dt.parse(request.getParameter("purchase_date").toString());


		System.out.println("data: "+data);

		Date purchase_date = dt.parse(request.getParameter("purchase_date").toString());
		List<HistoryVO> history = historyService.getHistoryByIdByDate(id, purchase_date);
		List<ProductVO> productList = new ArrayList<>();
		System.out.println(history.size());

		if (history.size() != 0) {
			for (int i = 0; i < history.size(); i++) {
				productList.add(productService.bookDetail(history.get(i).getBookNo()));
				model.addAttribute("historyList", history);
				model.addAttribute("product", productList);
			}
			model.addAttribute("history", history.get(0));
		}

		return "historyDetail";
	}
}
