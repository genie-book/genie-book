package kr.ac.spring.history.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.ac.spring.history.dao.HistoryDao;
import kr.ac.spring.history.vo.HistoryVO;
import kr.ac.spring.product.vo.ProductVO;

@Service
public class HistoryService {
	
	@Autowired
	private HistoryDao historyDao;

	public void addHistory(HistoryVO history) {
		// TODO Auto-generated method stub
		historyDao.addHistory(history);
		
	}

	public List<HistoryVO> getHistoryById(String id) {
		// TODO Auto-generated method stub
		List<HistoryVO> historyList = historyDao.getHistoryById(id);
		return historyList;
	}

	public List<HistoryVO> getHistoryByIdByDate(String id, Date purchase_date) {
		// TODO Auto-generated method stub
		List<HistoryVO> historyList = historyDao.getHistoryByIdByDate(id, purchase_date);
		return historyList;
	}

	public void deleteHistory(int cartId_mem) {
		// TODO Auto-generated method stub
		historyDao.deleteHistory(cartId_mem);
		
	}
}
