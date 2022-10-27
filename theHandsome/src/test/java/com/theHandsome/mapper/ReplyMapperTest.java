package com.theHandsome.mapper;

import java.util.Date;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.thehandsome.domain.BoardCriteria;
import com.thehandsome.domain.ReplyVO;
import com.thehandsome.mapper.ReplyMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
/*****************************************************
 * @function : ReplyMapperTest
 * @author : 구영모
 * @Date : 2022.10.22
 *****************************************************/
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ReplyMapperTest {
	
	@Setter(onMethod_ = {@Autowired})
	private ReplyMapper mapper;
	//mapper 연결 테스트
	@Test
	public void testMapper() {
		log.info(mapper);
	}
	//boardVO의 QID값에 따른 댓글 리스트 불러오기
	@Test
	public void testList() {
		BoardCriteria cri = new BoardCriteria();
		List<ReplyVO> replies = mapper.getListWithPage(cri, 100L);
		for(ReplyVO i : replies) {
			log.info(i);
		}//end for
	}
	//mapper insert 테스트
	@Test
	public void testCreate() {
		ReplyVO reply = new ReplyVO();
		//게시물 번호
		long bno=916L;
		reply.setBno(bno);
		reply.setReply("댓글 테스트");
		reply.setReplyer("댓글 테스트");
		mapper.insert(reply);					
	}//end testCreate
	
	//mapper select 테스트
	@Test
	public void testRead() {
		//해당 데이터가 QNAREPLY테이블에 있는지 확인
		Long targetRno = 2L;		
		ReplyVO vo = mapper.read(targetRno);		
		log.info(vo);
	}
	//mapper delete 테스트
	
	@Test
	public void testDelete() {
		//해당 데이터가 tbl_reply에 있는지 확인
		Long targetRno = 5L;		
		mapper.delete(targetRno);			
	}//end testCreate
	
	//mappper update 테스트
	@Test
	public void testUpdate() {
		//2번 데이터를 불러온다
		Long targetRno = 2L;
		ReplyVO vo = mapper.read(targetRno);
		Date date = new Date();
		vo.setReply("Reply Update"); //댓글 데이터 수정
		int count = mapper.update(vo); //변경된 행수 업데이트 후 저장
		log.info("Updated rno : " + count);
	}
}//end class