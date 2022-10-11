package com.thehandsome.domain;

import lombok.Data;

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
}
