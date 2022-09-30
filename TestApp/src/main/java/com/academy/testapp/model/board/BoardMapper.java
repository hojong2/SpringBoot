package com.academy.testapp.model.board;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.academy.testapp.model.domain.Board;

//DAO가 이 인터페이스를 통해 xml의 쿼리를 접근할 수 있다
//주의!! 아래의 객체의 메서드명은 mybatis의 mapper의 id를 따라간다
@Mapper
public interface BoardMapper {
	public List selectAll();
	public Board select(int board_id);
	public int insert(Board board);
	public int update(Board board);
	public int delete(Board board);
}
