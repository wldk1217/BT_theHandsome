package com.thehandsome.domain;

import lombok.Data;
//회원 권한을 가져오기 위한 VO 구영모 작성
@Data
public class AuthVO {
	private String userid;
	private String auth;
}
