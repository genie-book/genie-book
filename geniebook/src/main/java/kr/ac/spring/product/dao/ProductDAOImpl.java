package kr.ac.spring.product.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import kr.ac.spring.product.vo.ProductVO;


@Repository("ProductDAO")
public class ProductDAOImpl implements ProductDAO {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<ProductVO> selectRecommendationList() throws DataAccessException {
		return sqlSession.selectList("mapper.product.selectBookListByRecommendation");
	}
	
	@Override
	public List<ProductVO> selectProductListAll() throws DataAccessException {
		return sqlSession.selectList("mapper.product.selectProductListAll");
	}

	@Override
	public ProductVO selectBooksDetail(int bookNo) throws DataAccessException {
		return sqlSession.selectOne("mapper.product.selectProductByBookNo",bookNo);
	}

	@Override
	public List<ProductVO> selectProductByCategory(String category) {
		return sqlSession.selectList("mapper.product.selectBookListByCategory", category);
	}

}
