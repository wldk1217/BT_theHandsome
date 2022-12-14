package com.thehandsome.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.thehandsome.domain.MemberVO;
import com.thehandsome.mapper.MemberMapper;
import com.thehandsome.security.domain.CustomUser;

import lombok.extern.log4j.Log4j;

/*****************************************************
 * @function : CustomLoginSuccessHandler
 * @author : 구영모
 * @Date : 2022.10.25
 * 사용자가 로그인에 성공하였을 시 발생하는 이벤트를 제어하는 클래스
 * 로그인을 하였을 때 사용자 정보를 담기 위한 클래스
 *****************************************************/

@Log4j
public class CustomUserDetailsService implements UserDetailsService{
	//
	@Autowired
	private MemberMapper membermapper;
	
	//회원 정보를 불러와서 UserDeatils로 리턴
	@Override
	public UserDetails loadUserByUsername(String userName) throws UsernameNotFoundException{
		log.warn("회원 이름 Loaded : "+userName);
		//userName은 mid값을 의미한다
		MemberVO vo = membermapper.read(userName);
		log.warn("Query by memebr maper :" +vo);
		return vo == null ? null : new CustomUser(vo);
	}
}
