package com.theHandsome.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.ui.ModelMap;
import org.springframework.web.context.WebApplicationContext;

import com.thehandsome.mapper.BoardMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@Log4j
public class BoardControllerTests {	
	@Setter(onMethod_ = {@Autowired})
	private WebApplicationContext ctx;
	
	private MockMvc mockMvc;
	
	@Before
	public void setUp() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();		
	}//end setup
	
	@Test
	public void testList() throws Exception {
		log.info(
				mockMvc.perform(MockMvcRequestBuilders.get("/board/list")
				.param("pageNum","2")
				.param("amount","10"))
				.andReturn().getModelAndView().getModelMap());
		
	}//end testList
	
	@Test
	public void testInsert() throws Exception {
		DateFormat sdFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date nowDate = new Date();
		String today = sdFormat.format(nowDate);
		String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/board/insert")
				.param("mid", "test01")
				.param("qtitle", "새글 테스트 제목")
				.param("qcontent", "테스트 새글 내용")
				.param("qdate", today)
				).andReturn().getModelAndView().getViewName();
		log.info(resultPage);		
	}//end testInsert
	
	@Test
	public void testRead() throws Exception {
		log.info(
				mockMvc.perform(
				MockMvcRequestBuilders.get("/board/read")
				.param("qid", "1")				
				).andReturn()
				.getModelAndView()
				.getModelMap()
				);		
	}//end testList
	@Test
	public void testUpdate() throws Exception{
		DateFormat sdFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date nowDate = new Date();
		String today = sdFormat.format(nowDate);
		String resultPage = mockMvc
				.perform(MockMvcRequestBuilders.post("/board/update")				
				.param("qtitle", "수정된 제목")
				.param("qcontent", "수정된 내용")
				.param("qdate", today)
				.param("qid","1")
				).andReturn().getModelAndView().getViewName();
		log.info(resultPage);	
	}
	
	@Test
	public void testDelete()throws Exception{
		String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/board/delete")
				.param("qid", "2")
		).andReturn().getModelAndView().getViewName();
		log.info(resultPage);
	}
}//end class
