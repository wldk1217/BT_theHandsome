package com.thehandsome.service;

import java.util.List;

import com.thehandsome.domain.BoardCriteria;
import com.thehandsome.domain.BoardVO;

/*****************************************************
 * @function : BoardService
 * @author : 구영모
 * @Date : 2022.10.21
 * 게시판에 필요한 DB처리
 *****************************************************/

public interface BoardService {	
	//페이징 처리한 게시물 리스트를 가져오는 메소드
	public List<BoardVO> getListWithPaging(BoardCriteria cri)throws Exception;
	//게시물 등록 메소드
	public void insert(BoardVO board)throws Exception;
	//게시물 조회 메소드
	public BoardVO read(long qid)throws Exception;
	//게시물 수정 메소드
	public boolean delte(long qid)throws Exception;
	//게시물 삭제 메소드
	public boolean update(BoardVO board)throws Exception;
	//게시물의 총 개수를 가져오는 메소드
	public int getTotal(BoardCriteria cri)throws Exception;
	
}
