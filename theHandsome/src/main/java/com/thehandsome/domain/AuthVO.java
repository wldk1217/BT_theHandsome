package com.thehandsome.domain;

import lombok.Data;
/*****************************************************
 * @function : AuthVO
 * @author : 구영모
 * @Date : 2022.10.25
 * 스프링 시큐리티를 적용하기 위해 회원의 권한 정보를 저장하는 테이블인
 * member_auth와 관련된 VO
 *****************************************************/

@Data
public class AuthVO {
	//회원 id -> member테이블의 mid와 매칭
	private String userid;
	//회원의 권한 -> 기본을 ROLE_USER로 세팅
	private String auth;
}
