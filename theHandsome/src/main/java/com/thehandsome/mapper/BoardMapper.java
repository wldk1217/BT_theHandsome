package com.thehandsome.mapper;

import java.util.List;

import com.thehandsome.domain.BoardCriteria;
import com.thehandsome.domain.BoardVO;

/*****************************************************
 * @function : BoardMapper
 * @author : 구영모
 * @Date : 2022.10.20
 * 게시물의 삽입, 삭제, 수정, 조회를 위한 Mapper클래스
 *****************************************************/

public interface BoardMapper {
	//페이징 처리한 게시물 리스트를 가져오는 메소드
	public List<BoardVO> getListWithPaging(BoardCriteria cri);
	//게시물 등록 메소드
	public void insert(BoardVO board);
	//게시물 조회 메소드
	public BoardVO read(long qid);
	//게시물 수정 메소드
	public boolean update(BoardVO board);
	//게시물 삭제 메소드
	public boolean delete(long qid);
	//게시물의 총 개수를 가져오는 메소드
	public int getTotalCount(BoardCriteria cri);
}
