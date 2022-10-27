package com.thehandsome.mapper;

import com.thehandsome.domain.MemberVO;

/*****************************************************
 * @function : MemberMapper
 * @author : 구영모, 김민선, 심지연 공동작업
 * @Date : 2022.10.18 ~ 2022.10.26
 *****************************************************/

public interface MemberMapper {

	public void memberJoin(MemberVO member); // 회원 가입
	
	public int idCheck(String mid); // 아이디 중복 확인
	
	public MemberVO memberLogin(MemberVO member); // 로그인
	
	public int modifyInfo(MemberVO member); // 회원정보 변경
	
	public int memberWithdrawal(MemberVO member); // 회원 탈퇴
	
	//구영모 추가
	public MemberVO read(String mid);//회원 정보 및 권한 불러오기
	
	public void memberAuthJoin(String mid); //회원 권한 테이블 불러오기
}
