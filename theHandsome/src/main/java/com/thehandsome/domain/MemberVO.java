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
	private String mid;
	private String mpassword;
	private String mname;
	private String memail;
	private String mtel;
	private String mzipcode;
	private String maddress1;
	private String maddress2;
	private String mgrade;
	private String mdate;
	private String msumprice;
	private String menabled;
	private List<AuthVO> authList;
}
