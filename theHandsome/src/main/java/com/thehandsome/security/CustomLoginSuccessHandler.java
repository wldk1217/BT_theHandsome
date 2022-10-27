package com.thehandsome.security;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import com.thehandsome.domain.MemberVO;
import com.thehandsome.mapper.MemberMapper;
import com.thehandsome.service.MemberService;

import lombok.extern.log4j.Log4j;

/*****************************************************
 * @function : CustomLoginSuccessHandler
 * @author : 구영모
 * @Date : 2022.10.25
 * 사용자가 로그인에 성공하였을 시 발생하는 이벤트를 제어하는 클래스
 *****************************************************/

@Log4j
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler {
	@Autowired
	private MemberService memberservice;
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication auth)
			throws IOException, ServletException {
		//로그인 시 받아온 이름값을 username에 저장
		String username = auth.getName();
		log.warn(username+"사용자 로그인 성공");
		
		//사용자의 권한을 가져오기 위한 AuthList
		List<String> roleNames = new ArrayList<>();
		//사용자의 권한을 담아온다
		auth.getAuthorities().forEach(authority -> {
			roleNames.add(authority.getAuthority());
		});//end auth.getAuthorities			
		log.warn("ROLE NAMES: " + roleNames);
		
		//memid라는 세션에 회원의 id(mid)값을 넣는다
		HttpSession session = request.getSession();
		session.setAttribute("memid", username);
	
		//로그인 성공시에 메인 페이지로 이동
		response.sendRedirect("/");
	}//endonAuthenticationSuccess
}//end class
