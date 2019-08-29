package kr.ac.spring.board.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.ac.spring.board.dao.BoardDAO;
import kr.ac.spring.board.vo.BoardVO;
import kr.ac.spring.board.vo.Pagination;

@Service("boardService")
public class BoardService {
	@Autowired
	BoardDAO boardDAO;
	
	public List<BoardVO> listBoards(Pagination pagination) throws Exception{
		List<BoardVO> boardsList =  boardDAO.selectAllBoardList(pagination);
        return boardsList;
	}

	public int addBoard(BoardVO boardVO) throws Exception{
		return boardDAO.addBoard(boardVO);
	}

	public int updateBoard(BoardVO boardVO) throws Exception {
		return boardDAO.updateBoard(boardVO);
	}

	public BoardVO viewBoard(int boardId) throws Exception{
		return boardDAO.viewBoard(boardId);
	}

	public int deleteBoard(Map<String, Object> parameters) throws Exception{
		return boardDAO.deleteBoard(parameters);
	}
	
	public int getBoardListCnt() throws Exception{
		return boardDAO.getBoardListCnt();
	}
	
	public void increaseViewCnt(int boardId, HttpSession session) throws Exception{
		long update_time = 0;
		// 세션에 저장된 조회시간 검색
		//최초로 조회할 경우 세션에 저장된 값이 없기 때문에 if문은 실행 되지 않는다.
		if(session.getAttribute("update_time_" + boardId) != null)
			update_time = (long)session.getAttribute("update_time_" + boardId);
		//시스템의 현재 시간을 current_time에 저장 
		long current_time = System.currentTimeMillis();
		//일정 시간이 경과 후 조회 수 증가 처리 24*60*60*1000 (24시간)
		//시스템 현재시간 - 열람 시간 > 일정 시간 (조회수 증가가 가능하도록 지정한 시간)
		if(current_time - update_time > 5 * 1000) {
			boardDAO.increaseViewCnt(boardId);
			//세션에 시간을 저장
			session.setAttribute("update_time_"+boardId, current_time);
		}
	}

	public int replyBoard(BoardVO boardVO) {
		return boardDAO.replyBoard(boardVO);
	}

	public int getBoardListCntById(String id) {
		// TODO Auto-generated method stub
		return boardDAO.getBoardListCntById(id);
	}

	public List<BoardVO> listBoardById(Pagination pagination, String id) {
		// TODO Auto-generated method stub
		List<BoardVO> boardsList =  boardDAO.selectAllBoardListById(pagination, id);
        return boardsList;
	}
}
