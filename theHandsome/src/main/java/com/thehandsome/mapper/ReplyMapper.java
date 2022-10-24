package com.thehandsome.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.thehandsome.domain.BoardCriteria;
import com.thehandsome.domain.ReplyVO;

public interface ReplyMapper {
	
	public List<ReplyVO>getListWithPage(
			@Param("cri")BoardCriteria cri,
			@Param("qid")Long qid
			);
	
	public int insert(ReplyVO reply);
	
	public ReplyVO read(Long rno);
	
	public int delete(Long rno);
	
	public int update(ReplyVO reply);
}
