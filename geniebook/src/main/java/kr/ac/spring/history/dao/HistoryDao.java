package kr.ac.spring.history.dao;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.ac.spring.history.vo.HistoryVO;

@Repository
public class HistoryDao {
	@Autowired
	private SqlSession sqlSession;

	public void addHistory(HistoryVO historyVO) {
		// TODO Auto-generated method stub
		sqlSession.insert("mapper.history.addHistory",historyVO);
		
	}

	public List<HistoryVO> getHistoryById(String id) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.history.getHistoryById",id);
	}

	public List<HistoryVO> getHistoryByIdByDate(String id, Date purchase_date) {
		// TODO Auto-generated method stub
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("purchase_date", purchase_date);
		return sqlSession.selectList("mapper.history.getHistoryByIdByDate",map);
	}

	public void deleteHistory(int cartId) {
		// TODO Auto-generated method stub
		sqlSession.delete("mapper.history.deleteHistory",cartId);
	}
}
