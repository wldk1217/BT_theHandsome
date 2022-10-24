package com.thehandsome.service;

import java.util.List;

import com.thehandsome.domain.BoardCriteria;
import com.thehandsome.domain.ReplyVO;

public interface ReplyService {
	
	public int register(ReplyVO vo)throws Exception;
	
	public ReplyVO get(Long rno)throws Exception;
	
	public int modify(ReplyVO vo)throws Exception;
	
	public int remove(Long rno)throws Exception;
	
	public List<ReplyVO> getList(BoardCriteria cri, Long bno)throws Exception;
}
