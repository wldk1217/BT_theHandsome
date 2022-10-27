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
/*****************************************************
 * @function : MemberMapperTests
 * @author : 구영모
 * @Date : 2022.10.25
 * 로그인 시큐리티 관련 테스트
 *****************************************************/
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({
	"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	 "file:src/main/webapp/WEB-INF/spring/security-context.xml"})
@Log4j
public class MemberMapperTests {
	//MemberMapper 클래스 사용
	@Autowired
	private MemberMapper mapper;
	//비밀번호 인코딩
	@Autowired
	private PasswordEncoder pwencoder;
	//회원 정보 권한과 함께 불러오기 테스트
	@Test
	public void testRead() {
		MemberVO vo = mapper.read("test02");	
		log.info(vo);		
		vo.getAuthList().forEach(authVO -> log.info(authVO));			
	}//end testRead()
	//회원가입을 할때 회원 권한을 같이 부여하기 위한 기능 테스트
	@Test
	public void testinsertAuth() {
		String mid = "asd";
		mapper.memberAuthJoin(mid);		
	}
}//end class
