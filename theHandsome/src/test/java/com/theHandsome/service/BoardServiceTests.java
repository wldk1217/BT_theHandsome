package com.theHandsome.service;

import static org.junit.Assert.assertNotNull;

import java.util.Date;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.thehandsome.domain.BoardCriteria;
import com.thehandsome.domain.BoardVO;
import com.thehandsome.service.BoardService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;


/*****************************************************
 * @function : BoardService 비즈니스 테스트
 * @author : 구영모
 * @Date : 2022.10.17
 ******************************************************/

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardServiceTests {
	@Setter(onMethod_ = {@Autowired })
	private BoardService service;
	//BoardService 객체 주입 테스트
	Date day = new Date();
	@Test
	public void testExist() {
		log.info(service);
		assertNotNull(service);
	}
	@Test
	public void testGetList() throws Exception{
//		service.getList().forEach(board -> log.info(board));
		service.getListWithPaging(new BoardCriteria(2,10)).forEach(board->log.info(board));
	}
	@Test
	public void insertTest() throws Exception {
		BoardVO board = new BoardVO();
		board.setMid("test02");
		board.setQtitle("새로 작성 하는 글");
		board.setQcontent("새로 작성하는 내용");
		board.setQdate(day);
		service.insert(board);
		log.info("게시물 생성");
	}
	@Test 
	public void testRead() throws Exception{
		log.info(service.read(1L));
		log.info("게시판 read 완료");
	}
	@Test
	public void testUpdate() throws Exception{
		BoardVO board = service.read(4L);
		if(board==null) {
			return;
		}
		board.setQtitle("제목 수정");
		log.info("수정 : " + service.update(board));
	}
	@Test
	public void testDelete() throws Exception{
		log.info(service.delte(4L));
		log.info("delte 완료");
	}
}
