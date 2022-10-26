package com.theHandsome.persistence;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import com.thehandsome.domain.MemberVO;
import com.thehandsome.service.MemberService;

/*****************************************************
 * @function : MemberJoinTest
 * @author : 김민선
 * @Date : 2022.10.18
 *****************************************************/

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")

public class MemberJoinTest {
	
	@Autowired
	private MemberService service;
	
	//회원가입 테스트
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

} 
