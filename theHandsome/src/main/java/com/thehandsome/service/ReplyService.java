package com.thehandsome.service;

import java.util.List;

import com.thehandsome.domain.BoardCriteria;
import com.thehandsome.domain.ReplyVO;

/*****************************************************
 * @function : ReplyService
 * @author : 구영모
 * @Date : 2022.10.21
 * 댓글에 필요한 DB처리
 *****************************************************/
public interface ReplyService {
	//댓글을 삽입해주는 메소드
	public int register(ReplyVO vo)throws Exception;
	//댓글 하나를 조회하는 메소드
	public ReplyVO get(Long rno)throws Exception;
	//댓글을 수정하는 메소드
	public int modify(ReplyVO vo)throws Exception;
	//댓글을 삭제하는 메소드
	public int remove(Long rno)throws Exception;
	//댓글의 리스트를 불러오는 메소드
	public List<ReplyVO> getList(BoardCriteria cri, Long bno)throws Exception;
}
