package com.thehandsome.service;

import com.thehandsome.domain.MemberVO;

public interface MemberService {
	// 회원가입 
	public void memberJoin(MemberVO member) throws Exception;
	
	// 중복체크
	public int idCheck(String mid);
	
	// 로그인
	public MemberVO memberLogin(MemberVO member) throws Exception;
	
	// 회원 정보 변경
	public int modifyInfo(MemberVO member) throws Exception;
	
	// 회원 탈퇴
	public int memberWithdrawal(MemberVO member) throws Exception;
}
