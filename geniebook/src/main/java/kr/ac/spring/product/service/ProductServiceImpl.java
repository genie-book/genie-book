package kr.ac.spring.product.service;


import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import kr.ac.spring.product.dao.ProductDAO;
import kr.ac.spring.product.vo.ProductVO;

@Service("ProductService")
@Transactional(propagation=Propagation.REQUIRED)
public class ProductServiceImpl implements ProductService {
	@Autowired
	private ProductDAO productDAO;
	
	@Override
	public List<ProductVO> listRecommendation() throws Exception {
		List<ProductVO> productList = productDAO.selectRecommendationList(); // ��õ �׸� ������
		return productList;
	}
	@Override
	public ProductVO bookDetail(int bookNo) throws Exception {
		ProductVO product = productDAO.selectBooksDetail(bookNo);
		return product;
	}

	@Override
	public List<ProductVO> listProductAll() throws Exception {
		List<ProductVO> productList = productDAO.selectProductListAll();
		return productList;
	}
	@Override
	public List<ProductVO> listProductByCategory(String category) {
		List<ProductVO> productList = productDAO.selectProductByCategory(category);
		return productList;
	}
	
}
