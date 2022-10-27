package com.theHandsome.controller;

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
import org.springframework.web.context.WebApplicationContext;
import lombok.extern.log4j.Log4j;

/*****************************************************
 * @function : MemberJoinTest2
 * @author : 김민선
 * @Date : 2022.10.18
 *****************************************************/

@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml",
		"file:src/main/webapp/WEB-INF/spring/root-context.xml"}
)
@Log4j
public class MemberJoinTest2 {
	
	@Autowired
	private WebApplicationContext ctx;
	
	private MockMvc mockMvc;
	
	@Before
	public void setup() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
	}//end setup
	
	// parameter 로 받아온 값으로 회원가입
	@Test
	public void memberJoin() throws Exception{
		String resultPage = mockMvc.perform(
				MockMvcRequestBuilders.post("/member/join")
				.param("mid", "test6")
				.param("mpassword", "1234")
				.param("memail", "user123")
				.param("mname", "user")
				.param("mtel", "123")
				.param("mzipcode", "123")
				.param("maddress1", "zzz")
				.param("maddress2", "zzz")
				).andReturn()
				.getModelAndView()
				.getViewName()
				;
		log.info(resultPage);
	}

}