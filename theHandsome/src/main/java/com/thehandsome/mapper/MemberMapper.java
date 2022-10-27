package com.thehandsome.mapper;

import com.thehandsome.domain.MemberVO;

/* 
 *  회원과 관련한 SQL을 호출하기 위한 인터페이스
 */
public interface MemberMapper {

	public void memberJoin(MemberVO member); // 회원 가입
	
	 public int idCheck(String mid); // 아이디 중복 확인
	
	public MemberVO memberLogin(MemberVO member); // 로그인
	
	public int modifyInfo(MemberVO member); // 회원정보 변경
	
	public int memberWithdrawal(MemberVO member); // 회원 탈퇴
	//구영모 추가
	public MemberVO read(String mid);//회원 정보 및 권한 불러오기
}
