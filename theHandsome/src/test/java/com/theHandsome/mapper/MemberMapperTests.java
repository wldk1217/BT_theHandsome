package com.theHandsome.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.thehandsome.domain.MemberVO;
import com.thehandsome.mapper.MemberMapper;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({
	"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	 "file:src/main/webapp/WEB-INF/spring/security-context.xml"})
@Log4j
public class MemberMapperTests {
	
	@Autowired
	private MemberMapper mapper;
	@Autowired
	private PasswordEncoder pwencoder;
	
	
	@Test
	public void testRead() {
		MemberVO vo = mapper.read("test02");	
		log.info(vo);		
		vo.getAuthList().forEach(authVO -> log.info(authVO));			
	}//end testRead()
}//end class
