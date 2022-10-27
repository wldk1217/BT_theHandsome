package com.thehandsome.security.domain;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import com.thehandsome.domain.MemberVO;

import lombok.Data;
import lombok.extern.log4j.Log4j;

@Log4j
@Data
public class CustomUser  extends User{
	
	//Serialization
	private static final long serialVersionUID = 1L;
	
	private MemberVO member;
	
	public CustomUser(String username, String password, Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities);
	}//end CustomUser...
	
	
	public CustomUser(MemberVO vo) {
		
		super(vo.getMid()
	         ,vo.getMpassword()
			 ,vo.getAuthList().stream()
			  .map(auth -> new SimpleGrantedAuthority(auth.getAuth()))
			  .collect(Collectors.toList()));//end super
		
		this.member = vo;
		log.info(vo);
	}//end CustomUser
	
}//end class
