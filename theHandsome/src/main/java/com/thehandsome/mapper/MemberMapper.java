package com.thehandsome.mapper;

import com.thehandsome.domain.MemberVO;

/*****************************************************
 * @function : MemberMapper
 * @author : 구영모, 김민선, 심지연 공동작업
 * @Date : 2022.10.18 ~ 2022.10.26
 *****************************************************/

public interface MemberMapper {
	// author:김민선 회원 가입
	public void memberJoin(MemberVO member); 
	//author:김민선 아이디 중복 확인
	public int idCheck(String mid); 
	// author:심지연 로그인
	public MemberVO memberLogin(MemberVO member);
	//author:구영모 회원 정보 및 권한 불러오기
	public MemberVO read(String mid);
	//author:구영모 회원 권한 테이블 불러오기
	public void memberAuthJoin(String mid); 
}
