package com.thehandsome.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.thehandsome.domain.BoardCriteria;
import com.thehandsome.domain.BoardVO;
import com.thehandsome.mapper.BoardMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

/*****************************************************
 * @function : BoardServiceImpl
 * @author : 구영모
 * @Date : 2022.10.20
 * 게시판에 필요한 DB처리
 *****************************************************/
@Log4j
@Service
@AllArgsConstructor
public class BoardServiceImpl implements BoardService{
	
	@Autowired
	private BoardMapper mapper;
	//페이징 처리한 게시물 리스트를 가져오는 메소드
	@Override
	public List<BoardVO> getListWithPaging(BoardCriteria cri)throws Exception{
		log.info("게시판 페이징 처리 list 불러오기 시작"+cri);
		return mapper.getListWithPaging(cri);
	}
	//게시물 등록 메소드
	@Override
	public void insert(BoardVO board)throws Exception {
		log.info("insert 시작");
		mapper.insert(board);
	}
	//게시물 조회 메소드
	@Override
	public BoardVO read(long qid)throws Exception{
		log.info("read 시작");
		return mapper.read(qid);
	}
	//게시물 수정 메소드
	@Override
	public boolean update(BoardVO board)throws Exception{
		log.info("update 시작");
		return mapper.update(board) == true;
	}
	//게시물 삭제 메소드
	@Override
	public boolean delte(long qid)throws Exception{
		log.info("delete 시작");
		return mapper.delete(qid) == true;
	}
	//게시물의 총 개수를 가져오는 메소드
	@Override
	public int getTotal(BoardCriteria cri)throws Exception{
		log.info("행의 전체 수 가져오는 메소드 시작");
		return mapper.getTotalCount(cri);
	}
}
