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

/*****************************************************
 * @function : MemberLoginTest
 * @author : 심지연
 * @Date : 2022.10.18
 *****************************************************/

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class MemberLoginTest {
	
	@Setter(onMethod_ = @Autowired)
	private MemberMapper mapper;
	
	@Test
	public void memberLogin() throws Exception{
		MemberVO member = new MemberVO();
		
		member.setMid("test01");
		member.setMpassword("pw01");
		mapper.memberLogin(member);
		System.out.println("결과 값 : " + mapper.memberLogin(member));
	}
}