package com.thehandsome.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.thehandsome.domain.BoardCriteria;
import com.thehandsome.domain.ReplyVO;
import com.thehandsome.mapper.ReplyMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
/*****************************************************
 * @function : ReplyServiceImpl
 * @author : 구영모
 * @Date : 2022.10.21
 * 댓글에 필요한 DB처리
 *****************************************************/
@Service
@Log4j
public class ReplyServiceImpl implements ReplyService{
	
	@Autowired
	private ReplyMapper mapper;
	//댓글을 삽입해주는 메소드
	@Override
	public int register(ReplyVO vo)throws Exception{
		log.info("register....." + vo);
		return mapper.insert(vo);
	}
	//댓글 하나를 조회하는 메소드
	@Override
	public ReplyVO get(Long rno)throws Exception{
		log.info("get...."+ rno);
		return mapper.read(rno);
	}
	//댓글을 수정하는 메소드
	@Override
	public int modify(ReplyVO vo)throws Exception{
		log.info("modify...."+vo);
		return mapper.update(vo);
	}
	//댓글을 삭제하는 메소드
	@Override
	public int remove(Long rno)throws Exception{
		log.info("remove...." + rno);
		return mapper.delete(rno);
	}
	//댓글의 리스트를 불러오는 메소드
	@Override
	public List<ReplyVO> getList(BoardCriteria cri, Long qid)throws Exception{
		log.info("get Reply List of a Board "+qid);
		return mapper.getListWithPage(cri, qid);
	}
	
}
