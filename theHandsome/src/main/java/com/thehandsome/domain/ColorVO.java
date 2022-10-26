package com.thehandsome.domain;

import lombok.Data;

/*****************************************************
 * @function : ColorVO
 * @author : 심지연
 * @Date : 2022.10.19
 ******************************************************/

@Data
public class ColorVO {
	private String pid; // 상품품번
	private String ccolorcode; // 색상코드
	private String cname; // 색상이름
	private String ccolorimage; // 색상이미지
	private String cpreview; // 상품썸네일 (이미지가 깨져서 추후 cimage2로 대체 사용)
	private String cimage1; // 상품이미지1
	private String cimage2; // 상품이미지2
	private String cimage3; // 상품이미지3
	private String cimage4; // 상품이미지4
	private String cimage5; // 상품이미지5
}