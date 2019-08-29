package kr.ac.spring.board.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import kr.ac.spring.board.vo.BoardVO;
import kr.ac.spring.board.vo.Pagination;

@Repository("boardDAO")
public class BoardDAO {
	@Autowired
	private SqlSession sqlSession;

	public List<BoardVO> selectAllBoardList(Pagination pagination) throws DataAccessException {
		List<BoardVO> BoardsList =  sqlSession.selectList("mapper.board.selectAllBoardList",pagination);
		return BoardsList;
	}

	public int addBoard(BoardVO boardVO) throws DataAccessException{
		return sqlSession.insert("mapper.board.addBoard",boardVO);
	}

	public int updateBoard(BoardVO boardVO) throws DataAccessException{
		return sqlSession.update("mapper.board.updateBoard",boardVO);
	}
	
	public BoardVO viewBoard(int boardId) throws DataAccessException{
		return sqlSession.selectOne("mapper.board.selectByBoardId",boardId);
	}

	public int deleteBoard(Map<String, Object> parameters) throws DataAccessException{
		return sqlSession.delete("mapper.board.deleteBoard",parameters);
	}

	public void increaseViewCnt(int boardId) throws DataAccessException{
		sqlSession.update("mapper.board.increaseViewCnt",boardId);
	}

	public int replyBoard(BoardVO boardVO) throws DataAccessException{
		return sqlSession.insert("mapper.board.replyBoard",boardVO);
	}
	
	public int getBoardListCnt() throws DataAccessException{
		return sqlSession.selectOne("mapper.board.getBoardListCnt");
	}

	public int getBoardListCntById(String id) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("mapper.board.getBoardListCntById",id);
	}

	public List<BoardVO> selectAllBoardListById(Pagination pagination, String id) throws DataAccessException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("pagination", pagination);
		map.put("id", id);
		
		List<BoardVO> BoardsList =  sqlSession.selectList("mapper.board.selectAllBoardListById",map);
		return BoardsList;
	}
}
