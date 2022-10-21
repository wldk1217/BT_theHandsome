package com.thehandsome.mapper;

import java.util.List;

import com.thehandsome.domain.BoardCriteria;
import com.thehandsome.domain.BoardVO;

public interface BoardMapper {
	
//	public List<BoardVO> getList();
	
	public List<BoardVO> getListWithPaging(BoardCriteria cri);
	
	public void insert(BoardVO board);
	
	public BoardVO read(long qid);
	
	public boolean update(BoardVO board);
	
	public boolean delete(long qid);
	
	public int getTotalCount(BoardCriteria cri);
}
