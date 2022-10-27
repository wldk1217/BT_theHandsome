package com.thehandsome.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;
import lombok.extern.log4j.Log4j;

/*
 * 작성자 : 구영모
 * 기능 : 스프링 시큐리티 엑세스가 거부되었을시에 페이지를 띄우는 기능
 */
@Log4j
public class CustomAccessDeniedHandler implements AccessDeniedHandler{
	@Override
	public void handle(HttpServletRequest request, HttpServletResponse response,
			AccessDeniedException accessDeniedException) throws IOException, ServletException {
		log.error("Access Denied Handerr");
		log.error("Redirect...");
		
		response.sendRedirect("/accessError");
		
	}	
}