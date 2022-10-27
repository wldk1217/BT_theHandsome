package com.theHandsome.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.theHandsome.mapper.MemberMapperTests;
import com.thehandsome.domain.AuthVO;
import com.thehandsome.domain.MemberVO;
import com.thehandsome.service.MemberService;

import lombok.extern.log4j.Log4j;

/*****************************************************
 * @function : MemberJoinTest
 * @author : 김민선
 * @Date : 2022.10.18
 *****************************************************/

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({
	"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	 "file:src/main/webapp/WEB-INF/spring/security-context.xml"})
@Log4j
public class MemberJoinTest {
	
	@Autowired
	private MemberService service;
	@Autowired
	private PasswordEncoder pwencoder;
	
	//회원가입 테스트
	@Test
	public void memberJoin() throws Exception{
		MemberVO member = new MemberVO();
		AuthVO auth = new AuthVO();
		
		member.setMid("test");
		member.setMpassword("test");
		member.setMemail("asdfa@naver.com");
		member.setMname("테스트5");
		member.setMtel("0101234333");
		member.setMzipcode("12200");
		member.setMaddress1("테스트 주소3");
		member.setMaddress2("테스트 주소3");
		String mid = member.getMid();
		service.memberJoin(member);
		service.memberAuthJoin(mid);
	}

} 
