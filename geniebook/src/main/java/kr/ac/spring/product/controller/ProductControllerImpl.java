package kr.ac.spring.product.controller;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.ac.spring.product.service.ProductService;
import kr.ac.spring.product.vo.ProductVO;

@Controller
public class ProductControllerImpl implements ProductController {
	@Autowired
	private ProductService productService;

	// 세션 이용시 추가
	// HttpSession session=request.getSession();
	// session.setAttribute("productVO", productVO);

	@Override
	@RequestMapping(value = "/productDetail", method = RequestMethod.GET)
	public ModelAndView productDetail(@RequestParam("bookNo") int bookNo, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String viewName = (String) request.getAttribute("viewName");
		ProductVO product = productService.bookDetail(bookNo);
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("product", product);
		return mav;
	}

	@RequestMapping(value = "/category/{categoryName}/{categoryNum}", method = RequestMethod.GET)
	public ModelAndView productByCategory(@PathVariable("categoryName") String categoryName, @PathVariable("categoryNum") String num, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String category = categoryName+num;
		System.out.println(category);
		List<ProductVO> productList = productService.listProductByCategory(category);
		ModelAndView mav = new ModelAndView("productByCategory");
		mav.addObject("productList", productList);
		return mav;
	}

	@Override
	@RequestMapping("/productAll")
	public ModelAndView productAll(HttpServletRequest request) throws Exception {
		System.out.println("productAll");
		
		String viewName = (String) request.getAttribute("viewName");
		List<ProductVO> productList = productService.listProductAll();
		
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("productList", productList);
		return mav;
	}
}
