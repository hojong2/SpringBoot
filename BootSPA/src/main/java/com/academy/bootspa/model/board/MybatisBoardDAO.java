package com.academy.bootspa.model.board;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.academy.bootspa.exception.BoardException;
import com.academy.bootspa.model.domain.Board;

@Repository
public class MybatisBoardDAO implements BoardDAO{

	@Autowired
	private MybatisBoardMapper mybatisBoardMapper;
	
	@Override
	public List selectAll() {
		List list = mybatisBoardMapper.selectAll();
		return list;
	}

	@Override
	public Board select(int board_id) {
		return mybatisBoardMapper.select(board_id);
	}

	@Override
	public void insert(Board board) throws BoardException{
		int result=mybatisBoardMapper.insert(board);
		if(result==0) {
			throw new BoardException("mybatis에 의한 등록 실패");
		}
	}

	@Override
	public void update(Board board) throws BoardException{
		int result=mybatisBoardMapper.update(board);
		if(result==0) {
			throw new BoardException("mybatis에 의한 수정 실패");
		}
	}

	@Override
	public void delete(Board board) throws BoardException{
		int result=mybatisBoardMapper.delete(board);
		if(result==0) {
			throw new BoardException("mybatis에 의한 삭제 실패");
		}
	}
	
}
