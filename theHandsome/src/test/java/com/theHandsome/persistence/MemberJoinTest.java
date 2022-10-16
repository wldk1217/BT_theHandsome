package com.theHandsome.persistence;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.thehandsome.domain.MemberVO;
import com.thehandsome.mapper.MemberMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class MemberJoinTest {
	
	@Autowired
	private MemberMapper mapper;
	
	@Test
	public void memberJoin() throws Exception{
		MemberVO member = new MemberVO();
		
		member.setMid("test01");
		member.setMpassword("pw01");
		member.setMemail("test01@naver.com");
		member.setMname("테스트");
		member.setMtel("01012341234");
		member.setMzipcode("12200");
		member.setMaddress1("테스트 주소1");
		member.setMaddress2("테스트 주소2");
		
		mapper.memberJoin(member);
	}

}//end class 
