package com.thehandsome.service;

import java.util.List;

import com.thehandsome.domain.BoardCriteria;
import com.thehandsome.domain.BoardVO;

public interface BoardService {
	
//	public List<BoardVO> getList()throws Exception;
	
	public List<BoardVO> getListWithPaging(BoardCriteria cri)throws Exception;
	
	public void insert(BoardVO board)throws Exception;
	
	public BoardVO read(long qid)throws Exception;
	
	public boolean delte(long qid)throws Exception;
	
	public boolean update(BoardVO board)throws Exception;
	
	public int getTotal(BoardCriteria cri)throws Exception;
	
}
