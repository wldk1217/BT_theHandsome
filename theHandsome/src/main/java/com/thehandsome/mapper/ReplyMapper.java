package com.thehandsome.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.thehandsome.domain.BoardCriteria;
import com.thehandsome.domain.ReplyVO;
/*****************************************************
 * @function : ReplyMapper
 * @author : 구영모
 * @Date : 2022.10.23
 * 댓글의 삽입, 삭제, 수정, 조회를 위한 Mapper클래스
 *****************************************************/
public interface ReplyMapper {
	//댓글의 리스트를 불러오는 메소드
	public List<ReplyVO>getListWithPage(
			@Param("cri")BoardCriteria cri,
			@Param("qid")Long qid
			);
	//댓글을 삽입해주는 메소드
	public int insert(ReplyVO reply);
	//댓글 하나를 조회하는 메소드
	public ReplyVO read(Long rno);
	//댓글을 삭제하는 메소드
	public int delete(Long rno);
	//댓글을 수정하는 메소드
	public int update(ReplyVO reply);
}

