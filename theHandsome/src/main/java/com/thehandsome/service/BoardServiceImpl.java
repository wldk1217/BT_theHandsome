package com.thehandsome.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.thehandsome.domain.BoardVO;
import com.thehandsome.mapper.BoardMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class BoardServiceImpl implements BoardService{
	
	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;
	
	@Override
	public List<BoardVO> getList()throws Exception{
		log.info("게시판 list 불러오기 시작");
		return mapper.getList();
	}
	@Override
	public void insert(BoardVO board)throws Exception {
		log.info("insert 시작");
		mapper.insert(board);
	}
	@Override
	public BoardVO read(long qid)throws Exception{
		log.info("read 시작");
		return mapper.read(qid);
	}
	@Override
	public boolean update(BoardVO board)throws Exception{
		log.info("update 시작");
		return mapper.update(board) == true;
	}
	
	@Override
	public boolean delte(long qid)throws Exception{
		log.info("delete 시작");
		return mapper.delete(qid) == true;
	}

	
}