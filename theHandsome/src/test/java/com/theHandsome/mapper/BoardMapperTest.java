package com.theHandsome.mapper;

import java.util.Date;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.thehandsome.domain.BoardCriteria;
import com.thehandsome.domain.BoardVO;
import com.thehandsome.mapper.BoardMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
/*****************************************************
 * @function : BoradMapperTest
 * @author : 구영모
 * @Date : 2022.10.20
 *****************************************************/
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({
	"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	 "file:src/main/webapp/WEB-INF/spring/security-context.xml"})
@Log4j
public class BoardMapperTest {
	//게시판 Mapper 사용
	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;
	//게시판 삽입 테스트
	@Test
	public void testInsert() {
		Date day = new Date();
		BoardVO board = new BoardVO();
		board.setMid("test01");
		board.setQtitle("테스트03");
		board.setQcontent("테스트중");
		board.setQdate(day);
		mapper.insert(board);
		log.info(board);
	}
	//게시판 조회 테스트
	@Test
	public void testRead() {
		BoardVO board = mapper.read(3L); 
		log.info(board);
	}
	//게시판 삭제 테스트
	@Test
	public void testDelete() {
		log.info("delete count : "+mapper.delete(3L));
	}
	//게시판 수정 테스트
	@Test
	public void testUpdate() {
		Date day = new Date();
		BoardVO board = new BoardVO();
		board.setQtitle("수정된 제목");
		board.setQcontent("수정된 내용");
		board.setQdate(day);
		board.setQid(3L);
		
		boolean count = mapper.update(board);
		log.info("update count : " + count);
	}
	//게시판 페이징 테스트
	@Test
	public void testPaging() {
		BoardCriteria cri = new BoardCriteria();
		//10개씩 3페이지
		cri.setPageNum(3);
		cri.setAmount(10);
		List<BoardVO> list = mapper.getListWithPaging(cri);
		
		list.forEach(board -> log.info(board.getQid()));
	}
}
