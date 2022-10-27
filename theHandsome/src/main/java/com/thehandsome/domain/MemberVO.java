package com.thehandsome.domain;

import java.util.List;

import lombok.Data;

/*****************************************************
 * @function : MemberVO
 * @author : 구영모, 김민선, 심지연 공동작업
 * @Date : 2022.10.17
 *****************************************************/

@Data
public class MemberVO {
	// 회원 id
	private String mid;
	// 회원 비밀번호
	private String mpassword;
	// 회원 이름
	private String mname;
	// 회원 이메일
	private String memail;
	// 회원 전화번호
	private String mtel;
	//회원 우편번호
	private String mzipcode;
	// 회원 주소1
	private String maddress1;
	// 회원 주소2
	private String maddress2;
	// 회원 등급
	private String mgrade;
	// 회원 가입일
	private String mdate;
	// 회원 누적금액 
	private String msumprice;
	// 관리자 여부
	private String menabled;
	// 회원 권한 : security 
	private List<AuthVO> authList;
}
