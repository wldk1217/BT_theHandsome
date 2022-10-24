package com.thehandsome.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.thehandsome.domain.BoardCriteria;
import com.thehandsome.domain.ReplyVO;
import com.thehandsome.mapper.ReplyMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class ReplyServiceImpl implements ReplyService{
	
	@Autowired
	private ReplyMapper mapper;
	
	@Override
	public int register(ReplyVO vo)throws Exception{
		log.info("register....." + vo);
		return mapper.insert(vo);
	}

	@Override
	public ReplyVO get(Long rno)throws Exception{
		log.info("get...."+ rno);
		return mapper.read(rno);
	}

	@Override
	public int modify(ReplyVO vo)throws Exception{
		log.info("modify...."+vo);
		return mapper.update(vo);
	}

	@Override
	public int remove(Long rno)throws Exception{
		log.info("remove...." + rno);
		return mapper.delete(rno);
	}

	@Override
	public List<ReplyVO> getList(BoardCriteria cri, Long qid)throws Exception{
		log.info("get Reply List of a Board "+qid);
		return mapper.getListWithPage(cri, qid);
	}
	
}
