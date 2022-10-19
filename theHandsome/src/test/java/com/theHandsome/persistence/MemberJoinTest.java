package com.theHandsome.persistence;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.thehandsome.domain.MemberVO;
import com.thehandsome.mapper.MemberMapper;
import com.thehandsome.service.MemberService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class MemberJoinTest {
	
	@Autowired
	private MemberService service;
	// private MemberMapper mapper;
	
	
	@Test
	public void memberJoin() throws Exception{
		MemberVO member = new MemberVO();
		
		member.setMid("test5");
		member.setMpassword("pw03");
		member.setMemail("test04@naver.com");
		member.setMname("테스트5");
		member.setMtel("0101234333");
		member.setMzipcode("12200");
		member.setMaddress1("테스트 주소3");
		member.setMaddress2("테스트 주소3");
		
		service.memberJoin(member);
	}

}//end class 
