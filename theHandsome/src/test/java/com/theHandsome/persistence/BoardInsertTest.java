package com.theHandsome.persistence;

import java.util.Date;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.thehandsome.domain.BoardVO;
import com.thehandsome.mapper.BoardMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardInsertTest {
	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;
	
	@Test
	public void testGetList() {
		mapper.getList().forEach(board -> log.info(board));
	}
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
	@Test
	public void testRead() {
		BoardVO board = mapper.read(3L); 
		log.info(board);
	}
	@Test
	public void testDelete() {
		log.info("delete count : "+mapper.delete(3L));
	}
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
}
