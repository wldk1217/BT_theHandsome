package com.thehandsome.domain;

import lombok.Data;

@Data
public class ColorVO {
	private String pid; // 상품 품번
	private String ccolorcode; // 색상 코드
	private String cimage1; // 색상 이미지1
	private String cimage2; // 색상 이미지2
	private String cimage3; // 색상 이미지3
	private String ccolorimage; // 색상 이미지
	private String cmatchpid; // 색상 별 상품매치
}