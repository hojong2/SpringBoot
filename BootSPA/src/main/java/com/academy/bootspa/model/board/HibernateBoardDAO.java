package com.academy.bootspa.model.board;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.academy.bootspa.exception.BoardException;
import com.academy.bootspa.model.domain.Board;

@Repository
public class HibernateBoardDAO implements BoardDAO{

	@Autowired
	private HibernateBoardRepository boardRepository;
	
	@Override
	public List selectAll() {
		// TODO Auto-generated method stub
		return boardRepository.findAll();
	}

	@Override
	public Board select(int board_id) {
		// TODO Auto-generated method stub
		return boardRepository.findById(board_id).get();
	}

	@Override
	public void insert(Board board) throws BoardException{
		// TODO Auto-generated method stub
		Board result=boardRepository.save(board);
		System.out.println(result);
		if(result==null) {
			throw new BoardException("하이버네이트로 등록 실패");
		}
	}

	@Override
	public void update(Board board) {
		// TODO Auto-generated method stub
		Board result=boardRepository.save(board);
		if(result==null) {
			throw new BoardException("하이버네이트로 수정 실패");
		}
	}

	@Override
	public void delete(Board board) throws BoardException{
		// TODO Auto-generated method stub
		try {
			boardRepository.delete(board);
		} catch(Exception e) {
			e.printStackTrace();
			throw new BoardException("하이버네이트로 삭제 실패", e);
		}
	}

}
