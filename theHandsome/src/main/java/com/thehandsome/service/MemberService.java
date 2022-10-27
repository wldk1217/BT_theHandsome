package com.thehandsome.service;

import com.thehandsome.domain.MemberVO;

/*****************************************************
 * @function : MemberService
 * @author : 구영모, 김민선, 심지연 공동작업
 * @Date : 2022.10.18 ~ 2022.10.26
 *****************************************************/

public interface MemberService {

	// author:김민선 회원가입
	public void memberJoin(MemberVO member) throws Exception;

	// author:김민선 아이디 중복체크
	public int idCheck(String mid);

	//author:심지연 로그인
	public MemberVO memberLogin(MemberVO member) throws Exception;

	//author:구영모 회원 가입 시 권한 부여
	public void memberAuthJoin(String mid) throws Exception;
}
