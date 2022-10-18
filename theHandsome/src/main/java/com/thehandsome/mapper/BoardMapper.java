package com.thehandsome.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import com.thehandsome.domain.BoardVO;

public interface BoardMapper {
	
	public List<BoardVO> getList();
	
	public void insert(BoardVO board);
	
	public BoardVO read(long qid);
	
	public boolean update(BoardVO board);
	
	public boolean delete(long qid);
			
}
