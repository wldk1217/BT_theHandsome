package com.thehandsome.security.domain;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import com.thehandsome.domain.MemberVO;

import lombok.Data;
import lombok.extern.log4j.Log4j;
/*****************************************************
 * @function : CustomUser
 * @author : 구영모
 * @Date : 2022.10.25
 * User를 커스텀 하여 CustomUser클래스 작성
 *****************************************************/
@Log4j
@Data
public class CustomUser  extends User{
	
	//Serialization
	private static final long serialVersionUID = 1L;
	
	private MemberVO member;
	//회원 id, password, 권한을 가져온다 
	public CustomUser(String username, String password, Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities);
	}//end CustomUser...
	
	//MemberVO를 불러와 회원 id, password, 권한을 가져온다.
	public CustomUser(MemberVO vo) {		
		super(vo.getMid()
	         ,vo.getMpassword()
			 ,vo.getAuthList().stream()
			  .map(auth -> new SimpleGrantedAuthority(auth.getAuth()))
			  .collect(Collectors.toList()));//end super
		
		this.member = vo;
	}//end CustomUser
	
}//end class
